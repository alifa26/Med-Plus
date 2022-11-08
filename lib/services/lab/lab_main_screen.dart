import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/services/lab/choose_lab.dart';
import 'package:med/services/lab/choose_user.dart';
import 'package:med/services/lab/pcr.dart';
import 'package:med/services/lab/pcr_lab.dart';
import 'package:med/services/lab/rec_pdf.dart';
import 'package:med/services/lab/resultScreen.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

class labMain extends StatelessWidget {
  const labMain({ Key? key }) : super(key: key);

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
                  if(AppBloc.get(context).user!.tag == 'lab' || AppBloc.get(context).user!.tag == 'admin' )
                  InkWell(onTap: (){
                  navigateTo(context, ChooseUser());
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
                            backgroundImage: AssetImage('images/result.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('Send Results File',
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
                if(AppBloc.get(context).user!.tag == 'lab' || AppBloc.get(context).user!.tag == 'admin' )
                InkWell(onTap: (){
                  navigateTo(context, pcrlab());
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
                            backgroundImage: AssetImage('images/pcr 2.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('PCR Requests',
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
                if(AppBloc.get(context).user!.tag != 'lab')
                InkWell(onTap: (){
                  navigateTo(context, ChooseLab());
                  if(AppBloc.get(context).LabList == 0){
      AppBloc.get(context).getLabs();
    }
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
                            backgroundImage: AssetImage('images/pcr.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('PCR Appointment',
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
                if(AppBloc.get(context).user!.tag != 'lab')
                InkWell(onTap: (){
                  navigateTo(context, ResultScreen());
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
                            backgroundImage: AssetImage('images/result.png'),
                          ),
                          SizedBox(width: 20,),
                          Text('View Results File',
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