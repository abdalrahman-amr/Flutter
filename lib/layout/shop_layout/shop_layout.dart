import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter1/layout/shop_layout/cubit/states.dart';
import 'package:flutter1/modules/shop_app/login/shop_login.dart';
import 'package:flutter1/modules/shop_app/search/search_screen.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/cubit/cubit.dart';
import 'package:flutter1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchShopScreen());
                }, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  AppCubit.get(context).toggleBrightness();
                }, icon: Icon(Icons.brightness_4_outlined)),

              ],
            ),
            body: cubit.shopScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Categories"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp),label: "Favorites"),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
              ],
              onTap: (index){
                cubit.changeShopBotNav(index);
              },
              currentIndex: cubit.currentIndex,
              
            ),


          );

        },
        );

  }
}
