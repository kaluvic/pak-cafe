///   ณัฐชัย กัณฑเจตน์ 620510595

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/entities/cartinfo_entity.dart';
import 'package:pak_admin/theme/customtheme.dart';

///   Feature การสร้างการ์ดออเดอร์ และ ออเดอร์ AlertDialog
///   Feature อัพเดตสถานะของแต่ละออเดอร์
class OrderCardWidget extends StatefulWidget {
  const OrderCardWidget(
      {super.key,
      required this.username,
      required this.status,
      required this.orderId,
      required this.cartInfo,
      required this.userId});
  final Map<String, CartInfo> cartInfo;
  final String orderId;
  final String username;
  final String userId;
  final int status;
  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  List<CartInfo> cartList = [];

  void createList(Map<String, CartInfo> cartinfo) {
    List<CartInfo> tempCart = [];
    cartinfo.forEach((key, value) {
      tempCart.add(value);
    });
    cartList = tempCart;
  }

  Color statusColor() {
    switch (widget.status) {
      case 0:
        return Colors.lightBlue.shade900;
      case 1:
        return Colors.yellow.shade800;
      case 2:
        return Colors.green.shade800;
      default:
        return Colors.black;
    }
  }

  Widget orderlist(int range) {
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
          Text(
            "... มีอีก ${range - 2} รายการ",
            style: CustomTextStyle.detail,
          ),
        ],
      );
    }
  }

  Row genMenuCard(CartInfo cart) {
    String topping = '-';
    String notes = '-';

    if (cart.toppings.isNotEmpty) {
      topping = cart.toppings;
    }
    if (cart.note.isNotEmpty) {
      notes = cart.note;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(5, 2, 10, 0),
            child: Text(cart.count.toString())),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${cart.menuName} (${cart.status})',
                style: CustomTextStyle.detail),
            Text('ท็อปปิ้ง : $topping'),
            Text('Note : $notes')
          ],
        )
      ],
    );
  }

  AlertDialog genAlertBox() {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
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
                    Text(
                        '${cartList[index].menuName} (${cartList[index].status})'),
                    Text('ท็อปปิ้ง : $topping'),
                    Text('Note : $notes')
                  ],
                ),
              );
            },
          )),
      actions: <Widget>[genButton(isAlert: true)],
    );
  }

  Widget genButton({bool isAlert = false}) {
    switch (widget.status) {
      case 0:
        return Container(
          margin: const EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () async {
                final query = await FirebaseDatabase.instance
                    .ref('order/${widget.userId}')
                    .child('orderList')
                    .orderByChild('orderId')
                    .equalTo(widget.orderId)
                    .once()
                    .then(
                  (value) {
                    return value.snapshot.value;
                  },
                );

                for (String i in (query as Map).keys) {
                  await FirebaseDatabase.instance
                      .ref('order/${widget.userId}/orderList/$i')
                      .update({"status": widget.status + 1});
                }

                await FirebaseDatabase.instance
                    .ref('orderInfo/${widget.orderId}')
                    .update({"status": widget.status + 1}).then(
                        (value) => {if (isAlert) Navigator.pop(context)});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 23, 136, 202)),
              child: const Text(
                "ยืนยัน",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                double stackedCredit = 0;
                final query = await FirebaseDatabase.instance
                    .ref('order/${widget.userId}')
                    .child('orderList')
                    .orderByChild('orderId')
                    .equalTo(widget.orderId)
                    .once()
                    .then(
                  (value) {
                    return value.snapshot.value;
                  },
                );
                for (String i in (query as Map).keys) {
                  final stackedRef = FirebaseDatabase.instance
                      .ref('order/${widget.userId}/orderList/$i');
                  stackedCredit += ((await stackedRef.child('totalPrice').get())
                          .value as int)
                      .toDouble();
                  await stackedRef.remove();
                }
                await FirebaseDatabase.instance
                    .ref('orderInfo/${widget.orderId}')
                    .remove();
                final creditRef =
                    FirebaseDatabase.instance.ref('user/${widget.userId}');
                final credit =
                    ((await creditRef.child('credit').get()).value as int)
                        .toDouble();
                await creditRef
                    .update({'credit': credit + stackedCredit}).then((value) {
                  if (isAlert) {
                    Navigator.pop(context);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 190, 51, 42)),
              child: const Text(
                "ยกเลิก",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
        );
      case 1:
        return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final query = await FirebaseDatabase.instance
                          .ref('order/${widget.userId}')
                          .child('orderList')
                          .orderByChild('orderId')
                          .equalTo(widget.orderId)
                          .once()
                          .then(
                        (value) {
                          return value.snapshot.value;
                        },
                      );

                      for (String i in (query as Map).keys) {
                        await FirebaseDatabase.instance
                            .ref('order/${widget.userId}/orderList/$i')
                            .update({"status": widget.status + 1});
                      }

                      await FirebaseDatabase.instance
                          .ref('orderInfo/${widget.orderId}')
                          .update({"status": widget.status + 1}).then((value) {
                        if (isAlert) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 23, 136, 202)),
                    child: const Text(
                      "ยืนยัน",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ]));
      case 2:
        return Container(
          margin: const EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () async {
                final query = await FirebaseDatabase.instance
                    .ref('order/${widget.userId}')
                    .child('orderList')
                    .orderByChild('orderId')
                    .equalTo(widget.orderId)
                    .once()
                    .then(
                  (value) {
                    return value.snapshot.value;
                  },
                );
                for (String i in (query as Map).keys) {
                  await FirebaseDatabase.instance
                      .ref('order/${widget.userId}/orderList/$i')
                      .remove();
                }
                await FirebaseDatabase.instance
                    .ref('orderInfo/${widget.orderId}')
                    .remove()
                    .then((value) {
                  if (isAlert) {
                    Navigator.pop(context);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 23, 136, 202)),
              child: const Text(
                "เสร็จสื้น",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
        );
      default:
        return Container();
    }
  }

  Widget genStatus() {
    String statusMessage = '';
    switch (widget.status) {
      case 0:
        statusMessage = 'Status : รอรับออเดอร์';
        break;
      case 1:
        statusMessage = 'Status : กำลังดำเนินการ';
        break;
      case 2:
        statusMessage = 'Status : ออเดอร์เสร็จสิ้น';
        break;
      default:
        return Container();
    }
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(statusMessage, style: CustomTextStyle.detail),
    );
  }

  @override
  Widget build(BuildContext context) {
    createList(widget.cartInfo);
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: statusColor(), width: 2)),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => genAlertBox()),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User : ${widget.username}",
                            style: CustomTextStyle.detail),
                        Text("Order ID : ${widget.orderId.split('-').first}",
                            style: CustomTextStyle.detail),
                      ],
                    ),
                  ),
                  genStatus(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: orderlist(widget.cartInfo.length),
                  ),
                  genButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
