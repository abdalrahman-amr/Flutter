import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/modules/news_app/webview/web_view.dart';
import 'package:flutter1/shared/cubit/cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextButton({
  Color? color ,
  required Function function,
  required String text,
}) =>
    Container(
        child: TextButton(
            onPressed: (){function();},
            child: Text(
              text,
              style: TextStyle(
                color: color
              ),
            ),
        )
    );




Widget defaultButton({
  Color background = Colors.blue,
  double width = double.infinity,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: () {
          function();
        } ,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextForm({
  required TextEditingController controller,
  required String label,
  required TextInputType type,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  bool isPassword = false,
  Function ?validate,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(onPressed: suffixPressed!(), icon: Icon(suffix)),
      ),
      onChanged: (s) {
        onChange!(s);
      },
      onFieldSubmitted: (s) {
        onSubmit!();
      },
      onTap: () {
        onTap!();
      },
      validator: (s) {
        return validate!(s);
      },
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key("${model['id'].toString()}"),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text("${model["time"]}"),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${model["title"]}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${model["date"]}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(id: model["id"], status: "done");
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(id: model["id"], status: "archived");
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black26,
              )),
        ],
      ),
    ),
  );
}

Widget buildTaskPage(List<Map> tasks) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 80,
            color: Colors.grey,
          ),
          Text(
            "No Tasks Yet ",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          )
        ],
      ),
    ),
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Container(
              height: 5,
              width: double.infinity,
              color: Colors.grey[300],
            ),
        itemCount: tasks.length),
  );
}

Widget buildDivider() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 2,
      width: double.infinity,
      color: Colors.grey[300],
    ),
  );
}

Widget buildNewsItem(article, context) {
  return InkWell(
    onTap: (){
     // navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}

Widget buildNewsList(list,context2) {
  return ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildNewsItem(list[index], context2),
          separatorBuilder: (context, index) => buildDivider(),
          itemCount: list.length),
      fallback: (context) => Center(child: CircularProgressIndicator()));
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

enum toastStates {SUCCESS,ERROR,WARNING}

void showToast ({
  required String text,
  required toastStates state
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Color toastColor( toastStates state){

  Color color;

  switch(state){

    case toastStates.SUCCESS:
      color = Colors.green;
      break;
    case toastStates.ERROR:
      color = Colors.red;
      break;
    case toastStates.WARNING:
      color = Colors.yellow;

  }
  return color;

}

