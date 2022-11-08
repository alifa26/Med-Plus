import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/home_screen.dart';
import '../user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  ///TextEditingController tagController = TextEditingController();
  Position? _position;
  late double lat;
  late double lon;
  final formKey = GlobalKey<FormState>();

  bool isVisible = true;
  bool isClicked = false;
  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/icon.png',
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Text(
                    'Register now and discover app',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'username must not be empty';
                      }

                      return null;
                    },
                    controller: usernameController,
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
                      label: const Text(
                        'username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email address must not be empty';
                      }

                      return null;
                    },
                    controller: emailController,
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
                      label: const Text(
                        'email address',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password is too short';
                      }

                      return null;
                    },
                    controller: passwordController,
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
                      label: const Text(
                        'password',
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: isVisible,
                    keyboardType: TextInputType.visiblePassword,
                  ),const SizedBox(
                    height: 20.0,
                  ),TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      }

                      return null;
                    },
                    controller: numController,
                    keyboardType: TextInputType.phone,
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
                      label: const Text(
                        'phone number',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'blood type must not be empty';
                      }

                      return null;
                    },
                    controller: bloodController,
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
                      label: const Text(
                        'blood type',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: lightBlueIsh,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () async{
                               Position position = await _determinePosition();
                               setState(() {
                                _position = position;
                                lat = _position!.latitude;
                                lon = _position!.longitude;
                               });
                      },
                      child: Text('get current location',
                      style: TextStyle(
                                color: Colors.white,
                              ),),
                    ),),const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: lightBlueIsh,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: MaterialButton(
                      height: 42.0,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isClicked = true;
                          });

                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((userData) {
                            // Fluttertoast.showToast(
                            //   msg: userData.user!.uid,
                            // );

                            FirebaseMessaging.instance.getToken().then((value) {
                              UserDataModel model = UserDataModel(
                                uId: userData.user!.uid,
                                image: 'https://firebasestorage.googleapis.com/v0/b/med-plus-c19c7.appspot.com/o/CC_Express_20220627_2249130.9278785658437338.png?alt=media&token=1bc1c0e8-cb46-4811-b4ed-808f9b0b8030',
                                email: emailController.text,
                                username: usernameController.text,
                                token: value!,
                                num: numController.text,
                                blood: bloodController.text,
                                lon: lon == null ? '' : lon.toString(),
                                lat: lat == null ? '' : lat.toString(),
                                tag: 'user',
                              );

                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userData.user!.uid)
                                  .set(model.toJson())
                                  .then((value) {
                                setState(() {
                                  isClicked = false;
                                });

                                userConst = userData.user;

                                navigateAndFinish(
                                  context,
                                  HomeScreen(),
                                );
                              }).catchError((error) {
                                Fluttertoast.showToast(
                                  msg: error.toString(),
                                );
                              });
                            });
                          }).catchError((error) {
                            setState(() {
                              isClicked = false;
                            });

                            Fluttertoast.showToast(
                              msg: error.toString().split(']').last,
                            );
                          });
                        }
                      },
                      child: isClicked
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
