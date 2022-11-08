

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../notifications/notification_model.dart';
import '../social_app/cubit.dart';
import '../social_app/state.dart';

class reqmap extends StatefulWidget {
  const reqmap({ Key? key,
  
  required this.notidatamodel,
  required this.lat,
  required this.lon }) : super(key: key);
final double lat;
final double lon;
  final NotficModel notidatamodel;


  @override
  _reqmapState createState() => _reqmapState();

}


class _reqmapState extends State<reqmap> {
  @override
 
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        Set<Marker> _markers = {
          
              Marker(markerId: MarkerId('id-1'),
              position: LatLng(widget.lat,widget.lon))
        };
        
         final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(widget.lat,widget.lon),
    zoom: 14.4746,
  );

        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
               GoogleMap(
                initialCameraPosition: _kGooglePlex,
                markers: _markers,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,),
                
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
          ),
        );
      
      },
    );
  }}