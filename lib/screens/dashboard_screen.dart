import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitajom/model/attraction.dart';
import 'package:kitajom/widgets/attraction_widget.dart';
import 'package:kitajom/widgets/circle_widget.dart';

import '../utils/colors.dart';
import '../widgets/profile_pic.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();

  static void showBackDialog(String confirmation, context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text(
            confirmation,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                if (confirmation == 'Are you sure you want to leave the app?') {
                  SystemNavigator.pop();
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  String username = "";
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<Attraction> attractions = [];
  bool _search = false;
  String _searchTerm = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    DocumentSnapshot attractionSnap =
        await FirebaseFirestore.instance.collection('activity').doc().get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _search = false;
        });
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          DashboardScreen.showBackDialog(
              'Are you sure you want to leave the app?', context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 150,
              //title: SizedBox(child: Text("Where would you like to vacation to, $username?")),
              title: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: " Where would you like to",
                      style: TextStyle(color: black, fontSize: 20)),
                  const TextSpan(text: "\n"),
                  const TextSpan(
                      text: " vacation to, ",
                      style: TextStyle(color: black, fontSize: 20)),
                  TextSpan(
                      text: username,
                      style: const TextStyle(color: titleGreen, fontSize: 20)),
                  const TextSpan(
                      text: "?", style: TextStyle(color: black, fontSize: 20))
                ]),
              ),
              centerTitle: false,
              actions: const [
                ProfilePic(),
              ]),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SearchBar(
                      onChanged: (_) {
                        setState(() {
                          _searchTerm = _searchController.text;
                        });
                      },
                      onTap: () {
                        setState(() {
                          _search = true;
                        });
                      },
                      controller: _searchController,
                      hintText: "Search Destination",
                      leading: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Icon(
                          Icons.search,
                          color: titleGreen,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(selectedGreen),
                    ),
                  ),
                  Stack(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 25, right: 25),
                          child: Text(
                            "Start with...",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleWidget(
                                  desText: "Accomodation", icon: Icons.hotel),
                              CircleWidget(
                                  desText: "Restaurant",
                                  icon: Icons.restaurant),
                              CircleWidget(
                                  desText: "Attraction",
                                  icon: Icons.attractions),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25),
                          child: Text(
                            "Experiences",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, left: 25),
                          child: Text(
                              "Explore what other travelers are raving about."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: SizedBox(
                            height: queryData.size.height * 0.35,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 3, 10, 5),
                                  child: Stack(children: [
                                    SizedBox(
                                      width: queryData.size.height * 0.2,
                                      height: queryData.size.height * 0.35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            "https://i.natgeofe.com/n/1690f081-f44f-4fbe-a1b6-9123819b737c/petronas-kualalumpur-malaysia.jpg?w=2520&h=1682"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: queryData.size.height * 0.2,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: white.withOpacity(0.6),
                                            ),
                                            width: 130,
                                            height: 60,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Kuala Lumpur",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 3, 10, 5),
                                  child: Stack(children: [
                                    SizedBox(
                                      width: queryData.size.height * 0.2,
                                      height: queryData.size.height * 0.35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            "https://www.bikeandtours.com/application/files/3915/2687/2263/Cameron_Highlands.jpg"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: queryData.size.height * 0.2,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: white.withOpacity(0.6),
                                            ),
                                            width: 130,
                                            height: 60,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Pahang",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 3, 10, 5),
                                  child: Stack(children: [
                                    SizedBox(
                                      width: queryData.size.height * 0.2,
                                      height: queryData.size.height * 0.35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcQgm4z0vuwmpbQkZ9vW6lgdCTgeQUFlGTDQd81B2VAbnF4cBDRG9QlyjH_jhUnkRqe0fT3a6tv1j4ZG84x2Ht9quP903RLzc5zP7i12Bu8"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: queryData.size.height * 0.2,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: white.withOpacity(0.6),
                                            ),
                                            width: 130,
                                            height: 60,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Genting Highlands",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    _search
                        ? StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('activity')
                                .where('isAvailable', isEqualTo: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                var attractions =
                                    snapshot.data!.docs.map((doc) {
                                  return Attraction.fromSnap(doc);
                                }).toList();

                                attractions.sort(
                                    (a, b) => (b!.rating).compareTo(a!.rating));

                                return (attractions.isEmpty)
                                    ? const Center(
                                        child:
                                            Text("No attraction is available!"))
                                    : Container(
                                        color: white,
                                        height: double.maxFinite,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: attractions.length,
                                          itemBuilder: (context, index) {
                                            var attraction = attractions[index];
                                            Key tileKey =
                                                Key(attraction!.listingId);

                                            return _searchTerm.isEmpty
                                                ? SizedBox()
                                                : (attraction.listingName
                                                            .toLowerCase()
                                                            .contains(
                                                                _searchTerm) ||
                                                        attraction.address
                                                            .toLowerCase()
                                                            .contains(
                                                                _searchTerm))
                                                    ? AttractionWidget(
                                                        attraction: attraction)
                                                    : SizedBox();
                                          },
                                        ),
                                      );
                              }
                            })
                        : SizedBox(),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// children: _isLoading? [
// CircularProgressIndicator(
// color: mainGreen,
// )]:[
// Text("This is dashboard for $username"),
// MyButton(
// onTap: signUserOut, buttonText: "sign out", color: mainGreen)
// ],
