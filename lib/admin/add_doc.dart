

  import 'dart:io';

  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:image_picker/image_picker.dart';
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

  class AddDoc extends StatefulWidget {
  @override
  State<AddDoc> createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  var didcont = TextEditingController();

  var namecont = TextEditingController();

  var emailcon = TextEditingController();

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
        'Add Doctor'
      ),
      actions: [
        TextButton(
            onPressed: () {
              UploadFile().then((value) => {
                FirebaseFirestore.instance.collection('list')
     .doc('${namecont.text}')
     .set({
      'dId': didcont.text,
      'doctorname': namecont.text,
      'email': emailcon.text,
      'specialization': specont.text,
      'image': value,
      'key': '1',
      'converted': ['2022-09-12 01:20:00.000 - 2022-09-12 02:00:00.000'],}).then((value) => navigateAndFinish(context, HomeScreen()))
              }).then((value){

     Fluttertoast.showToast(
                                  msg: 'Doctor Added',
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [InkWell(onTap: (){selectFile();},
          child: Center(
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
                if(pickedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top :15),
                  child: Stack(alignment: AlignmentDirectional.center,
                    children:[
                      
                    CircleAvatar(backgroundColor: Colors.teal,
                    radius: 160,),CircleAvatar(radius: 150,
                      backgroundImage: FileImage(File(pickedFile!.path!)) ,
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
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'doctor name can not be empty';
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
                            'Doctor Name',
                          ),
                        ),
                      ),
          ),
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'doctor number can not be empty';
                          }
    
                          return null;
                        },
                        controller: didcont ,
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
                            'Doctor Phone Number',
                          ),
                        ),
                      ),
          ),
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email can not be empty';
                          }
    
                          return null;
                        },
                        controller: emailcon ,
                        keyboardType: TextInputType.emailAddress,
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
                            'Email',
                          ),
                        ),
                      ),
          ),
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'specialization can not be empty';
                          }
    
                          return null;
                        },
                        controller: specont ,
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
                            'Specialization',
                          ),
                        ),
                      ),
          ),
          
        ],
      ),
        ],
      ),
    ),

  );
    });

  }
}


  