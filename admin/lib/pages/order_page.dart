import 'package:flutter/material.dart';
import 'package:pak_admin/widgets/order_card.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Page')),
      body: Center(
        child: Column(
          children: const [
            OrderCardWidget(),
            OrderCardWidget(),
          ],
        )
      ),
    );
  }
}