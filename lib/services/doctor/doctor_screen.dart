import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/services/doctor/appointment_screen.dart';

import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder:(context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
                itemBuilder: (context, index) => BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                   return Container(
                     margin: EdgeInsets.all(20),
                       width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.height / 4 - 20,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: Color.fromARGB(255, 1, 139, 107)
                       ),
                     child: InkWell(onTap: (){
                       navigateTo(context, DoctorApp(doctorDataModel: AppBloc.get(context).doctorslist[index],));
                     },
                       child: Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(AppBloc.get(context).doctorslist[index].image),
                              radius: 55,),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppBloc.get(context).doctorslist[index].doctorname,
                                    style: TextStyle(color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text(AppBloc.get(context).doctorslist[index].specialization,
                                    style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                      color: Colors.white
                                    ),)
                              
                                  ],
                                ),
                              )
                            ],
                           ),
                         ),
                     ),
                   );
                  },
                ),
                separatorBuilder: (context, index) => space5Vertical(context),
                itemCount: AppBloc.get(context).doctorslist.length,
              ),
        );
      }
    );
}}

