
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:med/services/doctor2/appoint_done.dart';
import 'package:med/social_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../../home page/global.dart';
import '../../social_app/cubit.dart';

class bloodreq extends StatelessWidget {
  Position? _position;
  late double lat;
  late double lon;

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    
      _position = position;
      lat = _position!.latitude;
      lon = _position!.longitude;

    }
  

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,
      title: Text('Request Blood Donation'),
      elevation: 0,),
      body: Column(
        children: [Container(
                       width: double.infinity,
                       height: MediaQuery.of(context).size.height / 4 - 20,
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.red,
                         width: 10),
                         borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                         color: Colors.white
                       ),
                     child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Row(
                          children: [
                            LottieBuilder.asset('images/blood2.json'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hope You Get The Help You Need ASAP',
                                  style: TextStyle(color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: 10,),
                                  Text('share your location and blood type',
                                  style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                    color: Colors.redAccent
                                  ),)
                            
                                ],
                              ),
                            )
                          ],
                         ),
                       ),
                   ),
                   
          Center(
            child: Center(
              child: Column(
                children: [
                 /* Text('send us',
                  style: TextStyle(color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),),*/
                  
                 /// LottieBuilder.asset('images/ambulance.json'),
                  
                         SizedBox(height: 30,),
                         Text('your blood type is automaticaly shared',
                        style: TextStyle(color: Colors.red),),
                        SizedBox(height: 10,),
                             Container(
                          height: 50.0,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: MaterialButton(
                            height: 42.0,
                            onPressed: () async{
                              
                               Position position = await _determinePosition();
    
                                _position = position;
                                lat = _position!.latitude;
                                lon = _position!.longitude;
                             /*   if(_position != null){
                              final url ='https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lon.toString()}';
                              if(await canLaunch(url)){
                                await launch(
                                  url,
                                  forceWebView: true,
                                  enableJavaScript: true
                                );
                              }
                            }*/
                            DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('kk:mm EEE d MMM').format(now);
                            FirebaseFirestore.instance.collection('Notification').doc(AppBloc.get(context).user!.username).set({
                                      'uId' : AppBloc.get(context).user!.uId,
                                     'username' : AppBloc.get(context).user!.username,
                                     'text' : 'Needs ${AppBloc.get(context).user!.blood} donation',
                              'type': '',
                               'image': AppBloc.get(context).user!.image,
                                'date': formattedDate.toString(),
                                 'lat': lat.toString(),
                                  'lon': lon.toString(),
                                   'number': AppBloc.get(context).user!.num
                                   }).then((value) =>{
                                     AppBloc.get(context).notifcList = []
                                   }).then((value){
                                     AppBloc.get(context).getNotifc();
                                   }).then((value){

     Fluttertoast.showToast(
                                  msg: 'Request Sent',
                                  backgroundColor: lightGreen
                                ).then((value){
     Navigator.pop(context);
                                });
     });
                            },
                            child:  const Text(
                              'Share Location',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:20
                        ),
                        Text('no connection ?',
                        style: TextStyle(color: Colors.red),),
                        Text('dont worry you still able to get help',
                        style: TextStyle(color: Colors.red),),
                        SizedBox(
                          height:10
                        ),
                        Container(
                          height: 50.0,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: MaterialButton(
                            height: 42.0,
                            onPressed: () async{
                                Position position = await _determinePosition();
    
                                _position = position;
                                lat = _position!.latitude;
                                lon = _position!.longitude;
                              if(_position != null){
                              if(await canLaunch('smsto:0937076359?body=')){
                                await launch('smsto:0937076359?body=name : ${AppBloc.get(context).user!.username}\nneeds blood donatin of AB+ type\nlocation: long:${lon.toString()}\nlat:${lat.toString()}');
                              }}
                            },
                            child:  const Text(
                              'Via SMS',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:10
                        ),
                        Container(
                          height: 50.0,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: MaterialButton(
                            height: 42.0,
                            onPressed: () async{
                              if(await canLaunch('tel:0937076359')){
                                await launch('tel:0937076359');
                              }
                            },
                            child:  const Text(
                              'Call Us',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:10
                        ),
                        
          
                      ]      ),
            ),
          ),
        ],
      ),
      );
  
  }
}
/////'smsto:+39 348 060 888?body=hello%20there'