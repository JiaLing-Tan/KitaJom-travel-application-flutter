import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/resources/CRUD/booking.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/utils.dart';

import '../provider/booking_provider.dart';

class BookingCountWidget extends StatefulWidget {
  Accommodation accommodation;
  BookingProvider value;

  BookingCountWidget(
      {super.key, required this.accommodation, required this.value});

  @override
  State<BookingCountWidget> createState() => _BookingCountWidgetState();
}

class _BookingCountWidgetState extends State<BookingCountWidget> {
  final BookingController bookingController = BookingController();



  @override
  Widget build(BuildContext context) {
    print(widget.value.checkIn);
    double price = widget.accommodation.roomTypes[0]["price"];
    List<Timestamp> unavailableDates = widget.accommodation.unavailableDate;
    List<DateTime> unavailableDays = [];
    for (Timestamp i in unavailableDates)
      {
        unavailableDays.add(i.toDate());
      }

    List<DateTime> day = [];


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          final List<DateTime?>? dateTimeRange = await showCalendarDatePicker2Dialog(

            context: context,
            config: CalendarDatePicker2WithActionButtonsConfig(
              selectedDayHighlightColor: mainGreen,
              selectedRangeHighlightColor: mainGreen.withOpacity(0.5),
              calendarType: CalendarDatePicker2Type.range,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              selectableDayPredicate: (date){
                if(!unavailableDays.contains(date)) {
                 return true;
                }
                return false;
              },

            ),
            dialogSize: const Size(325, 400),
            value: day,
            borderRadius: BorderRadius.circular(15),
          );
          List<DateTime> days = [];
          if (dateTimeRange != null) {
            for (int i = 0; i < dateTimeRange[1]!.difference(dateTimeRange[0]!).inDays; i++) {
              days.add(dateTimeRange[0]!.add(Duration(days: i)));
            }
            print(dateTimeRange);

            // Find the intersection of the sets
            Set<DateTime?> common = days.toSet().intersection(unavailableDays.toSet());
            print(common);
            if (common.isEmpty){
              if (dateTimeRange[1]!.difference(dateTimeRange[0]!).inDays < 30) {
                setState(() {
                  widget.value.sumTotal(price.round(), dateTimeRange);
                });
                print("oi");
              } else {
                showSnackBar("Duration over 30 days is not available.", context);
              }
            }else
              {
                showSnackBar("You have selected dates that are not available", context);
              }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: mainGreen,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                        "${DateFormat('(E) dd, MMM').format(DateTime.parse(widget.value.checkIn))} - ${DateFormat('(E) dd, MMM').format(DateTime.parse(widget.value.checkOut))}"),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*Column(
children: [
Padding(
padding:
EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
child: Text("idk",style: TextStyle( fontSize: 17)),
),
Padding(
padding:
EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
child: Text("RM" + ticket['price'].round().toString(), style: TextStyle(color: mainGreen, fontSize: 15),),
),
],
),
Padding(
padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
child: Row(
children: [
GestureDetector(
onTap: () {
decrement(ticketName, ticket['price'].round());
},
child: Icon(Icons.remove)),
SizedBox(
width: 5,
),
Container(
width: 20,
height: 30,
decoration: BoxDecoration(color: Colors.grey[200]),
child: Center(
child: Text(_roomNumbers[ticketName].toString())),
),
SizedBox(
width: 5,
),
GestureDetector(
onTap: () {
increment(ticketName, ticket['price'].round());
},
child: Icon(Icons.add))
],
),
)*/
