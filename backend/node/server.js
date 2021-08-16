'use strict';

const { GraphQLClient } = require('graphql-request')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const express = require('express')
const fs = require('fs')
 
const app = express()
app.use(express.json())

const privateKey = fs.readFileSync('./.private.key', 'utf-8');

const graphql = new GraphQLClient(process.env.HASURA_GRAPHQL_URL, {
  headers: { 'X-Hasura-Admin-Secret': process.env.HASURA_ADMIN_SECRET }
})

const QUERY_EMPLOYEE_BY_EMAIL = `
query($email: String!) {
	employee(where:{email: {_eq: $email}}) { id password }
}
`

const SIGNUP = `
mutation($employee: employee_insert_input!) {
	insert_employee_one(object: $employee) { id }
}
`

const signEmployeeToken = function(employee) {
	const signOptions = {
		issuer: 'rings',
		expiresIn: '1h',
		algorithm: 'RS256'
	};
	const token = jwt.sign({
		employeeId: employee.id,
		'https://hasura.io/jwt/claims': {
			'x-hasura-user-id': employee.id.toString(),
			'x-hasura-default-role': 'employee',
			'x-hasura-allowed-roles': ['employee']
		}
	}, privateKey, signOptions);
	return token
}

app.post('/signin', async (req, res) => {
	try {
		const { email, password } = req.body.input;
		
		const employee = await graphql.request(QUERY_EMPLOYEE_BY_EMAIL, { email })
			.then(data => { return data.employee[0]; });
		
		if (!employee) {
			return res.status(400).json({ message: "Email not found" });
		}

		const valid = await bcrypt.compare(password, employee.password);
		if (valid) {
			const token = signEmployeeToken(employee);

			return res.json({
				token: token,
				employee_id: employee.id
			})
		} else {
			return res.status(400).json({ message: "Invalid password" });
		}
	} catch(e) {
		return res.status(400).json({ message: "An error happened", ea: e.toString() });
	}
});

app.post('/signup', async (req, res) => {
	try {
		const { email, password, name, image } = req.body.input;

		const hashedPassword = await bcrypt.hash(password, 10);

		const employee = await graphql.request(SIGNUP, { employee: {
			name: name,
			email: email,
			image: image,
			password: hashedPassword
		}}).then(data => { return data.insert_employee_one });

		const token = signEmployeeToken(employee);

		return res.json({
			token: token,
			employee_id: employee.id
		})
	} catch(e) {
		return res.status(400).json({ message: "An error happened" });
	}
});

app.listen(process.env.SERVER_PORT ?? 8000);
