import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kitajom/utils/utils.dart';
import 'package:kitajom/widgets/button.dart';
import 'package:kitajom/widgets/filterbar_itinerary.dart';
import 'package:provider/provider.dart';

import '../provider/request_provider.dart';
import '../utils/colors.dart';
import '../widgets/profile_pic.dart';

final apiKey = "your_API";

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  String username = "";
  String itinerary = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void onTap() async {
    if (itinerary==""){
      showSnackBar("Nothing is saved", context);
    }else
   {
     await Clipboard.setData(ClipboardData(text: itinerary));
     showSnackBar("Copied to clipboard.", context);
   }
  }

  void sendToGPT(String message) async {
    setState(() {
      _isLoading = true;
    });
    print(message);
    final response =
        await http.post(Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: json.encode({
              'max_tokens': 4000,
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": message}
              ],
            }));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        itinerary = jsonResponse['choices'][0]['message']["content"];
        print(itinerary);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text("Itinerary"), actions: [
          Container(
            child: ProfilePic(),
          ),
        ]),
        body: SafeArea(
          child: Column(
            children: [
              FilterBarItinerary(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _isLoading
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: mainGreen,
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Text(itinerary),
                                ),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 47,
                  child: MyButton(
                      onTap: () {
                        value.generateRequest();
                        sendToGPT(value.request);
                      },
                      buttonText: "Generate",
                      color: mainGreen),
                ),
              ),
              SizedBox(
                  width: 300,
                  height: 47,
                  child: MyButton(
                      onTap: onTap, buttonText: "Save", color: lightGreen)),
            ],
          ),
        ),
      ),
    );
  }
}
