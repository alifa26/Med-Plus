import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/list%20test/list_screen.dart';
import 'package:med/maps/map_screen.dart';
import 'package:med/notifications/notification_model.dart';
import 'package:med/pdf/up_screen.dart';
import 'package:med/profile.dart';
import 'package:med/services/ambulance/ambulance_screen.dart';
import 'package:med/services/blood/blood_req_screen.dart';
import 'package:med/services/doctor/doctor_screen.dart';
import 'package:med/services/lab/choose_user.dart';
import 'package:med/services/lab/rec_pdf.dart';
import 'package:med/services/lab/sen_pdf.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/edit_profile.dart';
import 'package:med/social_app/messages.dart';
import 'package:med/social_app/posts.dart';
import 'package:med/social_app/search.dart';
import 'package:med/social_app/social_login/social_login_screen.dart';
import 'package:med/social_app/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/social_app/user_model.dart';
import 'package:med/x/x_screen.dart';
import '../home page/home_page.dart';
import '../list test/list_don.dart';
import '../notifications/notification_screen.dart';
import '../services/doctor2/appoint_made.dart';
import '../services/doctor2/dappoints.dart';
import '../services/doctor2/doctors_screen.dart';
import '../services/doctor2/uappoints.dart';

class notiMap extends StatefulWidget {
  const notiMap({ Key? key,
  required this.notidatamodel,
  required this.lat,
  required this.lon}) : super(key: key);
final double lat;
final double lon;
  final NotficModel notidatamodel;
  @override
  _notiMapState createState() => _notiMapState();

}




class _notiMapState extends State<notiMap> {

  
 /* void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyC4s80lhtA9yPj-l7t_jDLVDV2h4bmSGgQ", 
  //  PointLatLng(destination.latitude, destination.longitude),PointLatLng(sourceLocation.latitude, sourceLocation.longitude));
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {
        
      });
    }
    setState(() {
        
      });
  }*/
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
          
              Marker(markerId: MarkerId('id-1'),
              position: LatLng(widget.lat,widget.lon))
        };
        void _onMapCreated(GoogleMapController controller){
          
        }
         final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(widget.lat,widget.lon),
    zoom: 14.4746,
  );

    return Scaffold(
      appBar: AppBar(
        title: Text('Track Request'),
        centerTitle: true,
      ),
      body: Stack(
        children: [ 
           GoogleMap(onMapCreated: _onMapCreated,
                initialCameraPosition: _kGooglePlex,
                markers: _markers,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
            ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                     margin: EdgeInsets.only(top: 20,right:10,left: 10,bottom: 25),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: Colors.yellow[300]
                       ),
                     child: InkWell(onTap: (){
                     },
                       child: Padding(
                           padding: const EdgeInsets.only(right:10.0,left:10,top: 10,bottom: 10),
                           child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(widget.notidatamodel.image),
                              radius: 55,),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.notidatamodel.username,
                                    style: TextStyle(color: Colors.teal,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text(widget.notidatamodel.text,
                                    style: TextStyle(color: Colors.teal,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text(widget.notidatamodel.number,
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
                   )
          ],
        )
        ],
      )
    );
  }
}