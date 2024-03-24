import 'package:attendance/page/authentication_page.dart/signup_page.dart';
import 'package:attendance/page/student_page/dashboard_page.dart';
import 'package:attendance/util/custom_snackbar.dart';
import 'package:attendance/widget/text_input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingControllerUserName = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  CustomSnackBar customSnackBar = CustomSnackBar();
  RegExp numberRegex = RegExp(r'^[0-9]+$');
  RegExp illegalRegex = RegExp(r'[<>&\"\\]');
  FocusNode passwordFocusNode = FocusNode();
  FocusNode repeatPasswordFocusNode = FocusNode();
  String? errorTextUserName;
  String? errorTextPassword;
  String? errorTextRepeatPassword;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 255),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    "assets/image/login_art.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "ورود به سامانه",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                         
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                
                CustomTextFields(
                  textInputAction: TextInputAction.next,
                  textEditingController: textEditingControllerUserName,
                  onChange: (p0) {
                    setState(() {
                      errorTextUserName = validateUserName(p0 );
                    });
                  },
                  textError: errorTextUserName,
                  lableText: "نام کاربری",
                  hint: "لطفا نام کاربری خود را وارد کنید",
                  
                  greyColor: Colors.grey.shade600,
                  prefixIcon: Icons.person_2_outlined,
                  iconColor: const Color.fromARGB(255, 60, 60, 60),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFields(
                  textInputAction: TextInputAction.next,
                  myFocusNode: passwordFocusNode,
                  textEditingController: textEditingControllerPassword,
                  onChange: (p0) {
                    setState(() {
                      errorTextPassword = validatePassword(p0 );
                    });
                  },
                  textError: errorTextPassword,
                  greyColor: Colors.grey.shade600,
                  lableText: "رمز عبور",
                  hint: "لطفا رمز عبور خود را وارد کنید",
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  iconColor: const Color.fromARGB(255, 60, 60, 60),
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context)
                        .requestFocus(repeatPasswordFocusNode);
                  },
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: 
                          InkWell(
                              onTap: () {
                                
                              },
                              child: const Text(
                                "رمز عبور خود را فراموش کرده اید؟",
                                style:
                                    TextStyle(color:  Color(0xFF1F54D3), fontSize: 14,fontWeight: FontWeight.bold),
                                )
                              ),
                         
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width - 60, 60),
                        backgroundColor: const Color(0xFF1F54D3),
                        elevation: 5,
                        animationDuration: const Duration(milliseconds: 1000),
                        
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      String userName = textEditingControllerUserName.text;
                      String passwordName = textEditingControllerPassword.text;
                    
                      String? errorUserName =
                          validateUserName(userName, showSnackBar: true);
                      if (errorUserName != null) {
                        setState(() {
                          errorTextUserName = errorUserName;
                        });
                        return;
                      }
                      String? errorPassword =
                          validatePassword(passwordName, showSnackBar: true);
                      if (errorPassword != null) {
                        setState(() {
                          errorTextPassword = errorPassword;
                        });
                        return;
                      }
                     
                       Navigator.push(
                                context,
                                PageTransition(
                                   type: PageTransitionType.bottomToTopPop,
                                   child:  const MyHomePage(),
                                   childCurrent: context.widget,
                                   duration: const Duration( milliseconds: 500),
                                   reverseDuration: const Duration(milliseconds: 500)
                                  )
                       );
                      customSnackBar.showSuccessSnackBar(context, "LOGGED IN");

                    },
                    child: const Text(
                      "ورود",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: [
                        const Text(
                          "ثبت نام نکرده اید؟",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      child: const SignUpPage(),
                                      childCurrent: context.widget,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      reverseDuration:
                                          const Duration(milliseconds: 500)));
                            },
                            child: const Text(
                              "ثبت نام کنید.",
                              style:
                                  TextStyle(color: Color(0xFF1F54D3), fontSize: 18),
                            )),
                      ],
                    ))
              
              ],
            ),
          ),
        ));
  }

  String? validateUserName(String value, {bool showSnackBar = false}) {
    String? data;
    if (value.isEmpty) {
      data = "شماره دانشجویی نباید خالی باشد";
    } else {
      if (illegalRegex.hasMatch(value)) {
        data = "ورودی نامعتبر";
      } else if (!numberRegex.hasMatch(value)) {
        data = "لطفا فقط عدد را به صورت انگلیسی وارد کنید";
      }
    }
    if (showSnackBar && data != null) {
      customSnackBar.showErrorSnackBar(context, data);
    }
    return data;
  }

  String? validatePassword(String value, {bool showSnackBar = false}) {
    String? data;
    if (value.isEmpty) {
      data = "رمز عبور نباید خالی باشد";
    } else {
      if (illegalRegex.hasMatch(value)) {
        data = "ورودی نامعتبر";
      }
    }
    if (showSnackBar && data != null) {
      customSnackBar.showErrorSnackBar(context, data);
    }
    return data;
  }


}
