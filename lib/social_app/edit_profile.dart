

  import 'dart:ffi';
import 'dart:io';

  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:image_picker/image_picker.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/profile.dart';
  import 'package:med/social_app/constants.dart';
  import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/home_screen.dart';
  import 'package:med/social_app/state.dart';
import 'package:med/social_app/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:med/social_app/state.dart';
import 'package:med/x/x_screen.dart';

import '../../social_app/edit_profile.dart';

  class editProfile extends StatefulWidget {
  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  bool st = false;
  var namecont = TextEditingController();

  var emailcont = TextEditingController();

  var numcont = TextEditingController();

  var specont = TextEditingController();

   PlatformFile? pickedFile;

  UploadTask? uploadTask;

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
      setState(() {
      pickedFile = result.files.first;
    });
   
  }

  Future UploadFile () async{
    final path = 'docimage/${pickedFile!.name}';
    final file = File(pickedFile!.path as String);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link ${urlDownload}');
    return urlDownload;
  }

  Widget build(BuildContext context) {
  return BlocConsumer<AppBloc,AppState>(
    listener: (context, state) {},
    builder: (context, state) {
      var usermodel = AppBloc.get(context).user;
    double lat = double.parse(usermodel!.lat);
    double lon = double.parse(usermodel!.lon);
      late File? profileImage = null;
      String? profileImageUrl ;
      Position? _position;
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

    var profilepicker = ImagePicker();
    Set<Marker> _markers = {
          
              Marker(markerId: MarkerId('id-1'),
              position: LatLng(lat,lon))
        };
        void _onMapCreated(GoogleMapController controller){
        }
         final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat,lon),
    zoom: 14.4746,
  );
    void pickProfileImage() async {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        debugPrint(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    }
    namecont.text = usermodel!.username;
    emailcont.text = usermodel!.email;
    numcont.text = usermodel!.num;
    return Scaffold(
    appBar: AppBar(
      actions: [
        TextButton(
            onPressed: () {if(pickedFile == null){
                  
              UserDataModel userdatamodell = new UserDataModel(uId: usermodel!.uId,
                 username: namecont.text,
                  email: emailcont.text,
                   token: usermodel!.token,
                    image: usermodel!.image,
                     num: numcont.text,
                      blood: usermodel.blood,
                       lon:lon.toString(), lat: lat.toString(), tag: usermodel.tag);
                       FirebaseFirestore.instance.collection('users').doc(usermodel!.uId).update(userdatamodell.toJson()).then((value) => {
                         AppBloc.get(context).usersList = []
                       }).then((value){
                         AppBloc.get(context).getUsers();
                       }).then((value){
     Fluttertoast.showToast(
                                  msg: 'User Profile Edited',
                                  backgroundColor: lightGreen
                                ).then((value){
     Navigator.pop(context);
                                });
     });
            
                }
             
                
              else{ UploadFile().then((value){
                 UserDataModel userdatamodell = new UserDataModel(uId: usermodel!.uId,
                 username: namecont.text,
                  email: emailcont.text,
                   token: usermodel!.token,
                    image: value,
                     num: numcont.text,
                      blood: usermodel.blood,
                       lon:lon.toString(), lat: lat.toString(), tag: usermodel.tag);
                       FirebaseFirestore.instance.collection('users').doc(usermodel!.uId).update(userdatamodell.toJson()).then((value) => {
                         AppBloc.get(context).usersList = []
                       }).then((value){
                         AppBloc.get(context).getUsers();
                       }).then((value){
     Fluttertoast.showToast(
                                  msg: 'User Profile Edited',
                                  backgroundColor: lightGreen
                                ).then((value){
     Navigator.pop(context);
                                }).then((value){
                                  AppBloc.get(context).getUserData(usermodel!.uId);
                                });
     });
            });
              }
              
              
            },
              child:  Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                  ),
                SizedBox(
                  width: 15,
                ),
      ],
    ),
    body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [InkWell(onTap: (){selectFile();},
            child: Center(
              child: Stack(alignment: AlignmentDirectional.bottomCenter,
                children:[Container(margin: EdgeInsets.only(top: 5),
                  width: 300,
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(top:13.0),
                    child: CircleAvatar(radius:150,backgroundColor: Colors.white, 
                    backgroundImage: NetworkImage(usermodel!.image),
                      ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal,
                               width: 10),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    
                  )),
                  ////Image.file(File(pickedFile!.path!)
                  if(pickedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                bottom: 15,
                right: 15,
                left: 15,
              ),
                    child: Stack(alignment: AlignmentDirectional.bottomCenter,
                      children:[
                        
                      CircleAvatar(backgroundColor: Colors.teal,
                      radius: 140,),Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: CircleAvatar(radius: 150,
                          backgroundImage: FileImage(File(pickedFile!.path!)) ,
                        ),
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
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 20,
                        child: Icon(FontAwesomeIcons.camera,color: Colors.white,),
                      )
                    ],
                  )] 
              ),
            ),
          ),
            SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
                right: 15,
                left: 15,
                top: 10
              ),
              child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name can not be empty';
                            }
        
                            return null;
                          },
                          controller: namecont ,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            label:  Text(
                              usermodel.username,
                            ),
                          ),
                        ),
            ),
             Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
                right: 15,
                left: 15,
                top: 10
              ),
              child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email can not be empty';
                            }
        
                            return null;
                          },
                          controller: emailcont ,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            label:  Text(
                              usermodel!.email,
                            ),
                          ),
                        ),
            ),
             Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
                right: 15,
                left: 15,
                top: 10
              ),
              child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone number can not be empty';
                            }
        
                            return null;
                          },
                          controller: numcont ,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            label:  Text(
                              usermodel!.num,
                            ),
                          ),
                        ),
                        
            ),
            SizedBox(height: 10,),
            Stack(alignment:Alignment.bottomCenter,
              children: [
                Container(
                width: double.infinity,
                height: 150,
                child:
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  markers: _markers,
                  scrollGesturesEnabled: true,
                  zoomControlsEnabled: false,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(onPressed: ()async{
                                   Position position = await _determinePosition();
                                   setState(() {
                                    _position = position;
                                    lat = _position!.latitude;
                                    lon = _position!.longitude;
                                   //// AppBloc.get(context).changeloc();
                                    
                                   });
                          },
                child: Text('Update Location',
                style: TextStyle(
                  color: Colors.white
                ),),
                color: lightBlueIsh,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0)),)
              )
              ],
            ),
            
          ],
        ),
          ],
        ),
      ),
    ),

  );
    });

  }
}


  