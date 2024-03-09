import 'package:flutter/material.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/screens/dashboard_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/button.dart';
import 'package:kitajom/widgets/image_review.dart';
import 'package:kitajom/widgets/rating_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_pic.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        DashboardScreen.showBackDialog('Discard request and leave?', context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            toolbarHeight: 100,
            title: Text("Review"),
            centerTitle: true,
            actions: [
              Container(
                child: ProfilePic(),
              ),
            ]),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Rating  :"),
                              SizedBox(
                                width: 10,
                              ),
                              RatingWidget(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Description : "),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width * 0.90,
                                height: 200,

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: lightGrey,
                                  ),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(

                                    cursorColor:mainGreen,
                                    controller: _descriptionController,
                                    decoration: InputDecoration(
                                      // enabledBorder: OutlineInputBorder(),
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: titleGreen),
                                      // ),
                                      border: InputBorder.none,
                                      hintText: "Write your review here.",
                                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ImageReview(),
                        SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          width: 300,
                          height: 47,
                          child: MyButton(
                            buttonText: "Save Rating",
                            onTap: () {
                              Provider.of<ReviewProvider>(context, listen: false).setDescription(_descriptionController.text);
                              Provider.of<ReviewProvider>(context, listen: false).createReview();

                              Navigator.pop(
                                context,
                              );
                            },
                            color: mainGreen,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
