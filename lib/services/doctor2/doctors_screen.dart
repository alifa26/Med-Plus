import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/services/doctor/appointment_screen.dart';

import '../../home page/global.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';
import 'appoint_screen.dart';

class DoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder:(context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Choose Doctor',
            ),
            centerTitle: true,
          ),
          body: ListView.separated(
                itemBuilder: (context, index) => BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                   return Container(
                     margin: EdgeInsets.all(5),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: c2,
                         boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
                       ),
                       
                     child: InkWell(onTap: (){
                       navigateTo(context, appointScreen(doctorsDataModel: AppBloc.get(context).doclist[index].values.single,));
                     },
                       child: Padding(
                           padding: const EdgeInsets.only(left :10.0),
                           child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(AppBloc.get(context).doclist[index].values.single.image),
                              radius: 55,),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppBloc.get(context).doclist[index].values.single.doctorname,
                                    style: TextStyle(color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text(AppBloc.get(context).doclist[index].values.single.specialization,
                                    style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                      color: Colors.white
                                    ),),
                                    SizedBox(height: 10,),
                                    Text(AppBloc.get(context).doclist[index].values.single.dId,
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
                itemCount: AppBloc.get(context).doclist.length,
              ),
        );
      }
    );
}}

