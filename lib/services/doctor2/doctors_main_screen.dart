import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/services/doctor2/appmodel.dart';
import 'package:med/services/doctor2/dappoints.dart';
import 'package:med/services/doctor2/doctors_screen.dart';
import 'package:med/services/doctor2/uappoints.dart';
import 'package:med/services/lab/choose_user.dart';
import 'package:med/services/lab/rec_pdf.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

class docMain extends StatefulWidget {
  const docMain({ Key? key }) : super(key: key);

  @override
  State<docMain> createState() => _docMainState();
}

class _docMainState extends State<docMain> {
 @override
  void initState() {
    super.initState();
    if(AppBloc.get(context).AppointsList.length == 0){
      AppBloc.get(context).getAppoints();
    }
   
  }
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
                  InkWell(onTap: (){
                  navigateTo(context, DoctorsScreen());
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
                            backgroundImage: AssetImage('images/docs.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('Make Appointment',
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
                Stack(
                  children: [
                    InkWell(onTap: (){
                  /*FirebaseFirestore.instance.collection('Appoints Ali Ahmad').get().then((value) {
    value.docs.forEach((element){
      AppBloc.get(context).AppointsList.add(AppModel.fromJson(element.data()));
    });
    });*/
    if (AppBloc.get(context).AppointsList.length != 0){
      AppBloc.get(context).AppointsList=[];
      AppBloc.get(context).getAppoints();
    }
    else{
      AppBloc.get(context).getAppoints();
    }
    navigateTo(context, Uappoints());
                  
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
                            backgroundImage: AssetImage('images/appoints.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('Appointments Made',
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
                if(AppBloc.get(context).user!.tag == 'doctor')
                InkWell(onTap: (){
                  /*FirebaseFirestore.instance.collection('Appoints Ali Ahmad').get().then((value) {
    value.docs.forEach((element){
      AppBloc.get(context).AppointsList.add(AppModel.fromJson(element.data()));
    });
    });*/
  if (AppBloc.get(context).AppointsList.length != 0){
      AppBloc.get(context).AppointsList=[];
      AppBloc.get(context).getAppoints();
    }
    else{
      AppBloc.get(context).getAppoints();
    }
    navigateTo(context, Dappoints());
                  
                
                  
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
                            backgroundImage: AssetImage('images/appoints.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('Youre Appointments',
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
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}