import 'package:flutter/material.dart';
import 'package:kitajom/layout/layout_main.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:kitajom/screens/register_screen.dart';
import 'package:kitajom/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../layout/layout_mobile.dart';
import '../model/user.dart';
import '../resources/auth_method.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/button.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void naviageToSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignupScreen(),
    ));
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authentication().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      User currentUser = await Authentication().getUserDetails();
      Provider.of<UserProvider>(context, listen: false).setUser(currentUser);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout())));
    } else {
      showSnackBar(res, context);
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
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                "Sign in to explore",
                style: TextStyle(
                  color: titleGreen,
                  fontSize: 20,
                  fontFamily: 'Lexend',
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "the best of Malaysia",
                style: TextStyle(
                  color: titleGreen,
                  fontSize: 20,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              //username textfield
              TextFieldInput(
                controller: _emailController,
                hintText: "E-mail",
                isPassword: false, textInputType: TextInputType.text,
              ),

              const SizedBox(height: 20),

              //password textfield
              TextFieldInput(
                controller: _passwordController,
                hintText: "Password",
                isPassword: true, textInputType: TextInputType.text,
              ),

              const SizedBox(height: 10),

              //forgot password?

              Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 20),

              //sign in button

              SizedBox(
                width: 300,
                height: 47,
                child: _isLoading? Center(child: CircularProgressIndicator(color: mainGreen,)): MyButton(
                  onTap: loginUser,
                  buttonText: "Sign In", color: mainGreen,
                ),
              ),

              const SizedBox(height: 25),

              //not a member? register now.

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: titleGreen),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: naviageToSignup,
                    child: Text(
                      "Register now.",
                      style: TextStyle(
                        color: titleGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
