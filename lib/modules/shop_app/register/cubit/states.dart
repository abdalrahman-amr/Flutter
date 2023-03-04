import 'package:flutter1/models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{

  late final ShopLoginModel registerModel;
  ShopRegisterSuccessState(this.registerModel);

}
class ShopRegisterTogglePasswordState extends ShopRegisterStates{}

class ShopRegisterErrorState extends ShopRegisterStates{
  late final String error ;
  ShopRegisterErrorState(this.error){
    print(error.toString());
  }

}