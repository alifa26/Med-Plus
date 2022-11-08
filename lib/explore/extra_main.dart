

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med/explore/news/news_main.dart';
import 'package:med/explore/pharmacy/pharmacy_main.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/posts.dart';

import '../social_app/cubit.dart';

class extraMain extends StatelessWidget {
  const extraMain({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:SafeArea(
       child: Center(
         child: Column(
           children: [
             Container(
               height: 170,
               width: double.infinity,
               child: Center(child: Text('Explore and Communicate',
               style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontSize: 24,
                     shadows: [
       Shadow(
            blurRadius: 10.0,
            color: c1,
            ),
       
        ],
                  ),
                  )),
             )
             ,Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Ink.image(
                  image: AssetImage('images/pharm.png'),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, pharmMain());
                      if(AppBloc.get(context).PercList.length == 0){
                        AppBloc.get(context).getPerc();
                      }
                    },
                  ),
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
                ),
                  child: Text(
                    '  Medics on Demand  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Ink.image(
                  image: AssetImage('images/social.png'),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, PostsScreen());
                    },
                  ),
                  height: 150,
                  fit: BoxFit.cover,
                ),Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
                ),
                  child: Text(
                    '  Med Club  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Ink.image(
                  image: AssetImage('images/news.png'),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, newsMain());
                    },
                  ),
                  height: 150,
                  fit: BoxFit.cover,
                ),Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
                ),
                  child: Text(
                    '  Latest Med News  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          )],
         ),
       ),
     )
   );
  }
}