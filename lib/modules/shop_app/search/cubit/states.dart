import 'package:flutter1/models/shop_app/search_model.dart';

abstract class ShopSearchState{}

class ShopSearchInitialState extends ShopSearchState{}
class ShopSearchLoadingState extends ShopSearchState{}
class ShopSearchSuccesState extends ShopSearchState{
  late final SearchModel searchModel;
  ShopSearchSuccesState(this.searchModel);
}


class ShopSearchFailureState extends ShopSearchState{

  late final String error ;
  ShopSearchFailureState(this.error){
    print(error.toString());
  }

}