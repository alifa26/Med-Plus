import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/explore/pharmacy/choose_pharmacy.dart';
import 'package:med/explore/pharmacy/send_perc.dart';
import 'package:med/explore/pharmacy/view_recep.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/services/lab/choose_user.dart';
import 'package:med/services/lab/pcr.dart';
import 'package:med/services/lab/pcr_lab.dart';
import 'package:med/services/lab/rec_pdf.dart';
import 'package:med/services/lab/resultScreen.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

class pharmMain extends StatelessWidget {
  const pharmMain({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Center(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width:double.infinity,
                    decoration: BoxDecoration(
                      color: backgroundColor,
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
                  ),
                  if(AppBloc.get(context).user!.tag != 'pharmacy' )
                  InkWell(onTap: (){
                  navigateTo(context, choosePharm());
                  /*FirebaseFirestore.instance.collection('main pharmacy').doc('Ali Ahmad').set({
                    
      'lat': '0',
      'name': 'ali ahmad',
      'email': 'neofahmad@gmail.com',
      'number': '0937076359',
      'image': '',
      'lon': '0',
                  });*/
                },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(decoration: BoxDecoration(
                       color: Colors.white
                       ,borderRadius: BorderRadius.circular(30),
                       boxShadow: [ new BoxShadow( color: lightBlueIsh,
                        blurRadius: 10.0, )
                        , ],
                        ),
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [SizedBox(width: 20,),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('images/pharmacy.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('Choose Pharmacy',
                          style:TextStyle(
                            color: lightBlueIsh,
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height:10),
                if(AppBloc.get(context).user!.tag == 'pharmacy' ||AppBloc.get(context).user!.tag == 'admin')
                InkWell(onTap: (){
                  navigateTo(context,viewPerc() );
                 /* FirebaseFirestore.instance.collection('Pharmacy').doc('main pharmacy').set({
                    
      'number': "0912345678",
      'name': 'main pharmacy',
      'email': 'pharmacy@gmail.com',
      'image': '',
                  });*/
                },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(decoration: BoxDecoration(
                       color: Colors.white
                       ,borderRadius: BorderRadius.circular(30),
                       boxShadow: [ new BoxShadow( color: lightBlueIsh,
                        blurRadius: 10.0, )
                        , ],
                        ),
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [SizedBox(width: 20,),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('images/pharmacy2.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('Persceptions',
                          style:TextStyle(
                            color: lightBlueIsh,
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}