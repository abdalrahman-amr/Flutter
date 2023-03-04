import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = NewsCubit.get(context).science;

    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state) {},
      builder:(context,state) {
        list = NewsCubit.get(context).science;
        return buildNewsList(list,context);
      },
    );
  }
}
