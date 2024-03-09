import 'package:flutter/material.dart';
import 'package:kitajom/model/attraction.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/utils.dart';

import '../provider/booking_provider.dart';

class TicketCountWidget extends StatefulWidget {
  Attraction attraction;
  BookingProvider value;

  TicketCountWidget({super.key, required this.attraction, required this.value});

  @override
  State<TicketCountWidget> createState() => _TicketCountWidgetState();
}

class _TicketCountWidgetState extends State<TicketCountWidget> {
  final Map<String, int> _ticketNumbers = {};

  void decrement(String ticketName, int price) {
    setState(() {
      if (_ticketNumbers[ticketName]! > 0) {
        _ticketNumbers[ticketName] = (_ticketNumbers[ticketName] ?? 0) - 1;
        widget.value.setTotal(price, "subtract", _ticketNumbers);
      }
    });
  }

  void increment(String ticketName, int price) {
    setState(() {
      if (_ticketNumbers[ticketName]! < 10) {
        _ticketNumbers[ticketName] = (_ticketNumbers[ticketName] ?? 0) + 1;
        widget.value.setTotal(price, "add", _ticketNumbers);
      } else {
        showSnackBar("The maximum number of ticket is 10 tickets.", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.value.setAttraction(widget.attraction);
    List<Map> ticketList = widget.attraction.ticketPrice;
    return Container(
      width: double.maxFinite,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ticketList.length,
          itemBuilder: (context, index) {
            var ticket = ticketList[index];
            String ticketName = ticket['name'];
            if (!_ticketNumbers.containsKey(ticketName)) {
              _ticketNumbers[ticketName] = 0;
            }
            Key tileKey = Key(ticketName);
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                          child: Text(ticket['name'],style: TextStyle( fontSize: 17)),
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
                                child: Text(_ticketNumbers[ticketName].toString())),
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
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
