import 'package:flutter/material.dart';
import 'package:pak_admin/widgets/toppings_list.dart';

class MenuAddPage extends StatefulWidget {
  MenuAddPage({super.key, this.title});
  String? title;

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
        title: Text(widget.title ?? 'เมนู'),
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
                  CustomTextField('ชื่อ'),
                  // Price
                  CustomTextField('ราคา'),
                ],
              ),
            ),
            // Status
            const CheckBoxList(),
            // Topping
            const ToppingsList(),
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
          title: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Text('ร้อน')),
              _isSelectedHot
                  ? const SizedBox(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Price'),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
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
          title: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Text('เย็น')),
              _isSelectedCold
                  ? const SizedBox(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Price'),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
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
          title: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Text('ปั่น')),
              _isSelectedFrappe
                  ? const SizedBox(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Price'),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
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
