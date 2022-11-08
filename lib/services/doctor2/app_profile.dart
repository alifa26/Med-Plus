import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/state.dart';


class AppProfile extends StatefulWidget {
  const AppProfile({
    Key? key,
    required this.profileImage,
    required this.name,
    required this.number,
    required this.email,
    required this.lon,
    required this.latt,
  }) : super(key: key);
  final String profileImage;
  final String number;
  final String email;
  final String lon;
  final String name;
   final String latt;

  @override
  State<AppProfile> createState() => _AppProfileState();
}

class _AppProfileState extends State<AppProfile> {
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = AppBloc.get(context).user;
        Set<Marker> _markers = {
          
              Marker(markerId: MarkerId('id-1'),
              position: LatLng(double.parse(widget.latt),double.parse(widget.lon)))
        };
        void _onMapCreated(GoogleMapController controller){
          
        }
         final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(widget.latt),double.parse(widget.lon)),
    zoom: 14.4746,
  );

        return Scaffold(
          appBar: AppBar(),
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
                child: CircleAvatar(radius:130,backgroundColor: Colors.white, child: Image(image:AssetImage('images/doc.png'),),
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
                    '${widget.profileImage}'
                  ) ,
                  ),]
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
              'Name : ${widget.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height:15
            ),
             Text(
              'Email : ${widget.email}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Phone : ${widget.number}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height: 15,
            ),SizedBox(
              height: 15,
            ),
              if(widget.latt != null) 
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

