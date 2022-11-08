import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/edit_profile.dart';
import 'package:med/social_app/home_screen.dart';
import 'package:med/social_app/messages.dart';
import 'package:med/social_app/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:med/social_app/user_model.dart';
import '../social_app/constants.dart';

class Xscreen extends StatefulWidget {
  const Xscreen({ Key? key }) : super(key: key);

  @override
  _XscreenState createState() => _XscreenState();
}

class _XscreenState extends State<Xscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
            title: const Text(
              'Add new post',
            ),
            actions: [
               TextButton(onPressed: (){
                  if (AppBloc.get(context).postImage != null)
                     {
                       firebase_storage.FirebaseStorage.instance.ref('users/${AppBloc.get(context).postImage!.path.split('/').last}')
                       .putFile(AppBloc.get(context).postImage!).then((p0){
                         AppBloc.get(context).usersList = [];
                         AppBloc.get(context).doctorslist = [];
                         AppBloc.get(context).postsList =[];
                         AppBloc.get(context).currentIndex = 0;
                         debugPrint(p0.state.name);
                         p0.ref.getDownloadURL().then((value) {
                            UserDataModel model = UserDataModel(
                                uId: AppBloc.get(context).user!.uId,
                                image: value.toString(),
                                email: AppBloc.get(context).user!.email,
                                username: AppBloc.get(context).user!.username,
                                token: AppBloc.get(context).user!.token,
                                num: '',
                                blood: '',
                                lon:'',
                                lat: '',
                                tag:'');
                                FirebaseFirestore.instance.collection('users').doc(model.uId!).update(model.toJson()).then((value){
                                  
                                  
                                  navigateAndFinish(context, HomeScreen());
                                }).catchError((error){
                                  Fluttertoast.showToast(msg: error.toString());
                                });
                         });
                       });
                     }
                           

                                





               }, child: const Text('XME',style: TextStyle(color: Colors.white))),],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                if (AppBloc.get(context).postImage != null)
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: Image.file(
                      AppBloc.get(context).postImage!,
                      width: double.infinity,
                      height: 230.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AppBloc.get(context).pickPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                            ),
                            Text(
                              'Add photo',
                            ),
                          ],
                        ),)
                      )])]),)
  );
  }
    );
  }
}