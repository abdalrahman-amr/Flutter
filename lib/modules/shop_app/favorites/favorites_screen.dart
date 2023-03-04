import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/models/shop_app/favorites_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>
      (
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: (state is! ShopLoadingGetFavoritesState ),
          fallback:(context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
              separatorBuilder: (context,index) => buildDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
        );
      },

    );
  }

  Widget buildFavItem(FavoritesData model,BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120 ,
                  ),
                  if (model.product!.discount! != 0 )
                    Container(
                      color: Colors.red,
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                        ),
                      ),
                    ),


                ],
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${model.product!.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
                       fontWeight: FontWeight.bold,
                       fontSize: 14,
                       height: 1.3,
                     )// TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 14,
                    //   height: 1.3,
                    // ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${model.product!.price.round()}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          height: 1.3,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (true)
                        Text(
                          "${model.product!.oldPrice.round()}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            ShopCubit.get(context).changeFavourites((model.product!.id!));
                          },
                          icon: CircleAvatar(
                            backgroundColor:  ShopCubit.get(context).favourties[model.product!.id!]!? defaultColor:Colors.grey,
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              size: 12,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}
