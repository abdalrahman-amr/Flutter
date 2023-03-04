import 'package:flutter1/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{

  late final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);

}
class ShopLoginTogglePasswordState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates{
  late final String error ;
  ShopLoginErrorState(this.error){
    print(error.toString());
  }

}