import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:med/notifications/notification_screen.dart';
import 'package:med/services/ambulance/ambulance_screen.dart';
import 'package:med/social_app/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
class sendPdf extends StatefulWidget {
  const sendPdf({ Key? key, required this.userDataModel}) : super(key: key);
  final UserDataModel userDataModel;


  @override
  _senPdfState createState() => _senPdfState();
}


class _senPdfState extends State<sendPdf> {
  TextEditingController xcont = TextEditingController();
 PlatformFile? pickedFile;
 File? pickeddFile;
  UploadTask? uploadTask;
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf']
    );
    if (result == null) return null;
    setState(() {
      pickeddFile = File(result.paths!.first!);
      pickedFile = result.files.first;
    });
      
      
  }Future UploadFile () async{
    final path = 'pdf/${pickedFile!.name}';
    final file = File(pickedFile!.path as String);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link ${urlDownload}');
    return urlDownload;
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 500,
                    width: double.infinity,
                    color:Colors.white,
                    child: Center(child: Text('no file selected')),
                  ),
                  if(pickedFile != null)
                  Container(
                      height: 500,
                      width: double.infinity,
                      child: PDFView(
                          filePath: pickedFile?.path,
                          fitPolicy: FitPolicy.BOTH,
                          autoSpacing: false,
                        )
                    ),
                  
                ],
              ),InkWell(
                onTap: (){selectFile();},
                child: Container(decoration: BoxDecoration(
                         borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                         color: Colors.teal
                       ),
                  height: 50,
                  width: 300,
                  child: Center(child: Text('Upload Result',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),)),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                        controller: xcont ,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'send your instructions if you have any',
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20
                          ),
                          hintStyle: TextStyle(
                          ),
                          
                        ),
                      ),
                      InkWell(
                onTap: (){
                  DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('kk:mm EEE d MMM').format(now);
                  UploadFile().then((value) => 
                  FirebaseFirestore.instance.collection('${widget.userDataModel.username} result').doc(AppBloc.get(context).user!.username).set({
                    'uId': '1',
      'username': AppBloc.get(context).user!.username,
      'text': xcont.text,
      'pdf': value,
      'image': AppBloc.get(context).user!.image,
      'date':formattedDate.toString(),
       'number' : AppBloc.get(context).user!.num
                  }).then((value){
                    Navigator.pop(context);
                  })
                  );

                },
                child: Container(decoration: BoxDecoration(
                         borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50),topLeft: Radius.circular(50),topRight:Radius.circular(50) ),
                         color: Colors.teal
                       ),
                  height: 50,
                  width: 300,
                  child: Center(child: Text('Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),)),
                ),
              ),
                    
            ],
          ),
        ),
      ),
    );
  }
}