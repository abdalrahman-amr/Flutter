import 'package:flutter/material.dart';
import 'package:flutter1/layout/news_app/cubit/states.dart';
import 'package:flutter1/modules/news_app/business/business_screen.dart';
import 'package:flutter1/modules/news_app/science/science_screen.dart';
import 'package:flutter1/modules/news_app/sports/sport_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> newsItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sport"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    /*
    BottomNavigationBarItem(icon: Icon(
        Icons.settings
    ),
        label: "Settings"),
*/
  ];
  List<Widget> Screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  List<String> newsTitles = ["Business", "Sport", "Science"];

  void changeNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getSports();
    }
    if (currentIndex == 2) {
      getScience();
    }

    emit(NewsBotNavChangeState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];

  List<dynamic> science = [];

  void getBusiness() {
    if (business.length == 0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'a5987c9b70654f51aab25354a594d1fb',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print("Error next line ");
        print(error.toString());
        emit(NewsGetBusinessFailureState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  void getSports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'a5987c9b70654f51aab25354a594d1fb',
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print("Error next line ");
        print(error.toString());
        emit(NewsGetSportsFailureState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'a5987c9b70654f51aab25354a594d1fb',
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print("Error next line ");
        print(error.toString());
        emit(NewsGetScienceFailureState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'a5987c9b70654f51aab25354a594d1fb',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print("Error next line search   ");
      print(error.toString());
      emit(NewsGetSearchFailureState(error.toString()));
    });
  }
}
