import 'package:flutter/material.dart';
import 'package:kitajom/model/user.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:kitajom/resources/auth_method.dart';
import 'package:kitajom/screens/login_screen.dart';
import 'package:kitajom/screens/profile_setup_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../widgets/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isLoading = false;

  //Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authentication().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      confirm: _confirmController.text,
      username: '',
      lastName: '',
      firstName: '',
      phoneNumber: '',
    );

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      User currentUser = await Authentication().getUserDetails();
      Provider.of<UserProvider>(context, listen: false).setUser(currentUser);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SetupScreen(),
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 30),
              //logo
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('lib/images/16.png'),
                ),
              ),

              const SizedBox(height: 5),

              //welcome back, you've been missed

              const Text(
                "Establish yourself on\nthe platform to be",
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
                controller: _emailController,
                hintText: "E-mail",
                isPassword: false,
                textInputType: TextInputType.text,
              ),

              const SizedBox(height: 20),

              //password textfield
              TextFieldInput(
                controller: _passwordController,
                hintText: "Password",
                isPassword: true,
                textInputType: TextInputType.text,
              ),

              const SizedBox(height: 20),

              //confirm password textfield
              TextFieldInput(
                controller: _confirmController,
                hintText: "Confirm your password",
                textInputType: TextInputType.text,
                isPassword: true,
              ),

              const SizedBox(height: 20),

              //sign in button

              SizedBox(
                height: 47,
                width: 300,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: mainGreen,
                      ))
                    : MyButton(
                        onTap: signUpUser,
                        buttonText: "Sign Up",
                        color: mainGreen,
                      ),
              ),

              const SizedBox(height: 25),

              //not a member? register now.

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(color: titleGreen),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Text(
                      "Sign in here.",
                      style: TextStyle(
                        color: titleGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ]),
          ),
        ),
      ),
    );
  }
}
