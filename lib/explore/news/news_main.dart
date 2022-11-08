import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med/explore/news/webScreen.dart';

import '../../social_app/constants.dart';


class newsMain extends StatefulWidget {
  const newsMain({ Key? key }) : super(key: key);

  @override
  _newsMainState createState() => _newsMainState();
}

class _newsMainState extends State<newsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(onTap: (){
              navigateTo(context, WebScreen(url: 'https://www.medscape.com/viewarticle/979240?src='
              ));
            },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image: NetworkImage('https://img.medscapestatic.com/thumbnail_library/nih_190125_breast_cancer_her2_800x450.jpg?interpolation=lanczos-none&resize=360:*'),
                        fit: BoxFit.cover
                      )
                  
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Does PREDICT Accurately Estimate Breast Cancer Survival?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              
                          
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,),
                          ),
                          Text('6 hours ago',
                          style:TextStyle(
                            color: Colors.grey,
                  
                          ))
                           
                        ],
                      ),
                    ),
                  ),
                ],
                  ),
              ),
            ),
            Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    ),
    InkWell(onTap: (){
              navigateTo(context, WebScreen(url: 'https://www.medscape.com/viewarticle/979242?src='
              ));
            },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image: NetworkImage('https://img.medscapestatic.com/thumbnail_library/dt_220815_pills_child_sick_800x450.jpg?interpolation=lanczos-none&resize=360:*'),
                        fit: BoxFit.cover
                      )
                  
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Diagnosing Kids With Long COVID Can Be Tricky: Experts',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              
                          
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,),
                          ),
                          Text('7 hours ago',
                          style:TextStyle(
                            color: Colors.grey,
                  
                          ))
                           
                        ],
                      ),
                    ),
                  ),
                ],
                  ),
              ),
            ),
            Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    ),
    
    InkWell(onTap: (){
              navigateTo(context, WebScreen(url: 'https://www.medscape.com/viewarticle/979227?src='
              ));
            },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image: NetworkImage('https://img.medscapestatic.com/thumbnail_library/gty_220815_premature_baby_doctor_care_800x450.jpg?interpolation=lanczos-none&resize=360:*'),
                        fit: BoxFit.cover
                      )
                  
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Prematurity, Family Environment Linked to Lower Rate of School Readiness',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              
                          
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,),
                          ),
                          Text('August 15, 2022',
                          style:TextStyle(
                            color: Colors.grey,
                  
                          ))
                           
                        ],
                      ),
                    ),
                  ),
                ],
                  ),
              ),
            ),
            Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    ),
          ],
        ),
        
      ),
    );
  }
}