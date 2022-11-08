import 'package:med/admin/admin_main.dart';
import 'package:med/explore/extra_main.dart';
import 'package:med/explore/pharmacy/pharmacy_main.dart';
import 'package:med/explore/pharmacy/send_perc.dart';
import 'package:med/home%20page/global.dart';
import 'package:med/list%20test/list_screen.dart';
import 'package:med/maps/map_screen.dart';
import 'package:med/pdf/up_screen.dart';
import 'package:med/profile.dart';
import 'package:med/services/ambulance/ambulance_screen.dart';
import 'package:med/services/blood/blood_req_screen.dart';
import 'package:med/services/doctor/doctor_screen.dart';
import 'package:med/services/lab/choose_user.dart';
import 'package:med/services/lab/rec_pdf.dart';
import 'package:med/services/lab/sen_pdf.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/edit_profile.dart';
import 'package:med/social_app/message_users.dart';
import 'package:med/social_app/messages.dart';
import 'package:med/social_app/posts.dart';
import 'package:med/social_app/search.dart';
import 'package:med/social_app/social_login/social_login_screen.dart';
import 'package:med/social_app/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/social_app/user_model.dart';
import 'package:med/x/x_screen.dart';
import '../home page/home_page.dart';
import '../list test/list_don.dart';
import '../maps/noti_map.dart';
import '../notifications/notification_screen.dart';
import '../services/doctor2/appoint_made.dart';
import '../services/doctor2/dappoints.dart';
import '../services/doctor2/doctors_screen.dart';
import '../services/doctor2/uappoints.dart';
import 'cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<DrawerItem> drawerItems = [
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Home',
      icon: Icons.home,
    ),
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Extra',
      icon: Icons.add_circle_outline,
    ),
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Chat',
      icon: Icons.chat,
    ),
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Profile',
      icon: FontAwesomeIcons.userAlt,
    ),
   
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Logout',
      icon: FontAwesomeIcons.signOutAlt,
    ),
  ];

  @override
  void initState() {
    super.initState();

    AppBloc.get(context).getUserData(userConst!.uid);
    AppBloc.get(context).getPosts();
    if(AppBloc.get(context).usersList.length == 0){
     AppBloc.get(context).getUsers(); 
    }
    
    //AppBloc.get(context).getx();
   AppBloc.get(context).getDoctors();
  AppBloc.get(context).getNotifc();
  if(AppBloc.get(context).doclist.length == 0){
    AppBloc.get(context).getDocts();
  }
    
    if(AppBloc.get(context).LabList == 0){
      AppBloc.get(context).getLabs();
    }
    if(AppBloc.get(context).PharList.length == 0){
      AppBloc.get(context).getPhar();
    }
    
   /// AppBloc.get(context).getPerc();
    UserDataModel? userr = AppBloc.get(context).user;
  }
  
  List<Widget> widgets = [
    homePage(),
    extraMain(),
    MessageChooseUser(),
    Profile()
     
    
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: widgets[AppBloc.get(context).currentIndex],
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    color: lightGreen,
                    height: 120.0,
                    child: const Center(
                      child: Text(
                        'MED PLUS',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                      selected: index <= 3 &&
                          index == AppBloc.get(context).currentIndex,
                      leading: Icon(
                        drawerItems[index].icon,
                      ),
                      onTap: () {
                        if (index <= 3) {
                          AppBloc.get(context).bottomChanged(index);

                          Navigator.pop(context);
                        } else if (index == drawerItems.length - 1) {
                          FirebaseAuth.instance.signOut().then((value) {
                            navigateAndFinish(context, const LoginScreen(),);
                          });
                        }
                      },
                      title: Text(
                        drawerItems[index].title,
                        style: TextStyle(
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const MyDivider(),
                    itemCount: drawerItems.length,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(backgroundColor: backgroundColor,
          elevation: 0,
          fixedColor: lightGreen,
          unselectedItemColor: lightBlueIsh,
            currentIndex: AppBloc.get(context).currentIndex,
            onTap: (index) {
              AppBloc.get(context).bottomChanged(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.maps_home_work_rounded,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.add_circle_outline
                  ),
                ),
                label: 'Extra',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.message,
                  ),
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    FontAwesomeIcons.userCircle
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerItem {
  final String title;
  final Widget navigate;
  final IconData icon;

  DrawerItem({
    required this.title,
    required this.navigate,
    required this.icon,
  });
}
