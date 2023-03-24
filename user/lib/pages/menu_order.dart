/// ธัชทร วงศ์ไชย 620510601
/// MenuOrderPage
/// หน้าจอสำหรับสั่งซื้อเครื่องดื่ม

import 'package:flutter/material.dart';
import 'package:pak_user/entities/cart_entity.dart';
import 'package:pak_user/entities/menuinfo_entity.dart';
import 'package:pak_user/services/cart_service.dart';

typedef StringCallback = void Function(String value);
typedef FuncCallback = void Function();
typedef ToppingCallback = void Function(double value, String name);

class MenuOrderPage extends StatefulWidget {
  MenuOrderPage({super.key, required this.menuInfo, required this.menuid});
  late MenuInfo menuInfo;
  late String menuid;

  @override
  State<MenuOrderPage> createState() => _MenuOrderPageState();
}

class _MenuOrderPageState extends State<MenuOrderPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _statusValue = '1';
  String note = '';
  int _number = 1;
  double basePrice = 0;
  double statusPrice = 0;
  double toppingsPrice = 0;
  List<String> toppings = [];

  @override
  void initState() {
    super.initState();
    basePrice = widget.menuInfo.price;
  }

  void changeStatus(String value, double price) {
    setState(() {
      _statusValue = value;
      statusPrice = price;
    });
  }

  void decreaseNumber() {
    CartService cartService = CartService();
    setState(() {
      if (_number >= 1) {
        _number -= 1;
      }
    });
  }

  void increaseNumber() {
    setState(() {
      _number += 1;
    });
  }

  void onConfirmOrder() {
    CartService cartService = CartService();
    Map<String, String> statusMap = {
      "1": "ร้อน",
      "2": "เย็น",
      "3": "ปั่น",
    };
    String toppingsText = toppings.join(',');
    note = _textEditingController.text;
    String? drinkStatus = statusMap[_statusValue];
    double total = (basePrice + statusPrice + toppingsPrice) * _number;
    Item item = Item(
      itemId: widget.menuid,
      name: widget.menuInfo.name,
      count: _number,
      note: note,
      status: drinkStatus!,
      toppings: toppingsText,
      price: total,
    );
    if (_number > 0) {
      cartService.addToCart(item);
    } else {
      cartService.removeFromCart(widget.menuid);
    }
    Navigator.of(context).pop();
  }

  void addToppingPrice(double price, String name) {
    setState(() {
      toppingsPrice += price;
      toppings.add(name);
    });
  }

  void subToppingPrice(double price, String name) {
    setState(() {
      toppingsPrice -= price;
      toppings.remove(name);
    });
  }

  List<ToppingCheckbox> generateToppings() {
    return List<ToppingCheckbox>.generate(
      widget.menuInfo.toppings!.length,
      (index) => ToppingCheckbox(
        widget.menuInfo.toppings![index].name,
        price: widget.menuInfo.toppings![index].price,
        addToppingsPrice: addToppingPrice,
        subToppingsPrice: subToppingPrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.menuInfo.name,
            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Image
              SizedBox(
                height: heightScreen * 0.3,
                width: widthScreen,
                child: Image.asset(
                  'assets/images/pic.png',
                  fit: BoxFit.cover,
                ),
              ),
              //* Price
              Container(
                margin:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                alignment: Alignment.centerRight,
                child: Text(
                  '${widget.menuInfo.price}',
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              //* List
              Column(
                children: [
                  StatusRadiobox('ร้อน',
                      price: widget.menuInfo.status.hot,
                      value: '1', onButtonChecked: (value) {
                    changeStatus(value, widget.menuInfo.status.hot);
                  }, groupValue: _statusValue),
                  StatusRadiobox('เย็น',
                      price: widget.menuInfo.status.ice,
                      value: '2', onButtonChecked: (value) {
                    changeStatus(value, widget.menuInfo.status.ice);
                  }, groupValue: _statusValue),
                  StatusRadiobox('ปั่น',
                      price: widget.menuInfo.status.frappe,
                      value: '3', onButtonChecked: (value) {
                    changeStatus(value, widget.menuInfo.status.frappe);
                  }, groupValue: _statusValue),
                ],
              ),
              //* Topping
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: const Text(
                        'เพิ่มท็อปปิง',
                        style: TextStyle(fontSize: 24.0),
                      )),
                  Column(
                    children: widget.menuInfo.toppings!.isNotEmpty
                        ? generateToppings()
                        : [
                            Container(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: const ListTile(
                                title: Text('ไม่มีท็อปปิ้ง'),
                              ),
                            )
                          ],
                  )
                ],
              ),
              //* Note
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Note',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      maxLines: 6,
                      maxLength: 300,
                      controller: _textEditingController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    )
                  ],
                ),
              ),
              //* Number of order
              NumberOrder(
                _number,
                onMinusTap: () {
                  decreaseNumber();
                },
                onPlusTap: () {
                  increaseNumber();
                },
              ),
              //* Total
              Center(
                  child: Text(
                'ราคารวม ${(basePrice + statusPrice + toppingsPrice) * _number} บาท',
                style: const TextStyle(fontSize: 20),
              )),
              //* Confirm button
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: SizedBox(
                  width: 400.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: onConfirmOrder,
                    child: const Text('ยืนยัน'),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class NumberOrder extends StatelessWidget {
  NumberOrder(
    this.number, {
    Key? key,
    required this.onMinusTap,
    required this.onPlusTap,
  }) : super(key: key);
  int number = 1;
  final FuncCallback onMinusTap;
  final FuncCallback onPlusTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              onMinusTap();
            },
            icon: const Text(
              '-',
              style: TextStyle(fontSize: 20),
            )),
        Text(
          '$number',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
            onPressed: () {
              onPlusTap();
            },
            icon: const Text(
              '+',
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  }
}

class ToppingCheckbox extends StatefulWidget {
  ToppingCheckbox(this.toppingName,
      {super.key,
      required this.price,
      required this.addToppingsPrice,
      required this.subToppingsPrice});
  late String toppingName = 'TOPPING_NAME';
  late double price = 0;
  final ToppingCallback addToppingsPrice;
  final ToppingCallback subToppingsPrice;

  @override
  State<ToppingCheckbox> createState() => _ToppingCheckboxState();
}

class _ToppingCheckboxState extends State<ToppingCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.toppingName),
      leading: Checkbox(
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value!;
            if (_value) {
              widget.addToppingsPrice(widget.price, widget.toppingName);
            } else {
              widget.subToppingsPrice(widget.price, widget.toppingName);
            }
          });
        },
      ),
      trailing: Text('${widget.price}'),
    );
  }
}

class StatusRadiobox extends StatelessWidget {
  const StatusRadiobox(this.name,
      {super.key,
      required this.price,
      required this.value,
      required this.onButtonChecked,
      required this.groupValue});
  final String name;
  final String value;
  final double price;
  final StringCallback onButtonChecked;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return price != -1
        ? ListTile(
            title: Text(name),
            leading: Radio(
              value: value,
              groupValue: groupValue,
              onChanged: (value) {
                onButtonChecked(value!);
              },
            ),
            trailing: Text('$price'),
          )
        : Container();
  }
}
