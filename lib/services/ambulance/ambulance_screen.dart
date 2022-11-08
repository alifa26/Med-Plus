import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:med/notifications/notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../../home page/global.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../doctor2/appoint_done.dart';


class ambScreen extends StatelessWidget {
  String alpha = 'name : x\nneeds Ambulance\nlocation: long:\nlat:';
    Position? _position;
  late double lat;
  late double lon;

 /* void _getCurrentLocation() async {
    Position position = await _determinePosition();
    
      _position = position;
      lat = _position!.latitude;
      lon = _position!.longitude;

    }*/
  

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
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 240, 216, 0),
      title: Text('Request Ambulance'),
      elevation: 0,),
      body: Column(
        children: [Container(
                       width: double.infinity,
                       height: MediaQuery.of(context).size.height / 4 - 20,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                         color: Color.fromARGB(255, 240, 216, 0)
                       ),
                     child: InkWell(onTap: (){},
                       child: Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: Row(
                            children: [
                              LottieBuilder.asset('images/location.json'),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Keep Calm Help is on the way',
                                    style: TextStyle(color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text('just send us your location',
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
                             Container(
                          height: 50.0,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 216, 0),
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
                               /* if(_position != null){
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
                            /*NotficModel nm =NotficModel(uId: AppBloc.get(context).user!.uId
                            , username: AppBloc.get(context).user!.username,
                             text: 'Needs Ambulance',
                              type: 'amb',
                               image: AppBloc.get(context).user!.image,
                                date: formattedDate.toString(),
                                 lat: lat.toString(),
                                  lon: lon.toString(),
                                   number: '0937076359');*/
                                   
                                   FirebaseFirestore.instance.collection('Notification').doc(AppBloc.get(context).user!.username).set({
                                      'uId' : AppBloc.get(context).user!.uId,
                                     'username' : AppBloc.get(context).user!.username,
                                     'text' : 'Needs Ambulance',
                              'type': 'ambulance',
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
                              'Send Location',
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
                            color: Color.fromARGB(255, 240, 216, 0),
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
                                await launch('smsto:0937076359?body=name : ${AppBloc.get(context).user!.username}\needs ambulance\nlocation: long:${lon.toString()}\nlat:${lat.toString()}');
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
                            color: Color.fromARGB(255, 240, 216, 0),
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
                        Container(
                          height: 50.0,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 216, 0),
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: MaterialButton(
                            height: 42.0,
                            onPressed: () async{
                              if(await canLaunch('tel:911')){
                                await launch('tel:911');
                              }},
                            child:  const Text(
                              'Call 911',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
          
                      ]      ),
            ),
          ),
        ],
      ),
      );
  }
}
/// https://www.google.com/maps/search/?api=1&query=${},${}