
import 'package:flutter/material.dart';
import 'package:flutter1/modules/shop_app/login/shop_login.dart';

import '../network/local/cache_helper.dart';
import 'components.dart';

const defaultColor = Colors.blue;


void signOut(BuildContext context){

  CacheHelper.removeData(key: "token").then((value) {
    if(value == true){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });



}

void printFullText(String text){

  final pattern = RegExp('{.1800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String ?token = '';
