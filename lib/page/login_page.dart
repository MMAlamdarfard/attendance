
// import 'package:attendance/controller/login_controller.dart';
// import 'package:attendance/page/student_page/dashboard_page.dart';

// import 'package:attendance/util/custom_snackbar.dart';
// import 'package:attendance/widget/text_input/text_Input.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage2 extends StatefulWidget {
//   const LoginPage2({super.key});

//   @override
//   State<LoginPage2> createState() => _LoginPage2State();
// }

// class _LoginPage2State extends State<LoginPage2>
//     with SingleTickerProviderStateMixin {
//   RegExp numberRegex = RegExp(r'^[0-9]+$');
//   RegExp illegalRegex =  RegExp(r'[<>&\"\\]');
//   bool isLoading=false;
//   //RegExp(r'^[^<>&\"\\]+$');
//   //RegExp(r'^[^<>&\'\"\\]+$');
//   //final RegExp _illegalCharsRegex =;
//   String? errorTextMasterCode;
//   String? errorTextMasterPassword;
//   String? errorTextStudentNumber;
//   String? errorTextStudentPassword;
//   TextEditingController textEditingControllerMasterPassword = TextEditingController();
//   TextEditingController textEditingControllerMasterCode = TextEditingController();
//   TextEditingController textEditingControllerStudentNumber = TextEditingController();
//   TextEditingController textEditingControllerStudentPassword = TextEditingController();
//   late TabController tabController;
//   CustomSnackBar customSnackBar =CustomSnackBar();
//   late FocusNode focusNode;
//   LoginController loginController = LoginController();
//   late SharedPreferences _prefs;
  
//   void initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//   @override
//   void initState() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     initPrefs();
//     tabController = TabController(length: 2, vsync: this);
  
//     tabController.addListener(() {
//       if(tabController.index ==0){
//         textEditingControllerMasterCode.text="";
//         textEditingControllerMasterPassword.text="";
//         errorTextMasterCode = null;
//         errorTextMasterPassword=null;
//       }
//       else if(tabController.index ==1){
//         textEditingControllerStudentNumber.text="";
//         textEditingControllerStudentPassword.text="";
//         errorTextStudentNumber =null;
//         errorTextStudentPassword=null;
//       }
//       FocusScope.of(context).unfocus();
//     });
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         statusBarBrightness: Brightness.dark,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarColor: Colors.transparent));
//     focusNode = FocusNode();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//         backgroundColor: const Color(0xFFF1F1FD),
//         body: Stack(
//           children: [
//           Positioned(
//             top: (MediaQuery.of(context).size.height/3)-60,
//             right: 0,
//             child: Opacity(
//               opacity: 0.1,
//               child: Container(
//                 height: 150,
//                 width: 150,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/image/uni2.png'),
                   
//                   )
//                 )
//               ),
//             )
//           ),
//           Positioned(
//             top: (MediaQuery.of(context).size.height*2/3)-60,
//             left:50,
//             child: Opacity(
//               opacity: 0.05,
//               child: Container(
//                 height: 150,
//                 width: 150,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/image/uni4.png'),
                   
