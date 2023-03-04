import 'package:flutter1/models/shop_app/login_model.dart';

import '../../../models/shop_app/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBotNavState extends ShopStates{}

class ShopLoadingHomeState extends ShopStates{}
class ShopSuccessHomeState extends ShopStates{}

class ShopFailureHomeState extends ShopStates{
  late final String error ;
  ShopFailureHomeState(this.error){
    print(error.toString());
  }

}



class ShopSuccessCategoriesState extends ShopStates{}

class ShopFailureCategoriesState extends ShopStates{
  late final String error ;
  ShopFailureCategoriesState(this.error){
    print(error.toString());
  }

}


class ShopSuccessChangeFavoritesState extends ShopStates{

   final ChangeFavoritesModel? favoritesModel;
  ShopSuccessChangeFavoritesState(this.favoritesModel);
}

class ShopFailureChangeFavoritesState extends ShopStates{
  late final String error ;
  ShopFailureChangeFavoritesState(this.error){
    print(error.toString());
  }


}
class ShopSuccessGetFavoritesState extends ShopStates{
}
class ShopLoadingGetFavoritesState extends ShopStates{
}

class ShopFailureGetFavoritesState extends ShopStates{
  late final String error ;
  ShopFailureGetFavoritesState(this.error){
    print(error.toString());
  }
}

class ShopSuccessUserDataState extends ShopStates{

}
class ShopLoadingUserDataState extends ShopStates{
}

class ShopFailureUserDataState extends ShopStates{
  late final String error ;
  ShopFailureUserDataState(this.error){
    print(error.toString());
  }
}


class ShopUpdateDataLoadingState extends ShopStates{}
class ShopUpdateDataSuccessState extends ShopStates{

  late final ShopLoginModel loginModel;
  ShopUpdateDataSuccessState(this.loginModel);

}

class ShopUpdateDataFailureState extends ShopStates{
  late final String error ;
  ShopUpdateDataFailureState(this.error){
    print(error.toString());
  }

}
