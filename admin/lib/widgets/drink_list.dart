import 'package:flutter/material.dart';

import '../pages/menu_add.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({super.key});

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  void goMenuAddPage({String? title}) {
    if (title != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuAddPage(
                    title: title,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuAddPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: const Text('+'),
            onTap: goMenuAddPage,
          );
        } else {
          return ListTile(
            title: Text('$index'),
            onTap: () {
              goMenuAddPage(title: index.toString());
            },
          );
        }
      },
    );
  }
}
