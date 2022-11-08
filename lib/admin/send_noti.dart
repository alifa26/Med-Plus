

  import 'dart:io';

  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/profile.dart';
import 'package:med/services/doctor2/doctors_main_screen.dart';
import 'package:med/services/doctor2/doctors_model.dart';
  import 'package:med/social_app/constants.dart';
  import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/home_screen.dart';
  import 'package:med/social_app/state.dart';
import 'package:med/social_app/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:med/social_app/state.dart';
import 'package:med/x/x_screen.dart';

import '../../social_app/edit_profile.dart';

  class sendNoti extends StatefulWidget {
  @override
  State<sendNoti> createState() => _sendNotiState();
}

class _sendNotiState extends State<sendNoti> {
  var numcont = TextEditingController();

  var namecont = TextEditingController();

  var typecont = TextEditingController();

  var latcont = TextEditingController();

  var loncont = TextEditingController();
  var textcont = TextEditingController();

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
/////////////////2022-09-12 01:20:00.000 - 2022-09-12 02:00:00.000
    return Scaffold(
    appBar: AppBar(
      title: Text(
        'Send Notification'
      ),
      actions: [
        TextButton(
            onPressed: () {
                            DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('kk:mm EEE d MMM').format(now);
              FirebaseFirestore.instance.collection('Notification')
     .doc('${namecont.text}')
     .set({
       'uId': '',
      'username': namecont.text,
      'text': textcont.text,
      'type': typecont.text,
      'image': '',
      'date':formattedDate.toString(),
       'lat' :latcont.text,
       'lon' : loncont.text,
       'number' : numcont.text
     }).then((value){
     Fluttertoast.showToast(
                                  msg: 'Notification Sent',
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
      child: Column(
        children: [
          
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'User name can/t be empty';
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
                            'User name',
                          ),
                        ),
                      ),
          ),
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lab number can/t be empty';
                          }
    
                          return null;
                        },
                        controller: numcont ,
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
                            'Usr Phone Number',
                          ),
                        ),
                      ),
          ),
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'requst type can/t be empty';
                          }
    
                          return null;
                        },
                        controller: typecont ,
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
                            'Type',
                          ),
                        ),
                      ),
          ),
          Row(
            children: [
              
           Container(
             width: 200,
             child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'latitude can/t be empty';
                            }
               
                            return null;
                          },
                          controller: latcont ,
                          keyboardType: TextInputType.number,
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
                              'Latitude',
                            ),
                          ),
                        ),
                     ),
           ),
           Container(
             width:200,
             child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'longitude can/t be empty';
                            }
               
                            return null;
                          },
                          controller: loncont ,
                          keyboardType: TextInputType.number,
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
                              'longitude',
                            ),
                          ),
                        ),
                     ),
           ),
            ],
          ),
          
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Request Text can/t be empty';
                          }
    
                          return null;
                        },
                        controller: textcont ,
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
                            'Request Text',
                          ),
                        ),
                      ),
          ),
        ],
      ),
        
      ),
    

  );
    });

  }
}


  