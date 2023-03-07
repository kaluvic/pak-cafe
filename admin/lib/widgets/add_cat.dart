import 'package:flutter/material.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('ชื่อประเภท'),
        const TextField(),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
                onPressed: null,
                child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: const Text('ยืนยัน'))))
      ]),
    );
  }
}
