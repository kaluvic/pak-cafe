import 'package:flutter/material.dart';

class OrderStatusCardWidget extends StatefulWidget {
  const OrderStatusCardWidget({super.key});

  @override
  State<OrderStatusCardWidget> createState() => _OrderStatusCardWidgetState();
}

class _OrderStatusCardWidgetState extends State<OrderStatusCardWidget> {

  String orderId = "123456";
  String orderStatus = "waiting";
  String time = "19/9/99";
  

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
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("OrderID : $orderId",style: const TextStyle(fontSize: 20) ,),
                  Text("สถานะ : $orderStatus"),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        
                        Text(
                          "เวลาที่สั่ง : $time",
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
