import 'package:flutter/material.dart';

class OrderStatusCardWidget extends StatefulWidget {
  const OrderStatusCardWidget(
      {super.key,
      required this.orderId,
      required this.orderStatus,
      required this.time});
  final String orderId;
  final int orderStatus;
  final String time;
  @override
  State<OrderStatusCardWidget> createState() => _OrderStatusCardWidgetState();
}

class _OrderStatusCardWidgetState extends State<OrderStatusCardWidget> {
  Widget genStatus() {
    String statusMessage = '';
    switch (widget.orderStatus) {
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
      child: Text(statusMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: SizedBox(
            width: 300,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OrderID : ${widget.orderId.split('-').first}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  genStatus(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "เวลาที่สั่ง : ${widget.time}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
