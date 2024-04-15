import 'dart:async';

import 'package:attendance/controller/auth_controller/login_controller.dart';
import 'package:attendance/controller/auth_controller/login_getstate_controller.dart';
import 'package:attendance/page/student_page/main_page.dart';
import 'package:attendance/util/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uni_links/uni_links.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  String auth='';
  GetStateLoginController getStateLoginController=GetStateLoginController();
  LoginController loginController = LoginController();
  CustomSnackBar customSnackBar =CustomSnackBar();
  StreamSubscription? _sub;
  bool isLoading = false ;
  bool _initialUriIsHandled = false;
  
  String getUrl(String state){
    return "https://auth.kashanu.ac.ir/realms/kashan/protocol/openid-connect/auth?state=$state&scope=profile%20email&response_type=code&approval_prompt=auto&client_id=application&redirect_uri=https://razdeveloper.ir/api/login/redirect";
  }
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
      _handleIncomingLinks();
    _handleInitialUri();
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,  
        DeviceOrientation.portraitDown,
        
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
  }
 
  



  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
//    {
//   "_id": {
//     "$oid": "661d24813f36cc5fe5227665"
//   },
//   "CodeStudent": "9921010051",
//   "UniqAndroid": "Android|mt6769t|RP1A.200720.012|samsung|SM-A325F|21DJF711|k69v1_64_titan_marmot",
//   "UniqNotification": null,
//   "Password": "",
//   "Status": 1,
//   "__v": 0
// }
//   {
//   "_id": {
//     "$oid": "661d220f3f36cc5fe5227661"
//   },
//   "CodeStudent": "9921010051",
//   "UniqAndroid": "Android|mt6769t|RP1A.200720.012|samsung|SM-A325F|21DJF711|k69v1_64_titan_marmot",
//   "UniqNotification": null,
//   "Password": "",
//   "Status": 1,
//   "__v": 0
// }
      _sub = uriLinkStream.listen((Uri? uri) {
        if(uri != null && uri.toString().startsWith('app://razdeveloper.ir')){
          String? state =(uri.queryParameters['auth']);
          if(state!=null){
            setState(() {
              isLoading = true;
            });
            loginController.login(state).then((responce){
             setState(() {
               isLoading = false;
             });
             responce.fold((l){
                Navigator.pushReplacement(
                        context,
                        PageTransition(
                             type: PageTransitionType.fade,
                              child:  const MainPage(),
                              childCurrent: context.widget,
                             duration: const Duration( milliseconds: 200),
                             reverseDuration: const Duration(milliseconds: 200)
                           )
                        );
                        customSnackBar.showSuccessSnackBar(context, "شما با موفقیت وارد شدید");
             }, (r) {
               customSnackBar.showErrorSnackBar(context, r.message);
             });
            });
          }
           
       
             
        }
     
       
      },);
    
  }
  Future<void> _handleInitialUri() async {
    
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
       await getInitialUri(); 
      } 
  }
    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 255),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "ورود به سامانه",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "لطفا برای ورود به سامانه حضور وغیاب از دکمه زیر استفاده کنید",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600
                    ),
                  ),
                  
                ),
              ),
              Text(auth),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          maximumSize:
                              Size(MediaQuery.of(context).size.width - 60, 60),
                          backgroundColor: const Color(0xFF1F54D3),
                          elevation: 5,
                          animationDuration: const Duration(milliseconds: 1000),
                          
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed:isLoading? null : ()  {
                          setState(() {
                            isLoading = true;
                          });
                           getStateLoginController.getState().then((value){
                                setState(() {
                                    isLoading = false;
                                  }) ;
                                value.fold((l) async {
                                 
                                   final Uri url = Uri.parse(getUrl(l));
                                   await launchUrl(url);
                                 }, (r) {
                                 customSnackBar.showErrorSnackBar(context, r.message);
                               });
                           });
                          
                    
                      },
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        
                          children: [
                            if(isLoading) LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white,
                                size: 40,
                            ),
                            if(isLoading) const SizedBox(width: 5,),
                             Text(
                             isLoading? "لطفا صبر کنید":"ورود",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
             
              // const SizedBox(
              //   height: 40,
              // ),
              // Align(
              //     alignment: Alignment.center,
              //     child: Wrap(
              //       children: [
              //         const Text(
              //           "ثبت نام نکرده اید؟",
              //           style: TextStyle(
              //             fontSize: 20,
              //           ),
              //         ),
              //         InkWell(
              //             onTap: () {
              //               Navigator.pushReplacement(
              //                   context,
              //                   PageTransition(
              //                       type:
              //                           PageTransitionType.leftToRightJoined,
              //                       child: const SignUpPage(),
              //                       childCurrent: context.widget,
              //                       duration:
              //                           const Duration(milliseconds: 500),
              //                       reverseDuration:
              //                           const Duration(milliseconds: 500)));
              //             },
              //             child: const Text(
              //               "ثبت نام کنید.",
              //               style:
              //                   TextStyle(color: Color(0xFF1F54D3), fontSize: 18),
              //             )),
              //       ],
              //     ))
            
            ],
          ),
        ));
  }

}
   // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "ورود به سامانه",
                //       style: TextStyle(
                //           color: Color.fromARGB(255, 0, 0, 0),
                //           fontSize: 25,
                //           fontWeight: FontWeight.bold,
                         
                //           ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                
                // CustomTextFields(
                //   textInputAction: TextInputAction.next,
                //   textEditingController: textEditingControllerUserName,
                //   onChange: (p0) {
                //     setState(() {
                //       errorTextUserName = validateUserName(p0 );
                //     });
                //   },
                //   textError: errorTextUserName,
                //   lableText: "نام کاربری",
                //   hint: "لطفا نام کاربری خود را وارد کنید",
                  
                //   greyColor: Colors.grey.shade600,
                //   prefixIcon: Icons.person_2_outlined,
                //   iconColor: const Color.fromARGB(255, 60, 60, 60),
                //   onFieldSubmitted: (v) {
                //     FocusScope.of(context).requestFocus(passwordFocusNode);
                //   },
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // CustomTextFields(
                //   textInputAction: TextInputAction.next,
                //   myFocusNode: passwordFocusNode,
                //   textEditingController: textEditingControllerPassword,
                //   onChange: (p0) {
                //     setState(() {
                //       errorTextPassword = validatePassword(p0 );
                //     });
                //   },
                //   textError: errorTextPassword,
                //   greyColor: Colors.grey.shade600,
                //   lableText: "رمز عبور",
                //   hint: "لطفا رمز عبور خود را وارد کنید",
                //   isPassword: true,
                //   prefixIcon: Icons.lock_outline,
                //   iconColor: const Color.fromARGB(255, 60, 60, 60),
                //   onFieldSubmitted: (p0) {
                //     FocusScope.of(context)
                //         .requestFocus(repeatPasswordFocusNode);
                //   },
                // ),
                
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Align(
                //       alignment: Alignment.centerRight,
                //       child: 
                //           InkWell(
                //               onTap: () {
                                
                //               },
                //               child: const Text(
                //                 "رمز عبور خود را فراموش کرده اید؟",
                //                 style:
                //                     TextStyle(color:  Color(0xFF1F54D3), fontSize: 14,fontWeight: FontWeight.bold),
                //                 )
                //               ),
                         
                //   ),
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                


                
  // String? validateUserName(String value, {bool showSnackBar = false}) {
  //   String? data;
  //   if (value.isEmpty) {
  //     data = "شماره دانشجویی نباید خالی باشد";
  //   } else {
  //     if (illegalRegex.hasMatch(value)) {
  //       data = "ورودی نامعتبر";
  //     } else if (!numberRegex.hasMatch(value)) {
  //       data = "لطفا فقط عدد را به صورت انگلیسی وارد کنید";
  //     }
  //   }
  //   if (showSnackBar && data != null) {
  //     customSnackBar.showErrorSnackBar(context, data);
  //   }
  //   return data;
  // }

  // String? validatePassword(String value, {bool showSnackBar = false}) {
  //   String? data;
  //   if (value.isEmpty) {
  //     data = "رمز عبور نباید خالی باشد";
  //   } else {
  //     if (illegalRegex.hasMatch(value)) {
  //       data = "ورودی نامعتبر";
  //     }
  //   }
  //   if (showSnackBar && data != null) {
  //     customSnackBar.showErrorSnackBar(context, data);
  //   }
  //   return data;
  // }

// String userName = textEditingControllerUserName.text;
                      // String passwordName = textEditingControllerPassword.text;
                    
                      // String? errorUserName =
                      //     validateUserName(userName, showSnackBar: true);
                      // if (errorUserName != null) {
                      //   setState(() {
                      //     errorTextUserName = errorUserName;
                      //   });
                      //   return;
                      // }
                      // String? errorPassword =
                      //     validatePassword(passwordName, showSnackBar: true);
                      // if (errorPassword != null) {
                      //   setState(() {
                      //     errorTextPassword = errorPassword;
                      //   });
                      //   return;
                      // }
                     
                      // DeviceInformation().getUniqueId().then((value){

                      //   if(value!=null){
                      //      setState(() {
                      //     isLoading = true;
                      // });
                      //     loginController.login(
                      //       LoginRequestModel(
                      //          username: int.parse(userName),
                      //          password: passwordName,
                      //          uniqcode: value
                      //       )
                      //     ).then((responce){
                      //               setState(() {
                      //                isLoading = false;
                      //               });
                      //              responce.fold(
                      //               (res) {
                      //                  Navigator.pushReplacement(
                      //                     context,
                      //                     PageTransition(
                      //                        type: PageTransitionType.fade,
                      //                        child:  const MainPage(),
                      //                        childCurrent: context.widget,
                      //                        duration: const Duration( milliseconds: 200),
                      //                        reverseDuration: const Duration(milliseconds: 200)
                      //                      )
                      //                   );
                      //                   customSnackBar.showSuccessSnackBar(context, "شما با موفقیت وارد شدید");
                      //               },
                      //               (error) {
                                      
                                      
                      //                 if(error.statusCode==401){
                      //                       Navigator.pushReplacement(
                      //                          context,
                      //                       PageTransition(
                      //                         type: PageTransitionType.fade,
                      //                         child: OTPScreen(username:userName),
                      //                         childCurrent: context.widget,
                      //                         duration: const Duration( milliseconds: 200),
                      //                         reverseDuration: const Duration(milliseconds: 200)
                                  
                      //                       )
                      //                     );
                      //                 } 
                      //                 customSnackBar.showErrorSnackBar(context, error.message); 
                      //               });
                                        
                      //     });
                      //   }
                      //   else{
                      //     customSnackBar.showSuccessSnackBar(context, "خطای دسترسی به مشخصات گوشی");
                      //   }
                      // });
                      
                     
                      // Navigator.push(
                      //           context,
                      //           PageTransition(
                      //              type: PageTransitionType.bottomToTopPop,
                      //              child:  const MyHomePage(),
                      //              childCurrent: context.widget,
                      //              duration: const Duration( milliseconds: 500),
                      //              reverseDuration: const Duration(milliseconds: 500)
                      //             )
                      //  );
                      
                      // customSnackBar.showSuccessSnackBar(context, "LOGGED IN");