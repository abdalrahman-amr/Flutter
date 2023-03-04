import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 20,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq5eMRxkFIQMnfAe5p_L-BJUdf6xv6CvD0zw&usqp=CAU'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Chats",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Search"),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) => buildStoryItem(),
                  separatorBuilder: (context,index) => SizedBox(width: 20,),
                  itemCount: 10,
                ),
              ),
              SizedBox(height: 20,),
              ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index) => buildChatItem(),
                    separatorBuilder: (context,index) => SizedBox(height: 15,),
                    itemCount: 15,
                ),

            ],
          ),
        ),
      ),
    );
  }
}
Widget buildStoryItem () => Container(
  width: 60,
  child: Column(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://avatarfiles.alphacoders.com/693/69306.jpg'),
          ),
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.green,
          ),
        ],
      ),
      Text(
        "Homer Simpsons",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),

);
Widget buildChatItem () => Row(
  children: [
    Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              'https://avatarfiles.alphacoders.com/693/69306.jpg'),
        ),
        CircleAvatar(
          radius: 5,
          backgroundColor: Colors.green,
        ),
      ],
    ),
    SizedBox(width: 10,),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Homer Simpsons",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Hello my friend it's me, I wonder what are you doing today afternoon",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Text("02:00"),

            ],
          ),
        ],
      ),
    ),
  ],
);