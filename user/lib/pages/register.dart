import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailForm = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late String _password;

  late String name;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        actions: <Widget>[
          IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back_ios))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('images/MyIcon.jpg'),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid name.';
                      }
                      name = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty || !_emailForm.hasMatch(value)) {
                        return 'Invalid Email.';
                      }
                      email = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Invalid Password.';
                      }
                      _password = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    validator: (value) {
                      if (value!.isEmpty || value != _password) {
                        return 'Password not match.';
                      }
                      password = value;
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing')));
                        }
                      },
                      child: const Text('Register'))
                ],
              ))
        ],
      )),
    );
  }
}
