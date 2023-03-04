import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var  formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,

                    validator: (value){
                        if (value!.isEmpty) {
                          return "Email can't be empty";
                        }
                        return null;

                   },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email Address",
                      prefixIcon: Icon(Icons.email),

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: hidePassword,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                        onPressed: (){
                            setState(() {

                                hidePassword = !hidePassword;
                              }
                            );
                        },

                      ),
                    ),

                    validator: (value){

                        if (value!.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;

                    },

                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () {

                        if(formKey.currentState!.validate()){
                          print(emailcontroller.text);
                          print(passwordcontroller.text);
                        }

                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an email?"),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
