import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter1/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter1/modules/shop_app/register/cubit/states.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout/shop_layout.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/cubit/cubit.dart';
import '../register/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              print(state.registerModel.status);
              showToast(
                  text: state.registerModel.message!,
                  state: toastStates.SUCCESS);
              CacheHelper.saveData(
                      key: "token", value: state.registerModel.data?.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
                token = state.registerModel.data?.token;
              });
            } else {
              showToast(
                  text: state.registerModel.message!, state: toastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_outlined),
                            //suffixIcon: IconButton(onPressed: suffixPressed!(), icon: Icon(suffix)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);
                            }
                          },
                          obscureText:
                              ShopRegisterCubit.get(context).isPasswordHidden,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  ShopRegisterCubit.get(context)
                                      .togglePassword();
                                },
                                icon: Icon(
                                    ShopRegisterCubit.get(context).suffix)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username cannot be empty";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone cannot be empty";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }

                              },
                              text: "REGISTER"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
