
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/news_app/cubit/states.dart';
import 'package:flutter1/modules/news_app/search/search_screen.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/cubit/cubit.dart';
import 'package:flutter1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.newsTitles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: (){
                AppCubit.get(context).toggleBrightness();
              }, icon: Icon(Icons.brightness_4_outlined)),

            ],
          ),
      /*    floatingActionButton: FloatingActionButton(
            onPressed: (){
              cubit.getBusiness();
            },
            child: Icon(Icons.add),
          ),*/
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex ,
            onTap: (index){
              cubit.changeNavBar(index);

            },
            items: cubit.newsItems,
          ),

        );
      },

    );
  }

}


