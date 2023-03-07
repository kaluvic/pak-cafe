import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreditManagement extends StatefulWidget {
  const CreditManagement({super.key});

  @override
  State<CreditManagement> createState() => _CreditManagementState();
}

class _CreditManagementState extends State<CreditManagement> {
  int credit = 0;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('การจัดการเครดิต')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Username : '),
            const Text('Email : '),
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
                    onPressed: () {}, child: const Text('ยืนยัน')))
          ],
        ),
      ),
    );
  }
}
