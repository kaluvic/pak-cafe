import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';

typedef FuncCallBack = Function(List<Topping> value);
typedef DialogCallBack = Function(Topping value);

class ToppingLists extends StatefulWidget {
  ToppingLists({super.key, required this.toppings, required this.onAccept});
  List<Topping> toppings;
  final FuncCallBack onAccept;
  @override
  State<ToppingLists> createState() => _ToppingListsState();
}

class _ToppingListsState extends State<ToppingLists> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int length = widget.toppings.length;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: length + 1,
      itemBuilder: (context, index) {
        if (index == widget.toppings.length) {
          // Add tile
          return ListTile(
            title: const Text('เพิ่ม'),
            leading: const Icon(Icons.add),
            onTap: () {
              generateDialog(
                context,
                onDialog: (value) {
                  setState(() {
                    widget.toppings.add(value);
                    widget.onAccept(widget.toppings);
                  });
                },
              );
            },
          );
        } else {
          // Edit tiles
          return ListTile(
            title: Text(widget.toppings[index].name),
            trailing: Text('${widget.toppings[index].price}'),
            leading: const Icon(Icons.edit),
            onTap: () {
              generateDialog(
                context,
                name: widget.toppings[index].name,
                price: '${widget.toppings[index].price}',
                onDialog: (value) {
                  setState(() {
                    widget.toppings[index] = value;
                    widget.onAccept(widget.toppings);
                  });
                },
              );
            },
          );
        }
      },
    );
  }

  void generateDialog(BuildContext context,
      {String name = '', String price = '', required DialogCallBack onDialog}) {
    _nameController.text = name;
    _priceController.text = price;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ท็อปปิง'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('ชื่อ'),
              TextField(
                controller: _nameController,
              ),
              const Text('ราคา'),
              TextField(
                controller: _priceController,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  onDialog(Topping(
                      name: _nameController.text,
                      price: double.parse(_priceController.text)));
                  _dismissDialog();
                },
                child: const Text('ยืนยัน')),
            ElevatedButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: const Text('ยกเลิก')),
          ],
        );
      },
    );
  }

  void _dismissDialog() {
    Navigator.of(context).pop();
  }
}
