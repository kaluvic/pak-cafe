import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';
import 'package:pak_admin/widgets/toppings_list.dart';

class MenuAddPage extends StatefulWidget {
  MenuAddPage({super.key, this.id, this.menuInfo});
  String? id;
  MenuInfo? menuInfo;

  @override
  State<MenuAddPage> createState() => _MenuAddPageState();
}

class _MenuAddPageState extends State<MenuAddPage> {
  bool _isRecommend = false;
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.menuInfo != null) {
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? widget.menuInfo!.name : 'เมนู'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pic add
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  width: width,
                  height: 300,
                ),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ))
              ],
            ),
            // Name
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  CustomTextField(
                    'ชื่อ',
                    value: isEdit ? widget.menuInfo!.name : null,
                    controller: nameController,
                  ),
                  // Price
                  CustomTextField(
                    'ราคา',
                    value: isEdit ? widget.menuInfo!.price.toString() : null,
                    controller: priceController,
                  ),
                ],
              ),
            ),
            // Status
            CheckBoxTile('ร้อน',
                price: isEdit ? widget.menuInfo!.status.hot : -1),
            CheckBoxTile('เย็น',
                price: isEdit ? widget.menuInfo!.status.ice : -1),
            CheckBoxTile('ปั่น',
                price: isEdit ? widget.menuInfo!.status.frappe : -1),
            // Topping
            ToppingsList(toppings: isEdit ? widget.menuInfo!.toppings! : []),
            // Recommend
            ListTile(
              leading: Checkbox(
                value: _isRecommend,
                onChanged: (value) {
                  setState(() {
                    _isRecommend = value!;
                  });
                },
              ),
              title: const Text('เลือกเป็นรายการแนะนำ'),
            ),
            // Button
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckBoxTile extends StatefulWidget {
  CheckBoxTile(this.name, {super.key, this.price});
  double? price = -1;
  String name;

  @override
  State<CheckBoxTile> createState() => _CheckBoxTileState();
}

class _CheckBoxTileState extends State<CheckBoxTile> {
  TextEditingController controller = TextEditingController();
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    controller.text = widget.price.toString();
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
                    decoration: const InputDecoration(hintText: 'Price'),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

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
