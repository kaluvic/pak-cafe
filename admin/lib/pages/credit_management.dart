import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pak_admin/entities/userlist_entity.dart';
import 'package:pak_admin/pages/navigation.dart';
import 'package:pak_admin/services/user_service.dart';

class CreditManagement extends StatefulWidget {
  const CreditManagement({super.key, required this.user});
  final UserList user;

  @override
  State<CreditManagement> createState() => _CreditManagementState();
}

class _CreditManagementState extends State<CreditManagement> {
  String searchText = '';
  int credit = 0;
  final TextEditingController _controller = TextEditingController();
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การจัดการเครดิต'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username : ${widget.user.name}'),
            Text('Email : ${widget.user.email}'),
            const Text('จำนวนเงินที่ต้องการเติม'),
            TextField(
                controller: _controller,
                onChanged: (value) {
                  if (value.isEmpty) {
                    credit = 0;
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        setState(() {
                          credit += 10;
                          _controller.text = '$credit';
                        });
                      },
                      child: const Text('+10')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        setState(() {
                          credit += 20;
                          _controller.text = '$credit';
                        });
                      },
                      child: const Text('+20')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        setState(() {
                          credit += 50;
                          _controller.text = '$credit';
                        });
                      },
                      child: const Text('+50'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        setState(() {
                          credit += 100;
                          _controller.text = '$credit';
                        });
                      },
                      child: const Text('+100')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        setState(() {
                          credit += 200;
                          _controller.text = '$credit';
                        });
                      },
                      child: const Text('+200')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        setState(() {
                          credit += 500;
                          _controller.text = '$credit';
                        });
                      },
                      child: const Text('+500'))
                ],
              ),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      credit += widget.user.credit;
                      userService.updateUser(widget.user, credit);
                      Navigator.of(context).pop();
                    },
                    child: const Text('ยืนยัน')))
          ],
        ),
      ),
    );
  }
}
