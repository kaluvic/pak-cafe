import 'package:flutter/material.dart';
import 'package:pak_admin/entities/userlist_entity.dart';
import 'package:pak_admin/pages/credit_management.dart';
import 'package:pak_admin/services/user_service.dart';

import '../theme/customtheme.dart';

class CreditSearchUserPage extends StatefulWidget {
  const CreditSearchUserPage({super.key});

  @override
  State<CreditSearchUserPage> createState() => _CreditSearchUserPageState();
}

class _CreditSearchUserPageState extends State<CreditSearchUserPage> {
  String searchValue = '';
  final userService = UserService();
  List<UserList> user = [];
  List<UserList> userSearch = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การจัดการเครดิต',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: CoffeeColor.milk),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: userService.fetchUserList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = snapshot.data!;
                return Column(
                  children: [
                    TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        setState(() {
                          searchValue = value.toLowerCase();
                          if (value.isEmpty) {
                            userSearch = [];
                          } else {
                            userSearch = user.where((element) {
                              return element.name
                                  .toLowerCase()
                                  .contains(searchValue);
                            }).toList();
                          }
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'ค้นหา', suffixIcon: Icon(Icons.search)),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userSearch.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(userSearch[index].name),
                            subtitle: Text(userSearch[index].email),
                            onTap: () {
                              UserList temp = userSearch[index];
                              setState(() {
                                userSearch = [];
                                textEditingController.text = '';
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CreditManagement(user: temp),
                              ));
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
