import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';

import '../pages/menu_add.dart';

class DrinkList extends StatefulWidget {
  const DrinkList(
      {super.key, required this.menuIdList, required this.menuInfoMap});
  final List<String> menuIdList;
  final Map<String, MenuInfo> menuInfoMap;

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  void goMenuAddPage({MenuInfo? menuInfo, String? id}) {
    if (menuInfo != null && id != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuAddPage(
                    menuInfo: menuInfo,
                    id: id,
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
      itemCount: widget.menuIdList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: const Text('+'),
            onTap: goMenuAddPage,
          );
        } else {
          String id = widget.menuIdList[index - 1];
          MenuInfo menuInfo = widget.menuInfoMap[id]!;
          return ListTile(
            title: Text(menuInfo.name),
            subtitle: Text('${menuInfo.price} บาท'),
            onTap: () {
              goMenuAddPage(id: id, menuInfo: menuInfo);
            },
          );
        }
      },
    );
  }
}
