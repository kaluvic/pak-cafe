import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Container> _myCart(int count) {
    return List.generate(
      count,
      (i) => Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('1'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('MenuName'),
                Text(
                  'Type',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Topping',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Note',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Text('ราคา 35 บาท'),
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.edit)
            )
          ],
        ),
      )
    ).toList(); // replace * with your rupee or use Icon instead
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text("ตะกร้าสินค้า"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(children: _myCart(5)),
            const Text(
              'ราคารวม 130 บาท',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('สั่ง'),
                )
              )
            )
          ]
        ),
      ),
    );
  }
}
