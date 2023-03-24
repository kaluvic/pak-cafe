/// ธัชทร วงศ์ไชย 620510601
/// CheckBoxTile
/// Widget สำหรับสร้างการเลือกสถานะร้อน เย็น ปั่น

import 'package:flutter/material.dart';

typedef CallBack = Function(double);

class CheckBoxTile extends StatefulWidget {
  CheckBoxTile(this.name, {super.key, this.price, this.onChanged});
  double? price = -1;
  String name;
  CallBack? onChanged;

  @override
  State<CheckBoxTile> createState() => _CheckBoxTileState();
}

class _CheckBoxTileState extends State<CheckBoxTile> {
  TextEditingController controller = TextEditingController();
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.price! < 0) {
      controller.clear();
    } else {
      controller.text = widget.price.toString();
    }
    isSelected = widget.price! >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            isSelected = value!;
            if (!isSelected) {
              widget.onChanged!(-1);
              controller.clear();
            }
          });
        },
      ),
      title: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: Text(widget.name)),
          isSelected
              ? SizedBox(
                  width: 50,
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      if (isSelected && value.isNotEmpty) {
                        widget.onChanged!(double.parse(value));
                      } else {
                        widget.onChanged!(-1);
                      }
                    },
                    decoration: const InputDecoration(hintText: 'Price'),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
