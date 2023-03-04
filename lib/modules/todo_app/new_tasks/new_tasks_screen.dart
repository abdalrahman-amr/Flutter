import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/cubit/cubit.dart';
import 'package:flutter1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewTasksScreen  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,AppStates states){},
      builder: (context,AppStates state){

        var tasks = AppCubit.get(context).newTasks;

        return buildTaskPage(tasks);
      },

      );
  }
}
