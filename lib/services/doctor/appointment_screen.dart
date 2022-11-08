import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/////
import 'package:med/services/doctor/doctor_model.dart';
import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/state.dart';

import '../../booking/src/core/booking_calendar.dart';
import '../../booking/src/model/booking_service.dart';

class DoctorApp extends StatelessWidget {
  DoctorApp({ Key? key,required this.doctorDataModel }) : super(key: key);
  final DoctorDataModel doctorDataModel;
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
 
   ////List<DateTimeRange> converted = [];
  

  

  @override
   Widget build(BuildContext context) {
     int k = int.parse(doctorDataModel.key);
      Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    AppBloc.get(context).converted1[k].add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
    ////print('====${AppBloc.get(context).converted[0].toString()}=====');
  }
     List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    DateTime first = now;
    DateTime second = now.add(Duration(minutes: 55));
    DateTime third = now.subtract(Duration(minutes: 240));
    DateTime fourth = now.subtract(Duration(minutes: 500));
    AppBloc.get(context).converted1[k]
        .add(DateTimeRange(start: first, end: now.add(Duration(minutes: 30))));
    AppBloc.get(context).converted1[k].add(
        DateTimeRange(start: second, end: second.add(Duration(minutes: 23))));
    AppBloc.get(context).converted1[k].add(
        DateTimeRange(start: third, end: third.add(Duration(minutes: 15))));
    AppBloc.get(context).converted1[k].add(
        DateTimeRange(start: fourth, end: fourth.add(Duration(minutes: 50))));
    return AppBloc.get(context).converted1[k];
  }
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {},
      builder: (context, state) {

return Scaffold(
         
          body: Center(
            child: BookingCalendar(
              name: doctorDataModel.doctorname,
              image: doctorDataModel.image,
              email: doctorDataModel.email,
              specialization: doctorDataModel.specialization,
              key: ValueKey(doctorDataModel.key),
              bookingService: BookingService(bookingStart: DateTime(now.year, now.month, now.day, 20, 0) ,
               bookingEnd: DateTime(now.year, now.month, now.day, 22, 0),
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