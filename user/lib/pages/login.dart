import 'package:flutter/material.dart';
import 'package:pak_user/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailForm = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset('images/MyIcon.jpg'),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty || !emailForm.hasMatch(value)) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Invalid Password';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: (() {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing')));
                        }
                      }),
                      child: const Text('Login'))
                ],
              )),
          TextButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              }),
              child: const Text('Register'))
        ],
      )),
    );
  }
}
