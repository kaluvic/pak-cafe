import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

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
  var uuid = const Uuid();
  final dbRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          Container(
            margin:
                const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 40),
            child: SafeArea(
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
                          decoration:
                              const InputDecoration(labelText: 'Password'),
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
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password'),
                          validator: (value) {
                            if (value!.isEmpty || value != _password) {
                              return 'Password not match.';
                            }
                            password = value;
                            return null;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  dbRef.child("user").update({
                                    uuid.v4(): {
                                      "name": name,
                                      "email": email,
                                      "password": password,
                                      "credit": 0
                                    }
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing')));
                                }
                              },
                              child: const Text('สมัครสมาชิค')),
                        )
                      ],
                    ))
              ],
            )),
          ),
        ],
      ),
    );
  }
}
