import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';
import 'appoint_done.dart';
import 'appoint_screen.dart';

class Appmade extends StatelessWidget {
  const Appmade({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text('Confirm Appointment'
              ,style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: Colors.teal
              ),),
              LottieBuilder.asset('images/calendar.json'),
              Text('Your Appointment with dr Maya Markabawi is on',
              style: TextStyle(
                fontSize: 15,
                color: Colors.teal
              ),),
              SizedBox(height: 15),
              Text('13 - 4 - 2022',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.green
              ),),
              SizedBox(height: 10,),
              Text('at 04:04',
              style:
              TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.green
              )),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){}, child: Text('Choose another'),),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    navigateTo(context, Appdone());
                  }, child: Text('Confirm'),style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white
                  ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}