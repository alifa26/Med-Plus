import 'package:flutter/material.dart';
import 'package:med/admin/add_doc.dart';
import 'package:med/admin/add_lab.dart';
import 'package:med/admin/add_pharm.dart';
import 'package:med/admin/admin_chhose_user.dart';
import 'package:med/admin/edit_user.dart';
import 'package:med/admin/send_noti.dart';
import 'package:med/social_app/constants.dart';

import '../home page/global.dart';

class AdminMain extends StatelessWidget {
  const AdminMain({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Center(
        child: Container(
          child: 
          Column(
            children: [SizedBox(height: 100,)
              ,InkWell(
                onTap: (){
                  navigateTo(context, sendNoti());
                },
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: c2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Send Notification',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  navigateTo(context, AdminChooseUser());
                },
                child: 
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: c2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Edit User Profile',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  navigateTo(context, AddDoc());
                },
                child: 
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: c2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Add doctor',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  navigateTo(context, addLab());
                },
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: c2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Add Lab',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  navigateTo(context, addPharm());
                },
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: c2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Add Pharmacy',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}