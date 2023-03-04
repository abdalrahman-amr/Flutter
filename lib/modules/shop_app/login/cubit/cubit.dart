
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter1/models/shop_app/login_model.dart';
import 'package:flutter1/modules/shop_app/login/cubit/states.dart';
import 'package:flutter1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/remote/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordHidden = true;
  IconData suffix = Icons.visibility_outlined;

  late ShopLoginModel loginModel;


  void userLogin ({required String email,required String password,
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        }).then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });

  }

  void togglePassword (){
    isPasswordHidden = ! isPasswordHidden;
    suffix = isPasswordHidden? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopLoginTogglePasswordState());
  }
}