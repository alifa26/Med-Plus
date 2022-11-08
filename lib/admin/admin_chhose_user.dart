import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/admin/edit_user.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/services/lab/sen_pdf.dart';

import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

class AdminChooseUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder:(context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Choose user',
            style:TextStyle(
              color: Colors.teal
            )),
            backgroundColor: backgroundColor,
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView.separated(
                itemBuilder: (context, index) => BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                   return Container(
                     margin: EdgeInsets.only(top: 20,right:10,left: 10),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: Colors.yellow[300]
                       ),
                     child: InkWell(onTap: (){
                       navigateTo(context, editUser(usermodel: AppBloc.get(context).usersList[index]));
                     },
                       child: Padding(
                           padding: const EdgeInsets.only(right:10.0,left:10,top: 10,bottom: 10),
                           child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(AppBloc.get(context).usersList[index].image),
                              radius: 55,),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppBloc.get(context).usersList[index].username,
                                    style: TextStyle(color: Colors.teal,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text(AppBloc.get(context).usersList[index].email,
                                    style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                      color: Colors.teal
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
                separatorBuilder: (context, index) => Container(
                  height: 0,
                  width:double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal
                  ),
                )),
                itemCount: AppBloc.get(context).usersList.length,
              ),
        );
      }
    );
}}

