import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pak_user/pages/navigation.dart';
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
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 40),
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
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty || !emailForm.hasMatch(value)) {
                          return 'Invalid Email';
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
                          return 'Invalid Password';
                        }
                        password = value;
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 20, right: 20, bottom: 20),
                      child: ElevatedButton(
                          onPressed: (() {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing')));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NavaigationPage()));
                            }
                          }),
                          child: const Text('เข้าสู่ระบบ')),
                    )
                  ],
                )),
            TextButton(
                onPressed: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()));
                }),
                child: const Text('สมัครสมาชิก'))
          ],
        ),
      )),
    );
  }
}
