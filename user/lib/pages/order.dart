import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pak_user/entities/order_entity.dart';
import 'package:pak_user/services/order_service.dart';
import 'package:pak_user/widgets/order_status_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double cash = 1000;
  String username = 'Chanin';
  String uid = '72cdf7df-eb6c-4cb6-9216-a85a3d330205';
  OrderService orderService = OrderService();
  late OrderList _orderList; 

  void dropdownCallback(String? selectedValue) {
    if (selectedValue == 'logout') {
      print('Logout');
    }
  }

  List<OrderStatusCardWidget> generateCard(){
    List<OrderListElement> order = _orderList.orderList;
    return List<OrderStatusCardWidget>.generate(order.length, (index) {
      return OrderStatusCardWidget(orderId: order[index].orderId,orderStatus: order[index].status,time: order[index].time,);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: FutureBuilder(
                future: orderService.fetchOrderList(uid),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    _orderList = snapshot.data!;
                    return Column(
                    children: [
                      const Text(
                        "สถานะการสั่งซื้อ",
                        style: TextStyle(fontSize: 30),
                      ),
                      Column(
                        children: generateCard(),
                      )
                      
                    ],
                  );
                  }else{
                    return CircularProgressIndicator();
                  }
                 
                }
              )),
        ),
      ),
    );
  }
}
