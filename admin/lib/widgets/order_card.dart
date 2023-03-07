import 'package:flutter/material.dart';

class OrderCardWidget extends StatefulWidget {
  const OrderCardWidget({super.key});

  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  List<String> menuList = ['t1', 't2', 't3'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Username",
                  ),
                  Text(
                    "Order ID",
                  ),
                ],
              ),
              content: const Text('เมนูที่สั่ง'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'รับออเดอร์'),
                  child: const Text('รับออเดอร์'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                  child: const Text('ยกเลิก'),
                ),
              ],
            ),
          ),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Username",
                      ),
                      Text(
                        "Order ID",
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: orderlist(menuList.length),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("รับออเดอร์"),
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("ยกเลิก")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  orderlist(int range) {
    if (range <= 2) {
      if (range == 1) {
        return Text(menuList[0]);
      } else {
        return Column(
          children: [
            Text(menuList[0]),
            Text(menuList[1]),
          ],
        );
      }
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menuList[0]),
          Text(menuList[1]),
          Text("... มีอีก ${range - 2} รายการ"),
        ],
      );
    }
  }
}
