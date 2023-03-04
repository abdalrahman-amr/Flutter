
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter1/models/shop_app/login_model.dart';
import 'package:flutter1/modules/shop_app/login/cubit/states.dart';
import 'package:flutter1/modules/shop_app/register/cubit/states.dart';
import 'package:flutter1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/remote/endpoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordHidden = true;
  IconData suffix = Icons.visibility_outlined;

  late ShopLoginModel loginModel;


  void userRegister ({required String email,required String password,
    required String name,required String phone,

  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email': email,
          'password': password,
          'name':name,
          'phone':phone
        }).then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print("Error");
      emit(ShopRegisterErrorState(error.toString()));
    });

  }

  void togglePassword (){
    isPasswordHidden = ! isPasswordHidden;
    suffix = isPasswordHidden? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterTogglePasswordState());
  }
}