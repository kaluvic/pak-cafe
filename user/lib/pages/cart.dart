import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> listItem = [
    'a',
    'b',
    'b',
    'b',
    'b',
    'b',
    'b',
    'b',
    'b',
    'b',
    'b'
  ];
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
      body: ListView.builder(
        itemCount: listItem.length + 1,
        itemBuilder: (context, index) {
          if (index < listItem.length) {
            return Container(
              margin: const EdgeInsets.only(left: 50, right: 50,top: 10 ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('ชื่อสินค้า'), const Text('x1'), const Text('ราคา')],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "ประเภท",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "ท็อปปิ้ง",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "โน๊ต",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(left: 50, right: 50),
              child: const SizedBox(
                height: 200, 
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text('ราคารวม',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                )
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('สั่ง',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}