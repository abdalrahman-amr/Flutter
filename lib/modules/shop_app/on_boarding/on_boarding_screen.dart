import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/shared/components/components.dart';
import 'package:flutter1/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login.dart';

class boardingModel{
  late final String title;
  late final String body;
  late final String image;

  boardingModel({
    required this.image,
    required this.title,
    required this.body
});
}




class OnBoardingScreen extends StatelessWidget {

  List<boardingModel> boardingScreens =[
    boardingModel(
        image: "assets/images/onboarding1.png",
        title: "On Boarding title 1",
        body: "On Boarding body 1"
    ),
    boardingModel(
        image: "assets/images/onboarding1.png",
        title: "On Boarding title 2",
        body: "On Boarding body 2"
    ),
    boardingModel(
        image: "assets/images/onboarding1.png",
        title: "On Boarding title 3",
        body: "On Boarding body 3"
    ),
  ];
  bool isLast = false  ;

  var pageController = PageController();

  void submit(BuildContext context){

    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());

      }
    });
    
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                submit(context);
              },
              text: "SKIP")
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){

                  if(index == boardingScreens.length-1){
                    isLast = true;
                  }
                  else{
                    isLast = false;
                  }

                },
                controller: pageController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) => buildBoardingItem(boardingScreens[index]),
                itemCount: boardingScreens.length ,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boardingScreens.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                      submit(context);
                      }
                      else{
                        pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(boardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),

        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 20,),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ],
  );
}
