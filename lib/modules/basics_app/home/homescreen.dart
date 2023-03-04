import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        leading: Icon(
          Icons.menu
        ),
        title: Text(
            "First Screen"
        ),
        actions: [
         IconButton(
             onPressed:  onNotifications,
             icon: Icon(Icons.notification_important))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image(image: NetworkImage('https://qph.cf2.quoracdn.net/main-qimg-b27eaaaaf4c34a4dd997b340393e34c5-lq'),
                 height: 200,
                width: 300 ,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(.3),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Text(
                  "Bullet",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );



  }
void onNotifications(){
    print("object");
}

}