//                   )
//                 )
//               ),
//             )
//           ),
        
      
          // Positioned(
          //   top: MediaQuery.of(context).size.width*2.5/3,
          //   left: 0,
          //   child: Opacity(
          //     opacity: 0.1,
          //     child: Container(
          //       height: 150,
          //       width: 150,
          //       decoration: const BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage('assets/image/uni1.png'),
          //           fit: BoxFit.cover,
          //         )
          //       )
          //     ),
          //   )
          // ),
          //   SizedBox(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     child: SingleChildScrollView(
          //       //physics: const BouncingScrollPhysics(),

          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           const SizedBox(height: 40),
          //           Center(
          //             child: Image.asset(
          //               "assets/image/login_ui.png",
          //               fit: BoxFit.cover,
          //               height: ((MediaQuery.of(context).size.width) * 2 / 3),
          //               width: ((MediaQuery.of(context).size.width) * 2 / 3),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 15,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 5),
          //             child: PreferredSize(
          //               preferredSize: const Size.fromHeight(40),
          //               child: Material(
          //                 color: Colors.transparent,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(
          //                     20,
          //                   ),
          //                 ),
          //                 clipBehavior: Clip.antiAlias,
          //                 child: TabBar(
          //                   unselectedLabelColor: Colors.grey.shade500,
          //                   labelColor: const Color(0xFF1F54D3),
          //                   controller: tabController,
          //                   indicatorColor: const Color(0xFF1F54D3),
          //                   tabs: [
          //                     Tab(
          //                       child: Container(
          //                         width: MediaQuery.of(context).size.width / 2,
          //                         alignment: Alignment.center,
          //                         child: const Text(
          //                           "ورود دانشجو",
          //                           style: TextStyle(fontSize: 16),
          //                         ),
          //                       ),
          //                     ),
          //                     Tab(
          //                       child: Container(
          //                         width: MediaQuery.of(context).size.width / 2,
          //                         alignment: Alignment.center,
          //                         child: const Text(
          //                           "ورود استاد",
          //                           style: TextStyle(fontSize: 16),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width,
          //             height: MediaQuery.of(context).size.height -
          //                 ((MediaQuery.of(context).size.width) * 2 / 3) -
          //                 100,
          //             child: TabBarView(
          //               controller: tabController,
          //               physics: const NeverScrollableScrollPhysics(),
          //               children: [
          //                 Column(
          //                   children: [
          //                     const SizedBox(
          //                       height: 30,
          //                     ),
          //                     const Align(
          //                       alignment: Alignment.centerRight,
          //                       child: Padding(
          //                         padding: EdgeInsets.symmetric(horizontal: 20),
          //                         child: Text(
          //                           "ورود دانشجو به سامانه",
          //                           style: TextStyle(
          //                               fontSize: 24,
          //                               color: Colors.black,
          //                               fontWeight: FontWeight.bold
          //                               //fontStyle: FontStyle.italic
          //                               ),
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: 20,
          //                     ),
          //                     Form(
          //                         child: Column(
          //                       children: [
          //                         CustomTextFields(
          //                           textInputAction: TextInputAction.next,
          //                           textEditingController:
          //                               textEditingControllerStudentNumber,
          //                           onChange: (p0){
          //                             setState(() {
          //                                errorTextStudentNumber = validateStudentNumber(p0??"");
          //                             });  
          //                           }, 
          //                           textError: errorTextStudentNumber,  
          //                           lableText: "شماره دانشجویی",
          //                           hint:
          //                               "لطفا شماره دانشجویی خود را وارد کنید",
                                  
          //                           greyColor: Colors.grey.shade600,
          //                           prefixIcon: Icon(
          //                             Icons.person_2_outlined,
          //                             color: Colors.grey.shade600,
          //                           ),
          //                           onFieldSubmitted: (v) {
          //                             FocusScope.of(context)
          //                                 .requestFocus(focusNode);
          //                           },
          //                         ),
          //                        const SizedBox(
          //                           height: 15,
          //                         ),
          //                         CustomTextFields(
          //                           myFocusNode: focusNode,
          //                           textEditingController:
          //                               textEditingControllerStudentPassword,
          //                           greyColor: Colors.grey.shade600,
          //                           onChange: (p0) {
          //                             setState(() {
          //                                errorTextStudentPassword = validateStudentAndMasterPassword(p0??"");
          //                             });
                                     
          //                           },
          //                           textError: errorTextStudentPassword,
          //                           lableText: "رمز عبور",
          //                           hint: "لطفا رمز عبور خود را وارد کنید",
          //                           isPassword: true,
          //                           prefixIcon: Icon(
          //                             Icons.lock_outline,
          //                             color: Colors.grey.shade600,
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           height: 50,
          //                         ),
          //                         ElevatedButton(
                                    
          //                             style: ElevatedButton.styleFrom(
          //                               disabledBackgroundColor: const Color(0xFF1F54D3).withOpacity(0.8),
          //                                 minimumSize: Size(
          //                                     MediaQuery.of(context)
          //                                             .size
          //                                             .width -
          //                                         30,
          //                                     50),
          //                                 backgroundColor:
          //                                     const Color(0xFF1F54D3),
          //                                 elevation: 5,
          //                                 animationDuration: const Duration(
          //                                     milliseconds: 1000),
          //                                 overlayColor: Colors.white,
          //                                 shape: const RoundedRectangleBorder(
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(5)))),
          //                             onPressed:isLoading? null:
                                     
          //                              () async {
          //                                errorTextStudentNumber =validateStudentNumber(textEditingControllerStudentNumber.text);
          //                                errorTextStudentPassword = validateStudentAndMasterPassword(textEditingControllerStudentPassword.text);
          //                                if(errorTextStudentNumber== null && errorTextStudentPassword == null){
          //                                  setState(() {
          //                                     isLoading=true; 
          //                                  });
                                           
          //                                 LoginModel? loginModel=  await  loginController.login(RequestModel(
          //                                     username:textEditingControllerStudentNumber.text,
          //                                     password:textEditingControllerStudentPassword.text,
          //                                     uniqid: "student",
          //                                    )
          //                                  );
          //                                   setState(() {
          //                                     isLoading=false; 
          //                                  });
          //                                  if(loginModel!=  null){
          //                                    await _prefs.setString('loginModel', loginModel.model.data??"");
          //                                    // customSnackBar.showErrorSnackBar(context, _prefs.getString('loginModel')??"null");
          //                                     Navigator.of(context).pushReplacement(
          //                                     PageRouteBuilder(
          //                                        pageBuilder: (context, animation, secondaryAnimation) {
          //                                          return const MyHomePage();
          //                                        },
          //                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //                                          var begin = const Offset(1.0, 0.0);
          //                                          var end = Offset.zero;
          //                                          var curve = Curves.ease;
          //                                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          //                                          var offsetAnimation = animation.drive(tween);
          //                                          return SlideTransition(
          //                                            position: offsetAnimation,
          //                                            child: child,
          //                                          );
          //                                        },
          //                                        transitionDuration: const Duration(milliseconds: 200),
          //                                      ),
          //                                    );                                    
          //                                 }
          //                                 else{
          //                                    customSnackBar.showErrorSnackBar(context, "خطایی رخ داده است");
                                            
          //                                 }
                                          
          //                                }
          //                                else{
          //                                   setState(() {
          //                                     errorTextStudentNumber;
          //                                     errorTextStudentPassword;
          //                                   });
          //                                   customSnackBar.showErrorSnackBar(context, "لطفا تمام ورودی ها را به طور کامل پرکنید");
                                            
          //                                }
                                         
          //                             },
                                     
          //                             child: Wrap(
          //                               crossAxisAlignment: WrapCrossAlignment.center,
          //                               alignment: WrapAlignment.center,
          //                               runAlignment: WrapAlignment.center,
          //                               children: [
          //                                 if(isLoading) Lottie.asset(
          //                                   "assets/lottie/loading.json",
          //                                   repeat: true,
          //                                   width: 50,
          //                                   height: 50,
          //                                   fit: BoxFit.cover
          //                                 ),
          //                                 const Text(
          //                                   "ورود به عنوان دانشجو",
          //                                   textAlign: TextAlign.center,
          //                                   style: TextStyle(
          //                                       color: Colors.white,
                                                
          //                                       fontWeight: FontWeight.bold,
          //                                       fontSize: 18),
          //                                 ),
          //                               ],
          //                             )),
          //                       ],
          //                     ))
          //                   ],
          //                 ),
          //                 Column(
          //                   children: [
          //                     const SizedBox(
          //                       height: 30,
          //                     ),
          //                     const Align(
          //                       alignment: Alignment.centerRight,
          //                       child: Padding(
          //                         padding: EdgeInsets.symmetric(horizontal: 20),
          //                         child: Text(
          //                           "ورود استاد به سامانه",
          //                           style: TextStyle(
          //                               fontSize: 24,
          //                               color: Colors.black,
          //                               fontWeight: FontWeight.bold
          //                               //fontStyle: FontStyle.italic
          //                               ),
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: 20,
          //                     ),
          //                     Form(
          //                         child: Column(
          //                       children: [
          //                         CustomTextFields(
          //                           textInputAction: TextInputAction.next,
          //                           textEditingController:
          //                               textEditingControllerMasterCode,
          //                           onChange: (p0){
          //                             setState(() {
                                       
          //                              errorTextMasterCode = validateMasterCode(p0??"");
                                    
          //                             });
          //                           },  
          //                           textError: errorTextMasterCode,  
          //                           lableText: "کد استخدامی",
          //                           hint:
          //                               "لطفا کد استخدامی خود را وارد کنید",
          //                           greyColor: Colors.grey.shade600,
          //                           prefixIcon: Icon(
          //                             Icons.person_2_outlined,
          //                             color: Colors.grey.shade600,
          //                           ),
          //                           onFieldSubmitted: (v) {
          //                             FocusScope.of(context)
          //                                 .requestFocus(focusNode);
          //                           },
          //                         ),
          //                         const SizedBox(
          //                           height: 15,
          //                         ),
          //                         CustomTextFields(
          //                           myFocusNode: focusNode,
          //                           textEditingController:
          //                               textEditingControllerMasterPassword,
          //                           onChange: (p0){
          //                            setState(() {
          //                              errorTextMasterPassword = validateStudentAndMasterPassword(p0??"");
          //                            });
          //                           },
          //                           textError: errorTextMasterPassword,   
          //                           greyColor: Colors.grey.shade600,
          //                           lableText: "رمز عبور",
          //                           hint: "لطفا رمز عبور خود را وارد کنید",
          //                           isPassword: true,
          //                           prefixIcon: Icon(
          //                             Icons.lock_outline,
          //                             color: Colors.grey.shade600,
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           height: 50,
          //                         ),
          //                         ElevatedButton(
          //                             style: ElevatedButton.styleFrom(
          //                                 minimumSize: Size(
          //                                     MediaQuery.of(context)
          //                                             .size
          //                                             .width -
          //                                         30,
          //                                     50),
          //                                 backgroundColor:
          //                                     const Color(0xFF1F54D3),
          //                                 elevation: 5,
          //                                 animationDuration: const Duration(
          //                                     milliseconds: 1000),
          //                                 overlayColor: Colors.white,
          //                                 shape: const RoundedRectangleBorder(
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(5)))),
          //                             onPressed: () {},
          //                             child:  Text(
          //                               isLoading?"لطفا منتظر بمانید.": "ورود به عنوان استاد",
          //                               style: const TextStyle(
          //                                   color: Colors.white,
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 18),
          //                             )),
          //                       ],
          //                     ))
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
         
         
//           ],
//         )
//       );
  
//   }
  
//   String? validateStudentNumber(String value){
     
//        if(value.isEmpty){
//           return "شماره دانشجویی نباید خالی باشد" ; 
//         }
//         else{
//           if(illegalRegex.hasMatch(value)){
//              return "ورودی نامعتبر";
//           }
//           else if(!numberRegex.hasMatch(value)){
//             return "لطفا فقط عدد وارد کنید";   
//           }
//         }
//         return null;
//   }
  
//   String? validateMasterCode(String value){
     
//        if(value.isEmpty){
//           return " کد استخدامی نباید خالی باشد" ; 
//         }
//         else{
//           if(illegalRegex.hasMatch(value)){
//              return "ورودی نامعتبر";
//           }
//           else if(!numberRegex.hasMatch(value)){
//             return "لطفا فقط عدد وارد کنید";   
//           }
//         }
//         return null;
//   }
  
//   String? validateStudentAndMasterPassword(String value){
     
//        if(value.isEmpty){
//           return "رمز عبور نباید خالی باشد" ; 
//         }
//         else{
//           if(illegalRegex.hasMatch(value)){
//              return "ورودی نامعتبر";
//           } 
//         }
//         return null;
//   }
  
 
// }
