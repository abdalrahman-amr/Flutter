import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter1/layout/shop_layout/cubit/states.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
      (
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildCategoryRow(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
            separatorBuilder: (context,index) => buildDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
      },

    );
  }
  Widget buildCategoryRow(DataModel model,context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
              image: NetworkImage(model.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10,),
          Text(
            model.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,

            ),
          ),
          Spacer(),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
