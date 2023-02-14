import 'package:flutter/material.dart';

class MenuAddPage extends StatefulWidget {
  const MenuAddPage({super.key});

  @override
  State<MenuAddPage> createState() => _MenuAddPageState();
}

class _MenuAddPageState extends State<MenuAddPage> {
  bool _isRecommend = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('เมนู'),
        centerTitle: true,
      ),
      body: Column(
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
          CustomTextField('ชื่อ'),
          // Price
          CustomTextField('ราคา'),
          // Status
          const CheckBoxList(),
          // Topping
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
          ElevatedButton(onPressed: () {}, child: const Text('Confirm'))
        ],
      ),
    );
  }
}

class CheckBoxList extends StatefulWidget {
  const CheckBoxList({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckBoxList> createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  bool _isSelectedHot = false;

  bool _isSelectedCold = false;

  bool _isSelectedFrappe = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Checkbox(
            value: _isSelectedHot,
            onChanged: (value) {
              setState(() {
                _isSelectedHot = value!;
              });
            },
          ),
          title: const Text('ร้อน'),
          trailing: _isSelectedHot
              ? const SizedBox(
                  width: 50,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Price'),
                  ),
                )
              : null,
        ),
        ListTile(
          leading: Checkbox(
            value: _isSelectedCold,
            onChanged: (value) {
              setState(() {
                _isSelectedCold = value!;
              });
            },
          ),
          title: const Text('เย็น'),
          trailing: _isSelectedCold
              ? const SizedBox(
                  width: 50,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Price'),
                  ),
                )
              : null,
        ),
        ListTile(
          leading: Checkbox(
            value: _isSelectedFrappe,
            onChanged: (value) {
              setState(() {
                _isSelectedFrappe = value!;
              });
            },
          ),
          title: const Text('ปั่น'),
          trailing: _isSelectedFrappe
              ? const SizedBox(
                  width: 50,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Price'),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(
    this.title, {
    Key? key,
  }) : super(key: key);
  late String title = 'NULL';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const TextField(),
      ],
    );
  }
}
