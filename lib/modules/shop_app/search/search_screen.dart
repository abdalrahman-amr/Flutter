import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/shop_layout/cubit/states.dart';
import 'package:flutter1/modules/shop_app/search/cubit/cubit.dart';
import 'package:flutter1/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class SearchShopScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state){
          return BlocConsumer<SearchCubit, ShopSearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Search",
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter some text to search";
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            SearchCubit.get(context).search(value);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (state is ShopSearchLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        if (state is ShopSearchSuccesState)
                          Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => buildGriditem(
                                    SearchCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data![index],
                                    context),
                                separatorBuilder: (context, index) =>
                                    buildDivider(),
                                itemCount: SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data!
                                    .length),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

        },
      ),
    );
  }

  Widget buildGriditem(Product model, BuildContext context) {
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
                    image: NetworkImage(model.image!),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text("${model.name}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.3,
                          ) // TextStyle(
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
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavourites((model.id!));
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favourties[model.id!]!
                                    ? defaultColor
                                    : Colors.grey,
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
