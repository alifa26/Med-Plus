

  import 'dart:io';

  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
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

  class pcr extends StatefulWidget {
    const pcr ({Key? key,
    required this.labName}) : super(key: key);
    final String labName;
  @override
  State<pcr> createState() => _pcrState();
}

class _pcrState extends State<pcr> {
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
  DateTime now = DateTime.now();
  late DateTime date;

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
        'Upload Your Information'
      ),
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
                width: double.infinity,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left:13.0),
                  child: CircleAvatar(radius:130,backgroundColor: Colors.white, child: Text('upload a photo of your passport first page'),
                    ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal,
                             width: 10),
                  color: Colors.white,
                  
                )),
                ////Image.file(File(pickedFile!.path!)
                if(pickedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top :15),
                  child: Stack(alignment: AlignmentDirectional.center,
                    children:[
                      
                    /*CircleAvatar(backgroundColor: Colors.teal,
                    radius: 160,),CircleAvatar(radius: 150,
                      backgroundImage: FileImage(File(pickedFile!.path!)) ,
                    ),*/
                    Container(margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 300,
                child: Image(image: FileImage(File(pickedFile!.path!),),
                fit: BoxFit.fill,),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal,
                             width: 10),
                  color: Colors.white,
                  
                  
                )),]
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
                            return 'passport number can not be empty';
                          }
    
                          return null;
                        },
                        controller: namecont ,
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
                            'Passport Number',
                          ),
                        ),
                      ),
          ),
          InkWell(onTap: () async{
            DateTime? newdate = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(2011), lastDate: DateTime(2050));
            if(newdate == null) return;
            date = newdate;
            print('${date}');
          },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(decoration: BoxDecoration(
                           color: Colors.teal
                           ,borderRadius: BorderRadius.circular(30),
                            ),
                  height: 75,
                  width: 200,
                  child: Center(child: Text('Flight Date',
                  style: TextStyle(
                    color: Colors.white
                  ),)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              UploadFile().then((value) => {
                FirebaseFirestore.instance.collection('${widget.labName} PCR')
     .doc('${AppBloc.get(context).user!.username}')
     .set({
       'uId': AppBloc.get(context).user!.uId,
      'username': AppBloc.get(context).user!.username,
      'text': AppBloc.get(context).user!.image,
      'passport': namecont.text,
      'image': value,
      'date':date.toString().split(' ')[0],
       'number' : AppBloc.get(context).user!.num,
       'email' : AppBloc.get(context).user!.email
     }).then((value) => Navigator.pop(context))
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(decoration: BoxDecoration(
                           color: lightGreen
                           ,borderRadius: BorderRadius.circular(30),
                            ),
                  height: 75,
                  width: 200,
                  child: Center(child: Text('Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                          ),
                height: 75,
                width: double.infinity,
                child: Center(child: Expanded(
                  child: Text('send your information and the lab will call you with your PCR appointment',
                  style: TextStyle(
                    color: Colors.grey,
                  ),),
                )),
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


  