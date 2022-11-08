import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:med/services/doctor/appointment_screen.dart';
import 'package:med/services/lab/rec_pdf.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import '../../social_app/state.dart';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:med/notifications/notification_screen.dart';
import 'package:med/services/ambulance/ambulance_screen.dart';
import 'package:med/services/lab/sen_pdf.dart';
import 'package:med/services/lab/view_pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ResultScreen extends StatefulWidget {
  const ResultScreen({ Key? key }) : super(key: key);

  static String? fille;

  static Future<File> _storeFile(String url,List<int> bytes) async{
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes,flush: true);
    return file;
  }
  
  static Future<File> loadFirebase(String url) async{
    final refPdf = FirebaseStorage.instance.ref().child(url);
    final bytes = await refPdf.getData();
    return _storeFile(url,bytes!);
  }
static Future<File> loadNetworkPdf(String urll) async{
  final response = await http.get(Uri.parse(urll));
  final bytes = response.bodyBytes;
  return _storeFile(urll, bytes);
}

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
      
  }
Future UploadFile () async{
    final path = 'pdf/${pickedFile!.name}';
    final file = File(pickedFile!.path as String);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link ${urlDownload}');
  }
  late String url;

  openPdf(BuildContext context,File file,String xtext){
Navigator.of(context).push(MaterialPageRoute(builder: (context) => viewPdf(file: file,texxt: xtext,)));}

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Your Lab Results',
            style:TextStyle(
              color: Colors.teal
            )),
            centerTitle: true,
          ),
          body: ListView.separated(itemBuilder:(context, index) => BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
                   return InkWell(
                     onTap: () async {
                       final fillle = await ResultScreen.loadNetworkPdf(AppBloc.get(context).ResultList[index].pdf);
                    if(fillle == null) return;
                    openPdf(context, fillle,AppBloc.get(context).ResultList[index].text);
                     },
                     child: Container(
                       margin: EdgeInsets.only(left: 10,right: 10),
                         width: MediaQuery.of(context).size.width,
                         height: MediaQuery.of(context).size.height / 4 - 25,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           color: Colors.white,
                           border: Border.all(color: Colors.teal,width: 7)
                         ),
                       child: Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: Row(
                            children: [
                              CircleAvatar(backgroundImage:NetworkImage(AppBloc.get(context).ResultList[index].image),
                              radius: 45,),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${AppBloc.get(context).ResultList[index].username} Test Results',
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Text('${AppBloc.get(context).ResultList[index].date}',
                                    style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 217, 255)
                                    ),),
                                    SizedBox(height: 5,),
                                   /* Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(onPressed: (){}, child: Text('view profile'))
                                      ],
                                    )
                              */
                                  ],
                                ),
                              )
                            ],
                           ),
                         ),
                     ),
                   );
            },
          ),
           separatorBuilder: (context, index) => space5Vertical(context),
            itemCount: AppBloc.get(context).ResultList.length,)
        );
      },
    );
  }}