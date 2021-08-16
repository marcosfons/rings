import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/password_check/password_check_controller.dart';

class PasswordCheckScreen extends StatefulWidget {
  const PasswordCheckScreen({Key? key}) : super(key: key);

  @override
  _PasswordCheckScreenState createState() => _PasswordCheckScreenState();
}

class _PasswordCheckScreenState extends State<PasswordCheckScreen> {
  bool _hidden = true;

  void _toggle() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PasswordCheckController>();

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.red,
          title: Text(
            'Digite a Senha',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              controller.client.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            obscureText: _hidden,
            decoration: InputDecoration(
                labelText: 'senha',
                suffixIcon: IconButton(
                  icon: Icon(_hidden ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    _toggle(); //_hidden = !_hidden;
                  },
                )),
          )
        ],
      ),
    );
  }
}
