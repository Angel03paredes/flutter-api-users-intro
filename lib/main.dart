import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './Models/User.dart';

import './SecondPage.dart';
import './Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late http.Response users;
  static var url = Uri.parse("https://reqres.in/api/users");
  late List userList;
  late Map data;
  getUsers() async {
    this.users = await http.get(url);
    data = json.decode(this.users.body);
    setState(() {
      userList = data['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a list of users')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: userList == null ? 0 : userList.length,
          itemBuilder: (BuildContext context, int index) {
            return (Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("${userList[index]["avatar"]}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                          "${userList[index]["first_name"]} ${userList[index]["last_name"]}"),
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                    user: User(
                                        userList[index]['first_name'],
                                        userList[index]['last_name'],
                                        userList[index]['avatar'],
                                        userList[index]['email']))),
                          );
                        },
                        child: Text("Visit"))
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
