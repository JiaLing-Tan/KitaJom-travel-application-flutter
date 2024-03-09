import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/screens/profile_screen.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPic();
  }

  bool _isLoading = false;
  String photoUrl = "";

  void getPic() async {
    _isLoading = true;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print((snap.data() as Map<String, dynamic>)['photoUrl']);
    setState(() {
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: _isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                    )
                    : Image.network(photoUrl, width: 50, height: 50, fit: BoxFit.cover,frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return child;
                    }, loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return SizedBox( height: 20, width: 20,
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.grey,),
                          ),
                        );
                      }
                    }))));
  }
}
