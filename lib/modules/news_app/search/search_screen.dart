
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/news_app/cubit/states.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = NewsCubit.get(context).search;

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
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
                      return "Search can't be empty";
                    }
                    return null;
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(child: buildNewsList(list, context)),


            ],
          ),


        );

      } ,
    );
  }
}
