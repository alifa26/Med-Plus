
import 'package:med/home%20page/global.dart';
import 'package:med/profile.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/home_screen.dart';
import 'package:med/social_app/injection.dart' as di ;
import 'package:med/social_app/injection.dart';
import 'package:med/social_app/social_login/social_login_screen.dart';
import 'package:med/social_app/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.instance.getToken().then((value) {
  String? token = value;
  print('token issssss ${value}');
});
  


  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
   Fluttertoast.showToast(msg: 'on message',);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    Fluttertoast.showToast(msg: 'on message opened app',);
  });

  await di.init();

  userConst = FirebaseAuth.instance.currentUser;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(MyApp(
    user: userConst,
  ));
}

class MyApp extends StatelessWidget {
  User? user;

  MyApp({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MED PLUS',
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              primarySwatch: Colors.teal,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle : SystemUiOverlayStyle(
                  statusBarColor:lightBlueIsh,
                  statusBarIconBrightness: Brightness.light
                )
              )
            ),
            home: user != null ?  HomeScreen() :  LoginScreen(),
          );
        },
      ),
    );
  }
}
