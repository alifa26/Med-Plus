
import 'package:flutter/material.dart';
import 'package:med/booking/src/components/booking_explanation.dart';
import 'package:med/booking/src/components/booking_slot.dart';
import 'package:med/booking/src/components/common_button.dart';
import 'package:med/booking/src/components/common_card.dart';
import 'package:med/booking/src/util/booking_util.dart';
import 'package:med/home%20page/global.dart';
import 'package:provider/provider.dart';
import '../core/booking_controller.dart';
import '../model/booking_service.dart';
import 'booking_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendarMain extends StatefulWidget {
  const BookingCalendarMain({
    Key? key,
    required this.getBookingStream,
    required this.convertStreamResultToDateTimeRanges,
    required this.uploadBooking,
    this.bookingExplanation,
    this.bookingGridCrossAxisCount,
    this.bookingGridChildAspectRatio,
    this.formatDateTime,
    this.bookingButtonText,
    this.bookingButtonColor,
    this.bookedSlotColor,
    this.selectedSlotColor,
    this.availableSlotColor,
    this.bookedSlotText,
    this.selectedSlotText,
    this.availableSlotText,
    this.gridScrollPhysics,
    this.loadingWidget,
    this.errorWidget,
    required this.image,
    required this.email,
    required this.name,
    required this.specialization,
  }) : super(key: key);
  final String? image;
  final String? name;
  final String? email;
  final String? specialization;
  final Stream<dynamic>? Function({required DateTime start, required DateTime end}) getBookingStream;
  final Future<dynamic> Function({required BookingService newBooking}) uploadBooking;
  final List<DateTimeRange> Function({required dynamic streamResult}) convertStreamResultToDateTimeRanges;

  ///Customizable
  final Widget? bookingExplanation;
  final int? bookingGridCrossAxisCount;
  final double? bookingGridChildAspectRatio;
  final String Function(DateTime dt)? formatDateTime;
  final String? bookingButtonText;
  final Color? bookingButtonColor;
  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;
  final String? bookedSlotText;
  final String? selectedSlotText;
  final String? availableSlotText;
  final ScrollPhysics? gridScrollPhysics;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  State<BookingCalendarMain> createState() => _BookingCalendarMainState();
}

class _BookingCalendarMainState extends State<BookingCalendarMain> {
  late BookingController controller;
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller = context.read<BookingController>();

    startOfDay = now.startOfDay;
    endOfDay = now.endOfDay;
    _focusedDay = now;
    _selectedDay = now;
  }

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime startOfDay;
  late DateTime endOfDay;
  List<int> _weekend = [DateTime.saturday, DateTime.friday];

  void selectNewDateRange() {
    startOfDay = _selectedDay.startOfDay;
    endOfDay = _selectedDay.add(const Duration(days: 1)).endOfDay;

    controller.base = startOfDay;
    controller.resetSelectedSlot();
  }

  @override
  Widget build(BuildContext context) {
    String alpha;
    controller = context.watch<BookingController>();

    return Consumer<BookingController>(
      builder: (_, controller, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child:Column(
                children: [
                  Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                         height: MediaQuery.of(context).size.height / 4 - 20,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           color: Colors.teal
                         ),
                       child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(backgroundImage: NetworkImage(widget.image.toString()),
                            radius: 55,),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name.toString(),
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 10,),
                                Text(widget.specialization.toString(),
                                style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 10,),
                                Text(widget.email.toString(),
                                style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),)
                          
                              ],
                            ),
                          )
                        ],
                       ),
                     ),
                ),
                SizedBox(height: 15,),
                  CommonCard(
                    child: TableCalendar(
                      startingDayOfWeek: StartingDayOfWeek.tuesday,
                      firstDay: DateTime.now(),
                      weekendDays: _weekend,
                      lastDay: DateTime.now().add(const Duration(days: 1000)),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      calendarStyle: const CalendarStyle(isTodayHighlighted: true),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          selectNewDateRange();
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  widget.bookingExplanation ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BookingExplanation(
                              color: widget.availableSlotColor ?? lightBlueIsh,
                              text: widget.availableSlotText ?? "Available"),
                          BookingExplanation(
                              color: widget.selectedSlotColor ?? lightGreen,
                              text: widget.selectedSlotText ?? "Selected"),
                          BookingExplanation(
                              color: widget.bookedSlotColor ?? Colors.redAccent,
                              text: widget.bookedSlotText ?? "Booked"),
                        ],
                      ),
                  const SizedBox(height: 8),
                  StreamBuilder<dynamic>(
                    stream: widget.getBookingStream(start: startOfDay, end: endOfDay),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return widget.errorWidget ??
                            Center(
                              child: Text(snapshot.error.toString()),
                            );
                      }

                      if (!snapshot.hasData) {
                        return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
                      }

                      ///this snapshot should be converted to List<DateTimeRange>
                      final data = snapshot.requireData;
                      controller.generateBookedSlots(widget.convertStreamResultToDateTimeRanges(streamResult: data));

                      return Expanded(
                        child: GridView.builder(
                          physics: widget.gridScrollPhysics ?? const BouncingScrollPhysics(),
                          itemCount: _weekend.contains(_selectedDay.weekday) ? 0 : controller.allBookingSlots.length,
                          itemBuilder: (context, index) => BookingSlot(
                            isBooked: controller.isSlotBooked(index),
                            isSelected: index == controller.selectedSlot,
                            onTap: () => controller.selectSlot(index),
                            child: Center(
                              child: Text(
                                widget.formatDateTime?.call(controller.allBookingSlots.elementAt(index)) ??
                                    BookingUtil.formatDateTime(controller.allBookingSlots.elementAt(index)),
                              ),
                            ),
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.bookingGridCrossAxisCount ?? 3,
                            childAspectRatio: widget.bookingGridChildAspectRatio ?? 1.5,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonButton(
                    text: widget.bookingButtonText ?? 'BOOK',
                    onTap: () async {
                      controller.toggleUploading();
                      await widget.uploadBooking(newBooking: controller.generateNewBookingForUploading());
                      controller.toggleUploading();
                      controller.resetSelectedSlot();
                    },
                    isDisabled: controller.selectedSlot == -1,
                    buttonActiveColor: widget.bookingButtonColor,
                  ),
                ],
              ),
      ),
    );
  }
}
