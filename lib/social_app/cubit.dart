import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med/explore/pharmacy/pharmacyModel.dart';
import 'package:med/services/doctor/doctor_model.dart';
import 'package:med/services/doctor2/appmodel.dart';
import 'package:med/services/lab/lab_model.dart';
import 'package:med/services/lab/pcrModel.dart';
import 'package:med/services/lab/result_model.dart';
import 'package:med/social_app/chat_model.dart';
import 'package:med/social_app/message_model.dart';
import 'package:med/social_app/post_model.dart';
import 'package:med/social_app/state.dart';
import 'package:med/social_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:med/x/x_model.dart';

import '../explore/pharmacy/PercModel.dart';
import '../list test/list_model.dart';
import '../notifications/notification_model.dart';
import '../services/doctor2/doctors_model.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(Empty());

  static AppBloc get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void bottomChanged(int index) {
    currentIndex = index;

    emit(BottomChanged());
  }

  File? postImage;

  var picker = ImagePicker();

  void pickPostImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(PostImagePickedSuccess());
    } else {
      debugPrint('No image selected.');
      emit(PostImagePickedError());
    }
  }

File? profileImage;

  var profilepicker = ImagePicker();

  void pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      debugPrint(pickedFile.path);
      emit(ProfileImagePickedSuccess());
    } else {
      debugPrint('No image selected.');
      emit(ProfileImagePickedError());
    }
  }

String profileImageUrl = '';
///List<DateTimeRange> converted = [];
List<List<DateTimeRange>> converted1 = [[],[],[],[],[],[]];
void uploadProfileImage(){
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child(
    'users/${Uri
    .file(profileImage!.path)
    .pathSegments
    .last}'
    ).putFile(profileImage!)
    .then((value) {
      value.ref.getDownloadURL().then((value){
        emit(ProfileImageUploadSuccess());
        profileImageUrl = value;
      }).catchError((error){
        emit(ProfileImageUploadError());
      });
    })
    .catchError((error){
      emit(ProfileImageUploadError());
    });
}


/*void getUser(){
FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userData.user!.uid)
                                  .set(model.toJson())
                                  .then((value) {});
}

void updateuser({
  required String username,
  required String email,
}){

 UserDataModel model = UserDataModel(
                                uId: AppBloc.get(context).user!.uid,
                                image: AppBloc.get(context).user,
                                email: emailController.text,
                                username: usernameController.text,
                                token: value!,
                              );

FirebaseFirestore.instance.collection('users').doc(model!.uId).update(model.toJson()).then((value) {
  getUserData();
}).catchError((error){});
}
*/

