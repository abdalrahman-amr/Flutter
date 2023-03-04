
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/layout/shop_layout/shop_layout.dart';
import 'package:flutter1/modules/shop_app/login/cubit/cubit.dart';
import 'package:flutter1/modules/shop_app/login/cubit/states.dart';
import 'package:flutter1/modules/shop_app/register/register_screen.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/constants.dart';

class ShopLoginScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status ){
              print(state.loginModel.message);

              showToast(text: state.loginModel.message!, state: toastStates.SUCCESS);

              CacheHelper.saveData(key: "token", value: state.loginModel.data?.token ).then((value) {
                navigateAndFinish(context, ShopLayout());
                token = state.loginModel.data?.token;
              });
            }
            else{
              print(state.loginModel.message);
              showToast(text: state.loginModel.message!, state: toastStates.ERROR);
            }
          }
        },
        builder:(context,state){
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
                          "Login",
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black,) ,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "log in now to view our offers",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey,) ,
                        ),
                        SizedBox(height: 25,),
                        TextFormField(
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty){
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
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password cannot be empty";
                            }
                          },
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(email :emailController.text.toString(), password :passwordController.text.toString());
                            }
                          },
                          obscureText: ShopLoginCubit.get(context).isPasswordHidden,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(onPressed: (){
                              ShopLoginCubit.get(context).togglePassword();
                            }, icon: Icon( ShopLoginCubit.get(context).suffix)),


                          ),

                        ),
                        SizedBox(height: 15,),

                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) {
                          return defaultButton(function: (){

                            if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(email :emailController.text, password :passwordController.text);
                              }

                          },
                              text: "Login");
                        },
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),

                        Row(
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5,),
                            defaultTextButton(function: (){
                              navigateTo(context, RegisterScreen());

                            }, text: "REGISTER"),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
