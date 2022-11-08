import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class Upscreen extends StatefulWidget {
  const Upscreen({ Key? key }) : super(key: key);

  @override
  _pscreenState createState() => _pscreenState();
}

class _pscreenState extends State<Upscreen> {

Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  stream: uploadTask?.snapshotEvents,
  builder: (context, snapshot) {
  if(snapshot.hasData){
final data = snapshot.data!;
double progress = data.bytesTransferred / data.totalBytes;
return SizedBox(height: 50,
child: Stack(
  fit: StackFit.expand,
  children: [
    LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey,
      color: Colors.green,
    ),
    Center(
      child: Text('${100 * progress.roundToDouble()}%',
      style: const TextStyle(
        color: Colors.white
      ),),
    )
  ],
),);
  }
  else{
    return const SizedBox(height: 50,);
  }
});

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
    final path = 'pdf/${pickedFile!.name}';
    final file = File(pickedFile!.path as String);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link ${urlDownload}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            if (pickedFile != null)
            Expanded(child: Center(
              child: Text(pickedFile!.name),
            )),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: selectFile,
             child: Text('select')),
             SizedBox(height: 20,),
             ElevatedButton(onPressed: UploadFile,
              child:Text('upload')),
              SizedBox(height: 20,),
              buildProgress()
              

          ],
        ),
      ),
    );



  }
}