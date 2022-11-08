import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:med/maps/noti_map.dart';
import 'package:med/maps/reqmap.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

class NoScreen extends StatelessWidget {
  const NoScreen({ Key? key }) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Notifications',
            style:TextStyle(
              color: Colors.teal
            )),
            centerTitle: true,
          ),
          body: ListView.separated(itemBuilder:(context, index) => BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
         
  /////String a= AppBloc.get(context).user!.lat[0]+AppBloc.get(context).user!.lat[1]+'.'+AppBloc.get(context).user!.lat[3]+AppBloc.get(context).user!.lat[4];
 /* String b=AppBloc.get(context).notifcList[index].lat.substring(2,AppBloc.get(context).notifcList[index].lat.length-1);
  String c = '${a}.${b}';*/
 //// double latt = double.parse(AppBloc.get(context).user!.lat[0]+AppBloc.get(context).user!.lat[1]+'.'+AppBloc.get(context).user!.lat[3]+AppBloc.get(context).user!.lat[4]);

                   return Container(
                     margin: EdgeInsets.only(top: 20,right:10,left: 10),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.red : Colors.yellow[300],
                         border: Border.all(color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.red : Colors.yellow,)
                       ),
                     child: Padding(
                         padding: const EdgeInsets.only(right:10.0,left:10,top: 10),
                         child: Row(
                          children: [
                            CircleAvatar(backgroundColor: Colors.white,backgroundImage:NetworkImage(AppBloc.get(context).notifcList[index].image),
                            radius: 55,),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppBloc.get(context).notifcList[index].username,
                                  style: TextStyle(color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: 10,),
                                  Text(AppBloc.get(context).notifcList[index].text,
                                  style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                    color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal
                                  ),),
                                  SizedBox(height: 5,),
                                  Text(AppBloc.get(context).notifcList[index].date,
                                  style: TextStyle(
                                    color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal
                                  ),),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(onPressed: (){
                                        navigateTo(context, reqmap(notidatamodel:AppBloc.get(context).notifcList[index],
                                        lat: double.parse(AppBloc.get(context).notifcList[index].lat),
                                        lon: double.parse(AppBloc.get(context).notifcList[index].lon)
                                         ));
    
                                      }, child: Text('more details',
                                      style: TextStyle(
                                        color: AppBloc.get(context).notifcList[index].type == 'ambulance' ? Colors.white : Colors.teal
                                      ),))
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
            itemCount: AppBloc.get(context).notifcList.length,
            )
        );
      },
    );
  }}