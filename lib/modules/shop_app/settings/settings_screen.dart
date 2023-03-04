import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter1/layout/shop_layout/cubit/states.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/components/constants.dart';
import 'package:flutter1/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).userModel;

    nameController.text = model!.data!.name;
    emailController.text = model.data!.email;
    phoneController.text = model.data!.phone;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopUpdateDataLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (s) {
                      if (s!.isEmpty) {
                        return "Name can not be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (s) {
                      if (s!.isEmpty) {
                        return "Email can not be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Phone",
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (s) {
                      if (s!.isEmpty) {
                        return "Phone can not be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: "UPDATE"),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: "LOG OUT"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
