/// ธัชทร วงศ์ไชย 620510601
/// DrinkList
/// สร้างรายการเครื่องดื่มแต่ละประเภท

import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';

import '../pages/menu_add.dart';

class DrinkList extends StatefulWidget {
  const DrinkList({
    super.key,
    required this.menuIdList,
    required this.menuInfoMap,
    required this.category,
    required this.catIndex,
  });
  final List<String> menuIdList;
  final Map<String, MenuInfo> menuInfoMap;
  final String category;
  final int catIndex;

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  void goMenuAddPage(
      {MenuInfo? menuInfo,
      String? id,
      required String category,
      required int catIndex}) {
    if (menuInfo != null && id != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuAddPage(
                    category: category,
                    catIndex: catIndex,
                    menuInfo: menuInfo,
                    id: id,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuAddPage(
              catIndex: catIndex,
              category: category,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.menuIdList.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: const Text('+'),
            onTap: () {
              goMenuAddPage(
                  category: widget.category, catIndex: widget.catIndex);
            },
          );
        } else {
          String id = widget.menuIdList[index];
          MenuInfo menuInfo = widget.menuInfoMap[id]!;
          return ListTile(
            title: Text(menuInfo.name),
            subtitle: Text('${menuInfo.price} บาท'),
            onTap: () {
              goMenuAddPage(
                  id: id,
                  menuInfo: menuInfo,
                  category: widget.category,
                  catIndex: widget.catIndex);
            },
          );
        }
      },
    );
  }
}
