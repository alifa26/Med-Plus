

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
import 'package:http/http.dart';
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

  class editUser extends StatefulWidget {
    const editUser({ Key? key,required this.usermodel, }) : super(key: key);

    final UserDataModel usermodel;
  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  bool st = false;
  var namecont = TextEditingController();

  var emailcont = TextEditingController();

  var numcont = TextEditingController();

  var bloodcont = TextEditingController();


  var tagcont = TextEditingController();


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
      late File? profileImage = null;
      String? profileImageUrl ;

    var profilepicker = ImagePicker();
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
    namecont.text = widget.usermodel!.username;
    emailcont.text = widget.usermodel!.email;
    numcont.text = widget.usermodel!.num;
    bloodcont.text = widget.usermodel!.blood;
    tagcont.text = widget.usermodel!.tag;
    return Scaffold(
    appBar: AppBar(
      actions: [
        TextButton(
            onPressed: () {
              UserDataModel userdatamodell = new UserDataModel(uId: widget.usermodel!.uId,
                 username: namecont.text,
                  email: emailcont.text,
                   token: widget.usermodel!.token,
                    image: widget.usermodel!.image,
                     num: numcont.text,
                      blood: bloodcont.text,
                       lon: widget.usermodel!.lon, lat: widget.usermodel!.lat, tag: tagcont.text);
                       FirebaseFirestore.instance.collection('users').doc(widget.usermodel!.uId).update(userdatamodell.toJson()).then((value) => {
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
          children: [
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
                              return 'name can/t be empty';
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
                              widget.usermodel.username,
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
                              return 'email can/t be empty';
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
                              widget.usermodel!.email,
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
                              return 'phone number can/t be empty';
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
                              widget.usermodel!.num,
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
                              return 'blood type can/t be empty';
                            }
        
                            return null;
                          },
                          controller: bloodcont ,
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
                              widget.usermodel.blood,
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
                              return 'profile type can/t be empty';
                            }
        
                            return null;
                          },
                          controller: tagcont ,
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
                              widget.usermodel.tag,
                            ),
                          ),
                        ),
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


  