import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:task1/data/colorPlate.dart';
import 'package:task1/ui/screens/auth/signupScreen.dart';
import 'package:task1/ui/screens/main_bottomnav.dart';
import 'package:task1/ui/state_holder/controller/signinController.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;
  bool ischecked = false;
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Appcolor.primarycolor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.27,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.07,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  "Please sign in to continue",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenHeight * 0.01 * 2),
                                  SizedBox(height: screenHeight * 0.01),
                                  SizedBox(
                                    height: 85,
                                    child: TextFormField(
                                      controller: _emailTEC,
                                      decoration: const InputDecoration(
                                        labelText: "Enter your Email",
                                        prefixIcon: Icon(Icons.email_outlined),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Email can't be null";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 75,
                                    child: TextFormField(
                                      controller: _passwordTEC,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText ? Icons.visibility : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.length < 5) {
                                          return 'Password must be at least 5 characters long';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005 * 2),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: ischecked,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4)),
                                        activeColor: Appcolor.primarycolor,
                                        onChanged: (newbool) {
                                          setState(() {
                                            ischecked = newbool!;
                                          });
                                        },
                                      ),
                                      const Text('Remember Me'),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          // Get.to(const ForgotPassPage());
                                        },
                                        child: const Text('Forgot password?'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: screenHeight * 0.07,
                                    child: GetBuilder<SigninController>(
                                      builder: (signinController) {
                                        if (signinController.signinverificationInprogress) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (_formkey.currentState!.validate()) {
                                              verifySignin(signinController);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Appcolor.primarycolor,
                                            textStyle: TextStyle(
                                              fontSize: screenWidth * 0.045,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an account? '),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(const SignUpPage());
                                        },
                                        child: const Text('Sign up'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> verifySignin(SigninController signinController) async {
    final response = await signinController.verifySignin(
        _emailTEC.text.trim(),
        _passwordTEC.text.trim());
    if (response) {
      Get.offAll(const MainBottomNavScreen()); // Navigate to the main screen
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong Information! Try Again')));
      }
    }
  }
}
