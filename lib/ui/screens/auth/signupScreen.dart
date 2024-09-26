import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:task1/ui/screens/auth/signinScreen.dart';
import 'package:task1/ui/state_holder/controller/signUpController.dart';


import '../../../data/colorPlate.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText2 = true;
  bool ischecked = false;
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _fnameTEC = TextEditingController();
  final TextEditingController _lnameTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
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
                          height: screenHeight * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.07,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  "Just a few quick things to get started",
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

                                  TextFormField(
                                    controller: _emailTEC,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_outlined),
                                        labelText: 'Enter your Email'
                                    ),
                                    validator: (value) {
                                      if (value == null ) {
                                        return "Email can't be null";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  TextFormField(
                                    controller: _fnameTEC,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person_outlined),
                                      labelText: 'First Name'
                                    ),
                                    validator: (value) {
                                      if (value == null ) {
                                        return "Name can't null";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  TextFormField(
                                    controller: _lnameTEC,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person_outlined),
                                        labelText: 'Last Name'
                                    ),
                                    validator: (value) {
                                      if (value == null ) {
                                        return "Name can't null";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  TextFormField(
                                    controller: _phoneTEC,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person_outlined),
                                        labelText: 'Phone Number'
                                    ),
                                    validator: (value) {
                                      if (value!.length < 11) {
                                        return 'Phone must be at least 11 characters long';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  TextFormField(
                                    controller: _passwordTEC,
                                    decoration: InputDecoration(
                                      labelText: 'Enter your Password',
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText2 ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText2 = !_obscureText2;
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          value: ischecked,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                          ),
                                          activeColor: Appcolor.primarycolor,
                                          onChanged: (newbool) {
                                            setState(() {
                                              ischecked = newbool!;
                                            });
                                          }),
                                       const Text('I agree with the terms and condition'),

                                    ],
                                  ),
                                  GetBuilder<SignUpController>(
                                    builder: (signUpController) {
                                      if (signUpController.signupverificationInprogress) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return SizedBox(
                                        width: double.infinity,
                                        height: screenHeight * 0.07,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              verifySignup(signUpController);
                                              Get.offAll(const SignInPage());
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
                                        ),
                                      );
                                    }
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an account? '),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(const SignInPage());
                                        },
                                        child: const Text('Sign in'),
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


  Future<void> verifySignup(SignUpController signUpController) async {
    final response = await signUpController.verifySignup(
      _emailTEC.text.trim(),
      _fnameTEC.text.trim(),
      _lnameTEC.text.trim(),
      _phoneTEC.text.trim(),
      _passwordTEC.text.trim(),
    );

    if (response) {
      Get.offAll(const SignInPage());
    } else {
      context.go('/SignIn');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong Information! Try Again')),
        );
      }
    }
  }


}
