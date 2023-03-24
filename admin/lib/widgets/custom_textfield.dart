/// ธัชทร วงศ์ไชย 620510601
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(this.title, {Key? key, this.value, required this.controller})
      : super(key: key);
  late String title;
  String? value;
  late TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    widget.controller.text = widget.value ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: widget.controller,
        ),
      ],
    );
  }
}
