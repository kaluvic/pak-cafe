import 'package:flutter/material.dart';
import 'package:pak_admin/pages/navigation.dart';
import 'package:pak_admin/services/menu_service.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _textEditingController = TextEditingController();
  final MenuService _menuService = MenuService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('ชื่อประเภท'),
        TextField(
          controller: _textEditingController,
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  _menuService.updateCategory(_textEditingController.text);
                  _textEditingController.clear();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('เสร็จสิ้น'),
                      content: const Text('เพิ่มประเภทเรียบร้อย'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NavaigationPage(),
                                    ));
                              });
                            },
                            child: const Text('ยืนยัน'))
                      ],
                    ),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: const Text('ยืนยัน'))))
      ]),
    );
  }
}
