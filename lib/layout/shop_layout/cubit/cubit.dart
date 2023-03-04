import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter1/layout/shop_layout/cubit/states.dart';
import 'package:flutter1/models/shop_app/categories_model.dart';
import 'package:flutter1/models/shop_app/change_favorites_model.dart';
import 'package:flutter1/models/shop_app/home_model.dart';
import 'package:flutter1/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter1/modules/shop_app/favorites/favorites_screen.dart';
import 'package:flutter1/modules/shop_app/products/product_screen.dart';
import 'package:flutter1/modules/shop_app/settings/settings_screen.dart';
import 'package:flutter1/shared/components/constants.dart';
import 'package:flutter1/shared/network/remote/dio_helper.dart';
import 'package:flutter1/shared/network/remote/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/login_model.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit(): super(ShopInitialState());



  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> shopScreen= [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];



  void changeShopBotNav(int index){
    currentIndex = index;
    emit(ShopChangeBotNavState());
  }


  Map<int,bool> favourties ={};
  HomeModel ?homeModel =null;
  void getHomeData(){
    emit(ShopLoadingHomeState());

    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel?.data!.products[0].name);
      homeModel!.data!.products.forEach((element) {

        favourties.addAll(
          {
            element.id : element.in_favorites
          }
        );

      });
      emit(ShopSuccessHomeState());
    }).catchError((error){
      emit(ShopFailureHomeState(error.toString()));
    });



  }


  CategoriesModel ?categoriesModel =null;
  void getCategories(){
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      emit(ShopFailureCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel ? changeFavoritesModel;

  void changeFavourites(int productId){
    favourties[productId] = !favourties[productId]! ;
    emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));

    DioHelper.postData(
        url: FAVORITES,
        data: {'product_id': productId},
      token: token,

    ).then((value) {

      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);

      if(!changeFavoritesModel!.status){
        favourties[productId] = !favourties[productId]! ;
      }
      else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));

    }).catchError((error){
      favourties[productId] = !favourties[productId]! ;
      emit(ShopFailureChangeFavoritesState(error));

    });
  }

  FavoritesModel ? favoritesModel =null;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      emit(ShopFailureGetFavoritesState(error.toString()));
    });
  }

  ShopLoginModel ? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name.toString());
      emit(ShopSuccessUserDataState());
    }).catchError((error){
      emit(ShopFailureUserDataState(error.toString()));
    });
  }




  void updateUserData({required String email,
    required String name,required String phone,
  }){
    emit(ShopUpdateDataLoadingState());
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'email': email,
        'name':name,
        'phone':phone
      },
    ).then((value){
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name.toString());
      emit(ShopUpdateDataSuccessState(userModel!));
    }).catchError((error){
      emit(ShopUpdateDataFailureState(error.toString()));
    });
  }



}