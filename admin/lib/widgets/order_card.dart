import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/entities/cartinfo_entity.dart';

class OrderCardWidget extends StatefulWidget {
  const OrderCardWidget(
      {super.key,
      required this.username,
      required this.status,
      required this.orderId,
      required this.cartInfo});
  final Map<String, CartInfo> cartInfo;
  final String orderId;
  final String username;
  final int status;
  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  List<CartInfo> cartList = [];
  
  @override
  Widget build(BuildContext context) {
    createList(widget.cartInfo);
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
                children: [
                  Text(
                    "User: ${widget.username}",
                  ),
                  Text(
                    "Order ID : ${widget.orderId.split('-').first}",
                  ),
                ],
              ),
              content: SizedBox(width: double.maxFinite, child: genMenuDialogBox()),
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
                    children: [
                      Text(
                        "User : ${widget.username}",
                      ),
                      Text(
                        "Order ID : ${widget.orderId.split('-').first}",
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: orderlist(widget.cartInfo.length),
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

  void createList(Map<String, CartInfo> cartinfo) {
    cartinfo.forEach((key, value) {
      cartList.add(value);
    });
  }

  Widget genMenuDialogBox() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        String topping = '-';
        String notes = '-';

        if (cartList[index].toppings.isNotEmpty) {
          topping = cartList[index].toppings;
        }
        if (cartList[index].note.isNotEmpty) {
          notes = cartList[index].note;
        }
        return ListTile(
          leading: Text('${cartList[index].count}'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${cartList[index].menuName} (${cartList[index].status})'),
              Text('ท็อปปิ้ง : $topping'),
              Text('Note : $notes')
            ],
          ),
        );
      },
    );
  }

  Container genMenuCard(CartInfo cart) {
    String topping = '-';
    String notes = '-';

    if (cart.toppings.isNotEmpty) {
      topping = cart.toppings;
    }
    if (cart.note.isNotEmpty) {
      notes = cart.note;
    }
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 2, 10, 0),
            child: Text(cart.count.toString())
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${cart.menuName} (${cart.status})'),
              Text('ท็อปปิ้ง : $topping'),
              Text('Note : $notes')
            ],
          )
        ],
      ),
    );
  }

  orderlist(int range) {
    if (range <= 2) {
      if (range == 1) {
        return genMenuCard(cartList[0]);
      } else {
        return Column(
          children: [genMenuCard(cartList[0]), genMenuCard(cartList[1])],
        );
      }
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          genMenuCard(cartList[0]),
          genMenuCard(cartList[1]),
          Text("... มีอีก ${range - 2} รายการ"),
        ],
      );
    }
  }
}
