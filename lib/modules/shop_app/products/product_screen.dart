

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter1/layout/shop_layout/cubit/states.dart';
import 'package:flutter1/main.dart';
import 'package:flutter1/models/shop_app/categories_model.dart';
import 'package:flutter1/models/shop_app/home_model.dart';
import 'package:flutter1/modules/basics_app/login/loginScreen.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  var cubit;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState){
            if(!state.favoritesModel!.status){
              showToast(text: "Not Authorized", state: toastStates.ERROR);
            }

          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) =>
                  homeBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget homeBuilder(HomeModel? model, CategoriesModel? categoriesModel,BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                  image: NetworkImage(e.image),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
                  .toList(),
              options: CarouselOptions(
                  viewportFraction: 1,
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                style:  Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => buildCatagoryItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: categoriesModel!.data!.data.length),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "New Products",
                  style:Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  )
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1 / 1.7,
                children: List.generate(model!.data!.products.length,
                        (index) => buildGridProduct(model.data!.products[index],context)),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildCatagoryItem(DataModel model){

    return Stack(
      children: [
        Image(
            image: NetworkImage('${model.image}'),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(
              "${model.name}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white
            ),

          ),
        ),

      ],


    );

}


  Widget buildGridProduct(ProductModel model,BuildContext context) {


    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 175,
                  width: double.infinity,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${model.price.round()}",
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
                      if (model.discount != 0)
                        Text(
                          "${model.old_price.round()}",
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
                            ShopCubit.get(context).changeFavourites((model.id));
                          },
                          icon: CircleAvatar(
                            backgroundColor:  ShopCubit.get(context).favourties[model.id]!? defaultColor:Colors.grey,
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
