import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/services/doctor2/app_profile.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';
import 'appoint_screen.dart';

class Dappoints extends StatelessWidget {
  const Dappoints({ Key? key }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('View Your Appointments',
            style:TextStyle(
              color: Color.fromARGB(255, 190, 171, 0)
            )),
            centerTitle: true,
          ),
          body: ListView.separated(itemBuilder:(context, index) => BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
                   return Container(/*
                     margin: EdgeInsets.all(20),
                       width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.height / 4 - 20,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: Colors.white,
                         border: Border.all(color: Color.fromARGB(255, 190, 171, 0),width: 7)
                       ),*/
                     child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Row(
                          children: [
                            CircleAvatar(backgroundImage:NetworkImage(AppBloc.get(context).AppointsList[index].image),
                            radius: 55,),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${AppBloc.get(context).AppointsList[index].username} have an appointment in :',
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: 10,),
                                  Text('      ${AppBloc.get(context).AppointsList[index].day} - ${AppBloc.get(context).AppointsList[index].month} - ${AppBloc.get(context).AppointsList[index].year} at ${AppBloc.get(context).AppointsList[index].hour}:${AppBloc.get(context).AppointsList[index].minute}',
                                  style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 217, 255)
                                  ),),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(onPressed: (){
                                        navigateTo(context, AppProfile(profileImage: AppBloc.get(context).AppointsList[index].image,
                                         name: AppBloc.get(context).AppointsList[index].username,
                                          number: AppBloc.get(context).AppointsList[index].number,
                                           email: AppBloc.get(context).AppointsList[index].email,
                                            lon: AppBloc.get(context).AppointsList[index].lon,
                                             latt: AppBloc.get(context).AppointsList[index].lat));
                                      }, child: Text('view profile'))
                                    ],
                                  )
                            
                                ],
                              ),
                            )
                          ],
                         ),
                       ),
                   );
            },
          ),
           separatorBuilder: (context, index) => Container(height: 0,width:double.infinity,color: Colors.black,),
            itemCount: AppBloc.get(context).AppointsList.length,
            )
        );
      },
    );
  }}