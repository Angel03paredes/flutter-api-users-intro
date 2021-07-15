import 'package:flutter/material.dart';
import './Models/User.dart';

class Profile extends StatelessWidget {
  final User user;

  Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Route"),
        ),
        body: Center(
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: NetworkImage(user.avatar)),
                Text(user.firstName + " " + user.lastName),
                Text(user.email)
              ],
            ),
          )),
        ));
  }
}
