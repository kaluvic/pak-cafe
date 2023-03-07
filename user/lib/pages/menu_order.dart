import 'package:flutter/material.dart';

typedef StringCallback = void Function(String value);
typedef FuncCallback = void Function();

class MenuOrderPage extends StatefulWidget {
  const MenuOrderPage({super.key});

  @override
  State<MenuOrderPage> createState() => _MenuOrderPageState();
}

class _MenuOrderPageState extends State<MenuOrderPage> {
  String _statusValue = '0';
  int _number = 1;
  double priceTotal = 0;

  void changeStatus(String value) {
    setState(() {
      _statusValue = value;
    });
  }

  void decreaseNumber() {
    setState(() {
      if (_number > 1) {
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'DRINK_NAME',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Image
              const Placeholder(),
              //* Price
              Container(
                margin:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                alignment: Alignment.centerRight,
                child: const Text(
                  'PRICE',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              //* List
              Column(
                children: [
                  StatusRadiobox('STATUS_1', price: 1000, value: '1',
                      onButtonChecked: (value) {
                    changeStatus(value);
                  }, groupValue: _statusValue),
                  StatusRadiobox('STATUS_2', price: 1000, value: '2',
                      onButtonChecked: (value) {
                    changeStatus(value);
                  }, groupValue: _statusValue),
                  StatusRadiobox('STATUS_3', price: 1000, value: '3',
                      onButtonChecked: (value) {
                    changeStatus(value);
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
                  ToppingCheckbox(
                    'TOPPING_1',
                    price: 1000,
                  ),
                  ToppingCheckbox(
                    'TOPPING_2',
                    price: 1000,
                  ),
                  ToppingCheckbox(
                    'TOPPING_3',
                    price: 1000,
                  ),
                ],
              ),
              //* Note
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Note',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      maxLines: 6,
                      maxLength: 300,
                      decoration: InputDecoration(border: OutlineInputBorder()),
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
              Center(child: Text('ราคารวม $priceTotal บาท')),
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
            icon: const Text('-')),
        Text('$number'),
        IconButton(
            onPressed: () {
              onPlusTap();
            },
            icon: const Text('+'))
      ],
    );
  }
}

class ToppingCheckbox extends StatefulWidget {
  ToppingCheckbox(this.toppingName, {super.key, required this.price});
  late String toppingName = 'TOPPING_NAME';
  late double price = 0;

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
    return ListTile(
      title: Text(name),
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          onButtonChecked(value!);
        },
      ),
      trailing: Text('$price'),
    );
  }
}
