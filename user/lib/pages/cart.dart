import 'package:flutter/material.dart';
import 'package:pak_user/entities/cart_entity.dart';
import 'package:pak_user/entities/menuinfo_entity.dart';
import 'package:pak_user/pages/menu_order.dart';
import 'package:pak_user/pages/order.dart';
import 'package:pak_user/services/cart_service.dart';
import 'package:pak_user/services/menu_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartService cartService = CartService();
  MenuService menuService = MenuService();

  // MOCK Data
  String username = 'pudding';
  String userId = '72cdf7df-eb6c-4cb6-9216-a85a3d330205';

  List<Item> listItem = [];
  double totalPrice = 0;
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
      body: FutureBuilder(
          future: cartService.callCartAsList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Data call as Item
              listItem = snapshot.data!;
              return ListView.builder(
                itemCount: listItem.length + 1,
                itemBuilder: (context, index) {
                  if (index < listItem.length) {
                    totalPrice += listItem[index].price;
                    return Container(
                      margin:
                          const EdgeInsets.only(left: 50, right: 50, top: 10),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${listItem[index].name}  (${listItem[index].status})"),
                            Text('x${listItem[index].count}'),
                            Text('${listItem[index].price}')
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            listItem[index].toppings.isEmpty
                                ? Text('ท็อปปิ้ง : -')
                                : Text(
                                    "ท็อปปิ้ง : ${listItem[index].toppings}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                            listItem[index].note.isEmpty
                                ? Text('โน๊ต : -')
                                : Text(
                                    "โน๊ต : ${listItem[index].note}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              MenuInfo menuInfo = await menuService
                                  .fetchInfoFromId(listItem[index].itemId);
                              await Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return MenuOrderPage(
                                      menuInfo: menuInfo,
                                      menuid: listItem[index].itemId);
                                },
                              ));
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(left: 50, right: 50),
                      child: SizedBox(
                          height: 200,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text('ราคารวม $totalPrice บาท',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                          )),
                    );
                  }
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        child: FloatingActionButton.extended(
          onPressed: () {
            cartService.setOrder(username, userId);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OrderPage()));
          },
          label: const Text(
            'สั่ง',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
