import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med/admin/admin_main.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/edit_profile.dart';
import 'package:med/social_app/state.dart';

import 'home page/global.dart';


class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = AppBloc.get(context).user;
        Set<Marker> _markers = {
          
              Marker(markerId: MarkerId('id-1'),
              position: LatLng(double.parse(usermodel!.lat),double.parse(usermodel!.lon)))
        };
        void _onMapCreated(GoogleMapController controller){
          
        }
         final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(usermodel!.lat),double.parse(usermodel!.lon)),
    zoom: 14.4746,
  );

        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){
                navigateTo(context, editProfile());
              }, child: Text('Edit Profile  ',
              style: TextStyle(
                color: Colors.white
              ),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              right: 20,
              left: 20
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [Center(
          child: Stack(alignment: AlignmentDirectional.bottomCenter,
            children:[Container(margin: EdgeInsets.only(top: 15),
              width: 300,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(left:13.0),
                child: CircleAvatar(radius:130,backgroundColor: Colors.white,
                 child: Image(image:AssetImage('images/add.png'),),
                  ),
              ), 
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal,
                           width: 10),
                color: Colors.white,
                shape: BoxShape.circle,
                
              )),
              ////Image.file(File(pickedFile!.path!)
             /// if(pickedFile != null)
              Padding(
                padding: const EdgeInsets.only(top :13),
                child: Stack(alignment: AlignmentDirectional.center,
                  children:[
                    
                  CircleAvatar(backgroundColor: Colors.teal,
                  radius: 160,),CircleAvatar(radius: 150,
                    backgroundImage: NetworkImage(
                    '${usermodel!.image}'
                  ) ,
                  ),]
                ),
              ),
              if(AppBloc.get(context).user!.tag == 'admin')
              InkWell(onTap:(){
                navigateTo(context, AdminMain());
              },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius:BorderRadius.circular(30) 
                      )
                      ,child: Text(' admin page ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),))
                  ],
                ),
              ),
           /* Container(margin: EdgeInsets.only(top: 15),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Image.file(File(pickedFile!.path!),
              fit: BoxFit.contain,
              height: 200,
              width: 200,)),*/
              ] 
          ),
                ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Name : ${usermodel!.username}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height:15
            ),
             Text(
              'Email : ${usermodel!.email}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Phone : ${usermodel!.num}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Blood Type : ${usermodel!.blood}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),SizedBox(
              height: 15,
            ),
              if(usermodel.lat != null) 
            Container(
              width: double.infinity,
              height: 150,
              child:
              GoogleMap(onMapCreated: _onMapCreated,
                initialCameraPosition: _kGooglePlex,
                markers: _markers,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,),
            ),
                ],
              ),
          ),
        );
      },
    );
  }
}

