import 'package:flutter/material.dart';

class ToppingsList extends StatefulWidget {
  const ToppingsList({super.key});

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
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('add'),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('ท็อปปิง'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('ชื่อท็อปปิง'),
                  TextField(),
                  Text('ราคา'),
                  TextField()
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
        )
      ],
    );
  }
}
