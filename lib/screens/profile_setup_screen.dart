import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitajom/layout/layout_main.dart';
import 'package:kitajom/layout/layout_mobile.dart';
import 'package:kitajom/resources/CRUD/user.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/textfield.dart';

import '../utils/utils.dart';
import '../widgets/button.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String email = "";

  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      email = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
  }

  void createDetail() async {
    String res = "";
    setState(() {
      _isLoading = true;
    });
    if (_image != null) {
      res = await UserController().createUser(
          username: _usernameController.text,
          lastName: _lastnameController.text,
          firstName: _firstnameController.text,
          phoneNumber: _phoneController.text,
          email: email,
          uid: FirebaseAuth.instance.currentUser!.uid,
          file: _image!);
    } else {
      res = "Please select a profile picture.";
    }

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout())));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                        backgroundColor: lightGrey,
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: lightGrey,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Profile Setup",
              style: TextStyle(
                color: titleGreen,
                fontSize: 20,
                fontFamily: 'Lexend',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            //username textfield
            TextFieldInput(
              controller: _usernameController,
              hintText: "Username",
              isPassword: false,
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 20),

            //password textfield
            TextFieldInput(
              controller: _firstnameController,
              hintText: "First Name",
              isPassword: false,
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 20),

            //confirm password textfield
            TextFieldInput(
              controller: _lastnameController,
              hintText: "Last Name",
              textInputType: TextInputType.text,
              isPassword: false,
            ),

            const SizedBox(height: 20),
            TextFieldInput(
              controller: _phoneController,
              hintText: "Phone Number",
              textInputType: TextInputType.phone,
              isPassword: false,
            ),

            const SizedBox(height: 20),
            //sign in button

            SizedBox(
              width: 300,
              height: 47,
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: mainGreen,
                    ))
                  : MyButton(
                      onTap: createDetail,
                      buttonText: "Save",
                      color: mainGreen,
                    ),
            ),

            const SizedBox(height: 25),
          ]),
        ),
      ),
    );
  }
}
