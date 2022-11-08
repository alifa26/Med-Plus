import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/state.dart';


class resultScreen extends StatefulWidget {
  const resultScreen({
    Key? key,
    required this.Image,
    required this.name,
    required this.number,
    required this.email,
    required this.lon,
    required this.lat,
  }) : super(key: key);
  final String Image;
  final String number;
  final String email;
  final String name;
  final String lon;
  final String lat;

  @override
  State<resultScreen> createState() => _resultScreenState();
}

class _resultScreenState extends State<resultScreen> {
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = AppBloc.get(context).user;
       
         

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
            children:[
              ////Image.file(File(pickedFile!.path!)
             /// if(pickedFile != null)
              Padding(
                padding: const EdgeInsets.only(top :13),
                child: Container(margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 300,
                child: Image(image: NetworkImage(widget.Image),),
                decoration: BoxDecoration(
                  color: Colors.white,
              ),),),
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
                fontSize: 15,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height:15
            ),
             Text(
              'Email : ${widget.email}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Phone : ${widget.number}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            
              )
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
                ],
              ),
          ),
        );
      },
    );
  }
}

