import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
	const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

	final _passwordVisibilityNotifier = ValueNotifier<bool>(false);

	@override
  void dispose() {
		_passwordVisibilityNotifier.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				children: [
					Expanded(
						child: Center(
							child: ConstrainedBox(
								constraints: BoxConstraints(
									maxWidth: 230
								),
								child: Image.asset('assets/images/logo.png')
							),
						),
					),
					Expanded(
						flex: 1,
						child: Center(
						  child: Padding(
						    padding: const EdgeInsets.symmetric(
						  		horizontal: 14
						  	),
						    child: ConstrainedBox(
						  		constraints: BoxConstraints(
						  			maxWidth: 400
						  		),
						  		child: Column(
						  			mainAxisSize: MainAxisSize.min,
						  			children: [
											Text(
												'Login',
												style: TextStyle(
													fontSize: 26,
													fontWeight: FontWeight.w700
												),
											),
											const SizedBox(height: 30,),
						  				TextField(
						  					decoration: InputDecoration(
						  						labelText: 'E-mail'
						  					),
						  				),
						  				const SizedBox(height: 18,),
						  				ValueListenableBuilder<bool>(
												valueListenable: _passwordVisibilityNotifier,
												builder: (context, value, child) {
													return TextField(
														obscureText: value,
														decoration: InputDecoration(
															labelText: 'Senha',
															suffixIcon: IconButton(
																icon: Icon(value ? Icons.visibility : Icons.visibility_off),
																onPressed: () {
																	_passwordVisibilityNotifier.value = !value;
																},
															)
														),
													);
												}
											),
											const SizedBox(height: 12,),
						  				Align(
						  					alignment: Alignment.bottomRight,
						  					child: TextButton(
						  						onPressed: () {},
						  						child: Padding(
						  							padding: const EdgeInsets.symmetric(
						  								horizontal: 10
						  							),
						  							child: Text(
						  								'Esqueceu sua senha?'
						  							),
						  						),
						  					),
						  				)
						  			],
						  		),
						  	),
						  ),
						),
					),
					Expanded(
						child: Center(
							child: ConstrainedBox(
							  constraints: BoxConstraints(maxWidth: 400),
							  child: SizedBox(
							    width: double.infinity,
							    child: ElevatedButton(
										onPressed: () {},
										child: Padding(
										  padding: const EdgeInsets.symmetric(
												vertical: 14
											),
										  child: Text(
												'Entrar',
												style: TextStyle(
													fontSize: 16
												),
											),
										),
									),
							  ),
							),
						),
					)
				],
			),
		);
	}
}