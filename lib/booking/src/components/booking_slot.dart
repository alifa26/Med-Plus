import 'package:flutter/material.dart';
import 'package:med/booking/src/components/common_card.dart';
import 'package:med/home%20page/global.dart';

class BookingSlot extends StatelessWidget {
  const BookingSlot(
      {Key? key,
      required this.child,
      required this.isBooked,
      required this.onTap,
      required this.isSelected,
      this.bookedSlotColor,
      this.selectedSlotColor,
      this.availableSlotColor})
      : super(key: key);

  final Widget child;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;

  Color getSlotColor() {
    if (isBooked) {
      return bookedSlotColor ?? Colors.redAccent;
    } else {
      return isSelected ? selectedSlotColor ?? lightBlueIsh : availableSlotColor ?? Color(0xFFFFF48D);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isBooked ? onTap : null,
      child: CommonCard(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: getSlotColor(),
          child: child),
    );
  }
}
