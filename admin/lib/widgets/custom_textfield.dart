import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.title, {Key? key, this.value, required this.controller})
      : super(key: key);
  late String title;
  String? value;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    controller.text = value ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          controller: controller,
        ),
      ],
    );
  }
}
