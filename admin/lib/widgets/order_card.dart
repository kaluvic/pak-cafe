import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
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
                const Text("OrderList"),
                Container(
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ElevatedButton(onPressed: null, child: Text("order")),
                      ElevatedButton(onPressed: null, child: Text("cancle")),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
