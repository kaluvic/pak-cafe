/// ธัชทร วงศ์ไชย 620510601
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
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: controller,
        ),
      ],
    );
  }
}
