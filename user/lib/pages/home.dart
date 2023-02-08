import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _dropdownValue = 'default';

  void dropdownCallback(String? selectedValue) {
    if (selectedValue == 'logout') {
      print('Logout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
                value: 'default',
                items: const [
                  DropdownMenuItem(value: 'default', child: Text('Username')),
                  DropdownMenuItem(value: 'logout', child: Text('Logout')),
                ],
                onChanged: dropdownCallback),
            Container(
              color: Colors.amber,
              child: const Text('Cash'),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //TODO: Recommend menu
              const SizedBox(
                  width: 500,
                  height: 500,
                  child: Placeholder(
                    child: Text('Recommend menu'),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: const Text('Menu')),
              //TODO: Tab Category
              DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        child: const TabBar(
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: '1',
                              ),
                              Tab(
                                text: '2',
                              ),
                              Tab(
                                text: '3',
                              ),
                              Tab(
                                text: '4',
                              ),
                            ]),
                      ),
                      //TODO: BODY
                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.3,
                        child: const TabBarView(children: [
                          Center(
                            child: Text('1'),
                          ),
                          Center(
                            child: Text('2'),
                          ),
                          Center(
                            child: Text('3'),
                          ),
                          Center(
                            child: Text('4'),
                          )
                        ]),
                      )
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
