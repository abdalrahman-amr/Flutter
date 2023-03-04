import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:flutter1/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:flutter1/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/components/constants.dart';
import '../../shared/cubit/states.dart';

class TodoScreen extends StatelessWidget
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  var taskTitlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDB(),

      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context, AppStates state){

          if(state is AppInsertToDBState){
            Navigator.pop(context);

          }
        } ,
        builder: (context, AppStates state){
          AppCubit cubit = AppCubit.get(context);

          return
            Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetFromDBLoadingState ,
              builder: (context) => cubit.Screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ) ,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.inserttoDB(taskTitlecontroller.text, datecontroller.text, timecontroller.text);
                    taskTitlecontroller.clear();
                    datecontroller.clear();
                    timecontroller.clear();
                  }
                } else {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Container(

                      width: double.infinity,
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // defaultTextForm(
                            TextFormField(
                              controller: taskTitlecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Task title",
                                prefixIcon: Icon(
                                  Icons.title,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Title can't be empty";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            // defaultTextForm(
                            TextFormField(
                              controller: timecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Time",
                                prefixIcon: Icon(
                                  Icons.watch_later_outlined,
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Time can't be empty";
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timecontroller.text =
                                      value!.format(context).toString();
                                  print(timecontroller.text);
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // defaultTextForm(
                            TextFormField(
                              controller: datecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Date",
                                prefixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Date can't be empty";
                                }
                                return null;
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                  initialDate: DateTime.now(),
                                ).then((value) {
                                  datecontroller.text =
                                      DateFormat.yMMMd().format(value!);
                                  print(datecontroller.text);
                                });
                              },)
                          ],
                        ),
                      ),
                    ),
                    elevation: 20,
                  ).closed.then((value){
                    cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);

                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.addFAB),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
