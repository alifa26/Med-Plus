
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/notifications/notification_screen.dart';
import 'package:med/services/ambulance/ambulance_screen.dart';
import 'package:med/services/blood/blood_req_screen.dart';
import 'package:med/services/lab/sen_pdf.dart';
import 'package:med/services/lab/view_pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../services/doctor2/doctors_main_screen.dart';
import '../services/doctor2/doctors_screen.dart';
import '../services/lab/lab_main_screen.dart';
import '../social_app/state.dart';
import 'job.dart';

class homePage extends StatefulWidget {
  const homePage({ Key? key }) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        
         return Scaffold(
          body: SingleChildScrollView(
            child: Container(
                  color: backgroundColor,
                  child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(40),
                    constraints: BoxConstraints.expand(height: 225),
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [c3,lightBlueIsh],
                        begin: const FractionalOffset(1.0, 1.0),
                        end: const FractionalOffset(0.2, 0.2),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30))
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Wellcome ${AppBloc.get(context).user?.username.split(' ')[0]}', style: titleStyleWhite,)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    constraints: BoxConstraints.expand(height:200),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context, index) => BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
                   return InkWell(
                     onTap: (){
                       navigateTo(context, NoScreen());
                     },
                     child: Container(
                         padding: EdgeInsets.all(10),
                         margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
                         height: 150,
                         width: 200,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.red : Colors.yellow[300],
                           boxShadow: [
                             new BoxShadow(
                               color: lightBlueIsh,
                               blurRadius: 20.0,
                             ),
                           ],
                           border: Border.all(color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.red : Colors.yellow,)
                         ),
                       child: Padding(
                           padding: const EdgeInsets.only(left:10,top: 10),
                           child: Column(
                             children: [
                               Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(backgroundColor: Colors.white,backgroundImage:NetworkImage(AppBloc.get(context).notifcList[index].image),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [SizedBox(height: 8,),
                                        Text(AppBloc.get(context).notifcList[index].username,
                                        style: TextStyle(color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,),
                                  
                                      ],
                                    ),
                                  )
                                ],
                               ),
                               SizedBox(height: 10,),
                                Text(AppBloc.get(context).notifcList[index].text,
                                    style: TextStyle(fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                      color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal
                                    ),),
                                    SizedBox(height: 5,),
                                    Text(AppBloc.get(context).notifcList[index].date,
                                    style: TextStyle(
                                      color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal,
                   
                                    ),),
                             ],
                           ),
                         ),
                     ),
                   );
            },
          ),
           separatorBuilder: (context, index) => SizedBox(width: 10,),
            itemCount: AppBloc.get(context).notifcList.length,
            )
                    
                  ),
                  Container(
                    height: 500,
                    margin: EdgeInsets.only(top: 300),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Explore Our Services",
                            
                                      style: TextStyle(
                                        color: lightBlueIsh,
                                        fontWeight: FontWeight.w800
                                      ),
                            ),
                        ),
                        Container(
                          height: 394,
                          child:Expanded(
                            child: Column(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(onTap:(){
                                      navigateTo(context, ambScreen());
                                    },
                                      child: Container(
                                                                      margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
                                                                      height: 180,
                                                                      width: 140,
                                                                      padding: EdgeInsets.all(10),
                                                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: lightGreen,
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                                                      ),
                                                                      child: Column(
                                      children: <Widget>[
                                        Text('Ambulance',
                                        style: TextStyle(
                                          color: lightBlueIsh,
                                          fontWeight: FontWeight.w800
                                        ),),
                                        SizedBox(height: 35,),
                                        Center(
                                          child: Container(
                                             decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey,)],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: AssetImage('images/ambu.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                          ),
                                        )
                                      ],
                                                                      ),
                                                                    ),
                                    ),
                                InkWell(onTap: () async {
                                  navigateTo(context, bloodreq());
                                 
      
/*
    
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAZzxK2OI:APA91bH1GGmWTGQIELlA7zPUF5U6GFE_6e8Z-6fRhP5pcoBcm3PltDWZPofWf7wl9VJ9guy1x34X_3O7_xCvnRewH02ZJ3bTeXVANibrGW_-iGRG1YRCiTyJKUSO-lEBW3DtAZViRa2S',

        },
        body: jsonEncode(
          <String,dynamic>{
            'notification': <String,dynamic>{
              'body': 'HIIIIIIIIIIII',
           'title': 'helllllllo',
            },
            'priority': 'high',
            'data': <String,dynamic>{
              'click_action': 'FLUTTER_NOTIFICATIoN_CLICK',
              'id': '44'
            },
            'to': await FirebaseMessaging.instance.getToken()
          },
          

        ),
      );
     //// print('FCM request for device sent!');
     FirebaseMessaging.onMessage.listen((message) {
       print(message.notification);
       print(message.notification?.body);
       print(message.data['name']);
      });
    */



                                },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
                                    height: 180,
                                    width: 140,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: lightGreen,
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text('Blood Donation',
                                        style: TextStyle(
                                          color: lightBlueIsh,
                                          fontWeight: FontWeight.w800
                                        ),),
                                        SizedBox(height: 35,),
                                        Center(
                                          child: Center(
                                            child: Container(
                                               decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey,)],
                                  ),
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage('images/blood.png'),
                                    backgroundColor: Colors.white,
                                  ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                  ],
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(onTap: (){
                                      navigateTo(context, docMain());
                                    },
                                      child: Container(
                                                                      margin: EdgeInsets.only(right: 10, left: 10, bottom: 14),
                                                                      height: 180,
                                                                      width: 140,
                                                                      padding: EdgeInsets.all(10),
                                                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: lightGreen,
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                                                      ),
                                                                      child: Column(
                                      children: <Widget>[
                                        Text('Doctors',
                                        style: TextStyle(
                                          color: lightBlueIsh,
                                          fontWeight: FontWeight.w800
                                        ),),
                                        SizedBox(height: 35,),
                                        Center(
                                          child: Container(
                                             decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey,)],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: AssetImage('images/doc.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                          ),
                                        )
                                      ],
                                                                      ),
                                                                    ),
                                    ),
                                InkWell(
                                  onTap: (){
                                    if(AppBloc.get(context).ResultList.length == 0){
                                      AppBloc.get(context).getResults();
                                    }
                                    if(AppBloc.get(context).PcrList.length == 0){
                                      AppBloc.get(context).getPCR();
                                    }
                                    if(AppBloc.get(context).LabList == 0){
                                      AppBloc.get(context).getLabs();
                                    }
                                    else{
                                      AppBloc.get(context).LabList = [];
                                      AppBloc.get(context).getLabs();
                                    }
                                    navigateTo(context, labMain());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 14),
                                    height: 180,
                                    width: 140,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: lightGreen,
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text('Labs',
                                        style: TextStyle(
                                          color: lightBlueIsh,
                                          fontWeight: FontWeight.w800
                                        ),),
                                        SizedBox(height: 35,),
                                        Center(
                                          child: Container(
                                             decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey,)],
                                  ),
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage('images/lab.png'),
                                    backgroundColor: Colors.white,
                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
                  ),
                ),
          ),
    );
      },
    );
  }}