import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';
import 'package:pak_admin/pages/navigation.dart';
import 'package:pak_admin/services/menu_service.dart';
import 'package:pak_admin/widgets/toppings_list.dart';

import '../widgets/checkbox_tile.dart';
import '../widgets/custom_textfield.dart';

class MenuAddPage extends StatefulWidget {
  MenuAddPage(
      {super.key,
      this.id,
      this.menuInfo,
      required this.category,
      required this.catIndex});
  String? id;
  MenuInfo? menuInfo;
  String category;
  int catIndex;

  @override
  State<MenuAddPage> createState() => _MenuAddPageState();
}

class _MenuAddPageState extends State<MenuAddPage> {
  bool _isRecommend = false;
  bool isEdit = false;
  double hot = -1;
  double ice = -1;
  double frappe = -1;
  List<Topping> toppings = [];

  @override
  void initState() {
    super.initState();
    if (widget.menuInfo != null) {
      isEdit = true;
      hot = widget.menuInfo!.status.hot;
      ice = widget.menuInfo!.status.ice;
      frappe = widget.menuInfo!.status.frappe;
      toppings = widget.menuInfo!.toppings!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    MenuService menuService = MenuService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? widget.menuInfo!.name : 'เมนู',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  width: width,
                  height: heightScreen * 0.3,
                ),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ))
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  // Name Textfield
                  CustomTextField(
                    'ชื่อ',
                    value: isEdit ? widget.menuInfo!.name : null,
                    controller: nameController,
                  ),
                  // Price Textfield
                  CustomTextField(
                    'ราคา',
                    value: isEdit ? widget.menuInfo!.price.toString() : null,
                    controller: priceController,
                  ),
                ],
              ),
            ),
            // Status
            CheckBoxTile('ร้อน', onChanged: (price) {
              hot = price;
            }, price: hot),
            CheckBoxTile('เย็น', onChanged: (price) {
              ice = price;
            }, price: ice),
            CheckBoxTile('ปั่น', onChanged: (price) {
              frappe = price;
            }, price: frappe),
            //* Topping
            Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: const Text('ท็อปปิง')),
            ToppingLists(
              toppings: toppings,
              onAccept: (value) {
                toppings = value;
              },
            ),
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
                        //TODO: Send menulist
                        Status status =
                            Status(frappe: frappe, hot: hot, ice: ice);
                        menuService.updateMenu(
                          id: widget.id ?? '',
                          catIndex: widget.catIndex,
                          category: widget.category,
                          isEdit: isEdit,
                          isRecommend: _isRecommend,
                          name: nameController.text,
                          price: priceController.text,
                          status: status,
                          toppings: toppings,
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const NavaigationPage(),
                            ),
                            ModalRoute.withName('/'));
                      },
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