void getUser ({required String uId
}){
  emit(GetUserLodingErrorState());
FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){
  emit(GetUserLodingSuccState());
}).catchError((error){
  emit(GetUserLodingErrorState());
});
}

  void deletePostImage() async {
    postImage = null;
    emit(PostImagePickedError());
  }

  UserDataModel? user;

  void getUserData(String id) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      user = UserDataModel.fromJson(value.data()!);
      emit(GetUserSuccess());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(GetUserError(
        message: error.toString(),
      ));
    });
  }

  List<Map<String, PostDataModel>> postsList = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
      postsList = [];

      for (var element in value.docs) {
        postsList.add(
            {element.reference.id: PostDataModel.fromJson(element.data())});
      }

      debugPrint(postsList.length.toString());

      emit(GetPostsSuccess());
    });
  }
  

  List<UserDataModel> usersList = [];

 /* void getUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      usersList = [];

      for (var element in value.docs) {
        if (UserDataModel.fromJson(element.data()).uId != user!.uId) {
          usersList.add(UserDataModel.fromJson(element.data()));
        }
      }

      debugPrint(usersList.length.toString());

      emit(GetUsersSuccess());
    });
  }*/

  void updatePostLikes(Map<String, PostDataModel> post) {
    if (post.values.single.likes.any((element) => element == user!.uId)) {
      debugPrint('exist and remove');

      post.values.single.likes.removeWhere((element) => element == user!.uId);
    } else {
      debugPrint('not exist and add');

      post.values.single.likes.add(user!.uId);
    }

    FirebaseFirestore.instance
        .collection('posts')
        .doc(post.keys.single)
        .update(post.values.single.toJson())
        .then((value) {
      emit(PostUpdatedSuccess());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(PostUpdatedError(
        message: error.toString(),
      ));
    });
  }

  void updatePostShares(Map<String, PostDataModel> post) {
    post.values.single.shares++;

    FirebaseFirestore.instance
        .collection('posts')
        .doc(post.keys.single)
        .update(post.values.single.toJson())
        .then((value) {
      emit(PostUpdatedSuccess());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(PostUpdatedError(
        message: error.toString(),
      ));
    });
  }

  TextEditingController messageController = TextEditingController();
   var namecont = TextEditingController();
  var emailcon = TextEditingController();

  void sendMessage(UserDataModel userDataModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .get()
        .then((value) {
      MessageDataModel model = MessageDataModel(
        time: DateTime.now().toString(),
        message: messageController.text,
        receiverId: userDataModel.uId,
        senderId: user!.uId,
      );

      if (value.docs
          .any((element) => element.reference.id != userDataModel.uId)) {
        ChatDataModel chatDataModel = ChatDataModel(
          username: userDataModel.username,
          userId: userDataModel.uId,
          userImage: userDataModel.image,
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('chats')
            .doc(userDataModel.uId)
            .set(chatDataModel.toJson())
            .then((value) {})
            .catchError((error) {
          debugPrint(error.toString());

          emit(CreateChatError(
            message: error.toString(),
          ));
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(userDataModel.uId)
            .collection('chats')
            .doc(user!.uId)
            .set(chatDataModel.toJson())
            .then((value) {})
            .catchError((error) {
          debugPrint(error.toString());

          emit(CreateChatError(
            message: error.toString(),
          ));
        });
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('chats')
            .doc(userDataModel.uId)
            .collection('messages')
            .add(model.toJson())
            .then((value) {
          messageController.clear();
        }).catchError((error) {
          debugPrint(error.toString());

          emit(CreateChatError(
            message: error.toString(),
          ));
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(userDataModel.uId)
            .collection('chats')
            .doc(user!.uId)
            .collection('messages')
            .add(model.toJson())
            .then((value) {
          messageController.clear();
        }).catchError((error) {
          debugPrint(error.toString());

          emit(CreateChatError(
            message: error.toString(),
          ));
        });
      }
    }).catchError((error) {
      debugPrint(error.toString());

      emit(SendMessage(
        message: error.toString(),
      ));
    });
  }

  List<MessageDataModel> messagesList = [];

  void getMessages(UserDataModel userDataModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(userDataModel.uId)
        .collection('messages').orderBy('time', descending: false,)
        .snapshots()
        .listen((value) {
      messagesList = [];

      for (var element in value.docs) {
        messagesList.add(MessageDataModel.fromJson(element.data()));
      }

      debugPrint(messagesList.length.toString());

      emit(GetMessagesSuccess());
    });
  }

List<UserDataModel> users = []; 
void getUsers(){
  FirebaseFirestore.instance.collection('users').get().then((value) {
    value.docs.forEach((element){
      usersList.add(UserDataModel.fromJson(element.data()));
    });
    emit(GetAllUsersLodingSuccState());
    }).catchError((error){
      emit(GetAllUsersLodingErrorState());
    });
}

List<DoctorDataModel> doctorslist = [];

void getDoctors(){
  FirebaseFirestore.instance.collection('doctors').get().then((value) {
    value.docs.forEach((element){
      doctorslist.add(DoctorDataModel.fromJson(element.data()));
    });
    emit(GetDoctorsLodingSuccState());
    }).catchError((error){
      emit(GetDoctorsLodingErrorState());
    });
}
List<NotficModel> notiList = [];
List<NotficModel> notifcList = [];
void getNotifc(){
  FirebaseFirestore.instance.collection('Notification').get().then((value) {
    value.docs.forEach((element){
      notifcList.add(NotficModel.fromJson(element.data()));
    });
    emit(GetNotiLodingSuccState());
    }).catchError((error){
      emit(GetNotiLodingErrorState());
    });
}
void changeloc(){
  emit(LocationChangedState());
}

List<AppModel> AppointsList = [];

void getAppoints(){
  FirebaseFirestore.instance.collection('Appoints ${user!.username}').get().then((value) {
    value.docs.forEach((element){
      AppointsList.add(AppModel.fromJson(element.data()));
    });
    emit(GetAppointLodingSuccState());
    }).catchError((error){
      emit(GetAppointLodingErrorState());
    });
}

List<ResultModel> ResultList = [];

void getResults(){
  FirebaseFirestore.instance.collection('${user!.username} result').get().then((value) {
    value.docs.forEach((element){
      ResultList.add(ResultModel.fromJson(element.data()));
    });
    emit(GetResultLodingSuccState());
    }).catchError((error){
      emit(GetResultLodingErrorState());
    });
}

List<PcrModel> PcrList = [];

void getPCR(){
  FirebaseFirestore.instance.collection('${user!.username} PCR').get().then((value) {
    value.docs.forEach((element){
      PcrList.add(PcrModel.fromJson(element.data()));
    });
    emit(GetPCRLodingSuccState());
    }).catchError((error){
      emit(GetPCRLodingErrorState());
    });
}

List<labModel> LabList = [];

void getLabs(){
  FirebaseFirestore.instance.collection('labs').get().then((value) {
    value.docs.forEach((element){
      LabList.add(labModel.fromJson(element.data()));
    });
    emit(GetLabLodingSuccState());
    }).catchError((error){
      emit(GetLabLodingErrorState());
    });
}

List<PharmacyModel> PharList = [];

void getPhar(){
  FirebaseFirestore.instance.collection('Pharmacies').get().then((value) {
    value.docs.forEach((element){
      PharList.add(PharmacyModel.fromJson(element.data()));
    });
    emit(GetPharLodingSuccState());
    }).catchError((error){
      emit(GetPharLodingErrorState());
    });
}


List<percModel> PercList = [];

void getPerc(){
  FirebaseFirestore.instance.collection('${user!.username} pharmacy').get().then((value) {
    value.docs.forEach((element){
      PercList.add(percModel.fromJson(element.data()));
    });
    emit(GetPercLodingSuccState());
    }).catchError((error){
      emit(GetPercLodingErrorState());
    });
}


/*
List<ListModel> lm = [];
void getList(){
  FirebaseFirestore.instance.collection('list').get().then((value) {
    value.docs.forEach((element){
      lm.add(ListModel.fromJson(element.data()));
    });
    emit(GetListLodingSuccState());
    }).catchError((error){
      emit(GetListLodingErrorState());
    });
}
*/
/*
List<xDataModel> xlist = [];

void getx(){
  FirebaseFirestore.instance.collection('x').get().then((value) {
    value.docs.forEach((element){
      xlist.add(xDataModel.fromJson(element.data()));
    });
    emit(GetXLodingSuccState());
    }).catchError((error){
      emit(GetXLodingErrorState());
    });
}

}*/

List<Map<String, DoctorsDataModel>> doclist = [];

void getDocts(){
    FirebaseFirestore.instance.collection('list').snapshots().listen((value) {
      doclist = [];

      for (var element in value.docs) {
        doclist.add(
            {element.reference.id: DoctorsDataModel.fromJson(element.data())});
      }

      debugPrint(doclist.length.toString());

      emit(GetDoctorsLodingSuccState2());
    });
  }
}