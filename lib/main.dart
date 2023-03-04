
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/layout/news_app/cubit/states.dart';
import 'package:flutter1/layout/news_app/news_layout.dart';
import 'package:flutter1/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter1/layout/shop_layout/shop_layout.dart';
import 'package:flutter1/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter1/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:flutter1/modules/user/userScreen.dart';
import 'package:flutter1/shared/block_observer.dart';
import 'package:flutter1/shared/components/constants.dart';
import 'package:flutter1/shared/cubit/cubit.dart';
import 'package:flutter1/shared/cubit/states.dart';
import 'package:flutter1/shared/network/local/cache_helper.dart';
import 'package:flutter1/shared/network/remote/dio_helper.dart';
import 'package:flutter1/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/todo_app/todo_screen.dart';
import 'modules/bmi_app/bmi_screen.dart';
import 'modules/basics_app/home/homescreen.dart';
import 'modules/basics_app/login/loginScreen.dart';
import 'modules/basics_app/messenger/messengeScreen.dart';
import 'modules/shop_app/login/shop_login.dart';

void main() async{
//  webview_flutter: ^2.0.0

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isLightMode = CacheHelper.getData(key: "isLightMode");

  bool? onBoarding = CacheHelper.getData(key: "onBoarding");

  token = CacheHelper.getData(key: "token");

  if(onBoarding != null){

    if(token != null){
      widget = ShopLayout();
    }
    else widget = ShopLoginScreen();
  }
  else widget = OnBoardingScreen();




  onBoarding ??= false;

  isLightMode ??= true;

  runApp(MyApp(
      isLight: isLightMode,
      startWidget:widget,

  ));
}

class MyApp extends StatelessWidget
{

  late final bool isLight;
  late final Widget startWidget;

  MyApp({
    required this.isLight,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [

        BlocProvider(
        create: (context) => NewsCubit()..getBusiness(),),
        BlocProvider(
        create: (context) => AppCubit()..toggleBrightness(
        fromShared: isLight),),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),

      ],
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isLightMode? ThemeMode.light:ThemeMode.dark,
              home: startWidget,

            );

          },
        ),
      );

  }
  

}



