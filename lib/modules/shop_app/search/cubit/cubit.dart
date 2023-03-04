import 'package:flutter1/models/shop_app/search_model.dart';
import 'package:flutter1/modules/shop_app/search/cubit/states.dart';
import 'package:flutter1/shared/components/constants.dart';
import 'package:flutter1/shared/network/remote/dio_helper.dart';
import 'package:flutter1/shared/network/remote/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<ShopSearchState>{


  SearchCubit(): super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text){

    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCHPRODUCT,
        token: token,
        data: {
          'text':text
        }).then((value) {

          searchModel = SearchModel.fromJson(value.data);
          print(searchModel);
          emit(ShopSearchSuccesState(searchModel!));

    }).catchError((error){
      emit(ShopSearchFailureState(error.toString()));

    });





  }





}