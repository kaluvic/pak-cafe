///   ณัฐชัย กัณฑเจตน์ 620510595

import 'package:flutter/material.dart';


///   Widget แสดงรายละเอียดของแต่ละออเดอร์
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
      padding: const EdgeInsets.only(left: 2.0, top: 5.0),
      child: Text(
        statusMessage,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: width,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "OrderID : ${widget.orderId.split('-').first}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                genStatus(),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "เวลาที่สั่ง : ${widget.time}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
