import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';

class DoneTasksScreen  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,AppStates states){},
      builder: (context,AppStates state){

        var tasks = AppCubit.get(context).doneTasks;

        return buildTaskPage(tasks);
      },

    );
  }
}
