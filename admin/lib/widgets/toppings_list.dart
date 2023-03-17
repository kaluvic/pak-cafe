import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';

class ToppingsList extends StatefulWidget {
  ToppingsList({super.key, required this.toppings});
  List<Topping> toppings = [];

  @override
  State<ToppingsList> createState() => _ToppingsListState();
}

class _ToppingsListState extends State<ToppingsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(10.0), child: const Text('Toppings')),
        Flexible(
            child: ListView.builder(
          itemCount: widget.toppings.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.toppings[index].name),
            );
          },
        )),
        ToppingAddTile()
      ],
    );
  }
}

class ToppingAddTile extends StatelessWidget {
  ToppingAddTile({
    Key? key,
  }) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add),
      title: const Text('เพิ่ม'),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ท็อปปิง'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('ชื่อท็อปปิง'),
              TextField(
                controller: nameController,
              ),
              const Text('ราคา'),
              TextField(
                controller: priceController,
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ยืนยัน')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก')),
          ],
        ),
      ),
    );
  }
}
