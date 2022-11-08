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
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import '../../social_app/constants.dart';
import '../../social_app/cubit.dart';
import 'package:path/path.dart';

class viewPdf extends StatefulWidget {

  const viewPdf({ Key? key,required this.file,required this.texxt}) : super(key: key);

  @override
  State<viewPdf> createState() => _viewPdfState();

  final File file;
  final String texxt;
}
class _viewPdfState extends State<viewPdf> {

  Widget build(BuildContext context) {
    final name= basename(widget.file.path);
    return Scaffold(
      body: Stack(children: [
        Container(height: 700,
        width: double.infinity,
          child: PDFView(
            filePath: widget.file.path,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                       margin: EdgeInsets.only(left: 10,right: 10),
                         width: MediaQuery.of(context).size.width,
                         height: 200,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           color: Colors.white,
                           border: Border.all(color: Colors.teal,width: 7)
                         ),
                       child: Padding(
                           padding: const EdgeInsets.only(left: 20),
                           child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('Lab Notes :',
                                   style: TextStyle(color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                    Text(widget.texxt,
                                    style: TextStyle(color: Color.fromARGB(123, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,),
                                   
                                  ],
                                ),
                              )
                            ],
                           ),
                         ),
                     )
          ],
        )
      ],
      ),
    );
  }
}