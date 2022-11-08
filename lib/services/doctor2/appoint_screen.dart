import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med/home%20page/global.dart';
/////
import 'package:med/services/doctor/doctor_model.dart';
import 'package:med/services/doctor2/appmodel.dart';
import 'package:med/services/doctor2/appoint_made.dart';
import 'package:med/services/doctor2/doctors_model.dart';
import 'package:med/social_app/constants.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/state.dart';

import '../../booking/src/core/booking_calendar.dart';
import '../../booking/src/model/booking_service.dart';

class appointScreen extends StatelessWidget {
   appointScreen({ Key? key ,required this.doctorsDataModel}) : super(key: key);
final DoctorsDataModel doctorsDataModel;
   late List<String> d ;
  final now = DateTime.now();
  String con = 'converted1';

  /*mockBookingService = BookingService(
      serviceId: doctorDataModel.key,
        serviceName: 'Mock Service',
        serviceDuration: 40,
        bookingEnd: DateTime(now.year, now.month, now.day, 22, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 20, 0));*/

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }
 
   List<DateTimeRange> converted = [];
   List<DateTimeRange> converted1 = [];
   late BookingService bs;
   late DateTimeRange dtr;
  late DateTime dt;
  late DateTime day;
  late DateTime month;
  late DateTime hour;

  

  @override
   Widget build(BuildContext context) {
     List<String> conv = doctorsDataModel.converted;
     for(var x in conv){
       List<DateTimeRange> conv1 = [];
       List<DateTimeRange> converted2 = [];
       conv1.add(DateTimeRange(start: DateTime.parse(x.substring(0,22)), end:DateTime.parse(x.substring(26,48))));
       for(var z in conv1){
         converted.add(z);
       }
     }
     int k = int.parse(doctorsDataModel.key);



      Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
    for(var a in converted){
    ///conv = [];
      List<String> x = [];
      x.add(a.toString());
      for(var b in x){
        conv.add(b);
      }
    }
    if(newBooking != null){
      dt = newBooking.bookingStart;
    }
    DoctorsDataModel dm = DoctorsDataModel(dId: doctorsDataModel.dId,
     doctorname: doctorsDataModel.doctorname,
      email: doctorsDataModel.email,
       specialization: doctorsDataModel.specialization,
        image: doctorsDataModel.image,
         key: doctorsDataModel.key,
     converted: conv.toSet().toList());
     FirebaseFirestore.instance.collection('list').doc(doctorsDataModel.dId).update(dm.toJson());

     AppModel amp1 = AppModel(username: doctorsDataModel.doctorname,
     uId: 'cd',
      day: dt.day.toString(),
       image: doctorsDataModel.image,
        month: dt.month.toString(),
         year: dt.year.toString(),
          hour: dt.hour.toString(),
           minute: dt.minute.toString(),
            email: doctorsDataModel.email,
            lat: '0', 
            lon: '0',
             number: doctorsDataModel.key);

    AppModel amp2 = AppModel(username: AppBloc.get(context).user!.username,
    uId: 'vd',
     day: dt.day.toString(),
      image: AppBloc.get(context).user!.image,
       month: dt.month.toString(),
        year: dt.year.toString(),
         hour: dt.hour.toString(),
          minute: dt.minute.toString(),
           email: AppBloc.get(context).user!.email,
            lat: AppBloc.get(context).user!.lat,
             lon: AppBloc.get(context).user!.lon,
              number: AppBloc.get(context).user!.num);
     FirebaseFirestore.instance.collection('Appoints ${AppBloc.get(context).user!.username}').add(amp1.toJson());
     FirebaseFirestore.instance.collection('Appoints ${doctorsDataModel.doctorname}').add(amp2.toJson());
    /* FirebaseFirestore.instance.collection('Appoints ${AppBloc.get(context).user!.username}')
     .doc(AppBloc.get(context).user!.username)
     .set({
       'uId': doctorsDataModel.dId,
      'username': doctorsDataModel.doctorname,
      'day': dt.day,
      'month': dt.month,
      'year': dt.year,
      'hour':dt.hour,
      'minute':dt.minute,
      'email':doctorsDataModel.email,
       'lat' :'0',
       'lon' : '0',
       'number' : doctorsDataModel.key,
       'image' : doctorsDataModel.image
     });*/
     /*FirebaseFirestore.instance.collection('Appoints ${doctorsDataModel.doctorname}').doc(doctorsDataModel.doctorname).set({
       'uId': AppBloc.get(context).user!.uId,
      'username': AppBloc.get(context).user!.username,
      'day': dt.day,
      'month': dt.month,
      'year': dt.year,
      'hour':dt.hour,
      'minute':dt.minute,
      'email':AppBloc.get(context).user!.email,
       'lat' :AppBloc.get(context).user!.lat,
       'lon' : AppBloc.get(context).user!.lon,
       'number' : AppBloc.get(context).user!.num,
       'image' : AppBloc.get(context).user!.image
     });*/
     print('xxxxxxx'+doctorsDataModel.dId+'xxxxxxxxxxxxxxx');
    print('====${dt.day}=====');
  }
     List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    DateTime first = now;
    DateTime second = now.add(Duration(minutes: 55));
    DateTime third = now.subtract(Duration(minutes: 240));
    DateTime fourth = now.subtract(Duration(minutes: 500));
    converted1
        .add(DateTimeRange(start: first, end: now.add(Duration(minutes: 30))));
    converted1.add(
        DateTimeRange(start: second, end: second.add(Duration(minutes: 23))));
    converted1.add(
        DateTimeRange(start: third, end: third.add(Duration(minutes: 15))));
    converted1.add(
        DateTimeRange(start: fourth, end: fourth.add(Duration(minutes: 50))));
    return converted;
    
  }
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {

return Scaffold(
         
          body: Center(
            child: BookingCalendar(
              bookingButtonColor: lightGreen,
              availableSlotColor: Color(0xFFFFF48D),
              selectedSlotColor: lightBlueIsh,
              name: doctorsDataModel.doctorname,
              image: doctorsDataModel.image,
              email: doctorsDataModel.email,
              specialization: doctorsDataModel.specialization,
              key: ValueKey(doctorsDataModel.key),
              bookingService: BookingService(bookingStart: DateTime(now.year, now.month, now.day, 09, 00) ,
               bookingEnd: DateTime(now.year, now.month, now.day, 15, 0),
                serviceName: 'Mock Service',
                 serviceDuration: 40),
              convertStreamResultToDateTimeRanges: convertStreamResultMock,
              getBookingStream: getBookingStreamMock,
              uploadBooking: uploadBookingMock,
              
            ),
          ),
        );
      },
    );
  }
}