import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/social_app/home_screen.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';
import 'appoint_screen.dart';

class Appdone extends StatelessWidget {
  const Appdone({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
              Lottie.asset('images/done4.json')
              ],
            ),
            SizedBox(height: 30,),
            Text('Now its all set and done',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.green
              ),),
            Text('help is on the way',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.green
              ),),
            Text('be safe',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.green
              ),),
              Text('',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.green
              ),),
              SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              navigateAndFinish(context, HomeScreen());
            }, child: Text('Back Home',
            style: TextStyle(
              fontSize: 30
            ),),
            style: ElevatedButton.styleFrom(
              primary: Colors.yellow,
              minimumSize: Size(280,80)
            ),)
          ],
        ),
      ),
    );
  }
}