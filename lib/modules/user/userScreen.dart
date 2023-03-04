
import 'package:flutter/material.dart';

import '../../models/basics_app/user.dart';



class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: "Ahmed Ali",
      phone: "01005987321"
    ),
    UserModel(
        id: 2,
        name: "Ali Ali",
        phone: "01235987321"
    ),
    UserModel(
        id: 3,
        name: "Ahmed Alaa",
        phone: "01765987321"
    ),
    UserModel(
        id: 4,
        name: "Mohahmed Ali",
        phone: "01033987321"
    ),
    UserModel(
        id: 5,
        name: "Ahmed Ali",
        phone: "01225987321"
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context,index) => buildUser(users[index]),
            separatorBuilder:(context,index) => SizedBox(height: 15,),
            itemCount: users.length),
      ),
    );
  }
}
Widget buildUser(UserModel user) => Row(
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blue,
        child: Text(
            "${user.id}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "${user.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black
              ),
            ),
            Text(
                "${user.phone}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            ),

          ],
        ),
      ),

],

    );
