

import 'package:attendance/controller/auth_controller/verificatition_code_controller.dart';
import 'package:attendance/model/auth_model/verification_model/verification_request_model.dart';
import 'package:attendance/page/authentication_page.dart/login_page.dart';
import 'package:attendance/util/custom_snackbar.dart';
import 'package:attendance/util/utill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';


class OTPScreen extends StatefulWidget {
   
  final String username; 
  
  const OTPScreen({super.key, required this.username});

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> controllers = List.generate(5, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
  VerificationCodeController verificationCodeController =VerificationCodeController();
  bool isLoading = false;
  CustomSnackBar customSnackBar = CustomSnackBar();
  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
   @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown  
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    "assets/image/otp_verification.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width-100,
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
                      "ورود کد یک بار مصرف",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                         
                          ),
                    ),
                  ),
                ),
             Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "ما کدی به شماره ثبت شده شما در سامانه دانشگاه ارسال کردیم لطفا آن را وارد کنید",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade600
                ),
              ),
            ),
            Form(
              child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    5,
                    (index) => SizedBox(
                      width: 50.0,
                      child: TextFormField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 4) {
                               focusNodes[index+1].requestFocus();
                            //FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                          }
                          else if(value.isEmpty && index > 0){
                            focusNodes[index-1].requestFocus();
                            //FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                          }
                          // You can perform validation or other actions here
                        },
                        decoration: const InputDecoration(
                          counter: Offstage(),
                          border:  OutlineInputBorder(
              
                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
                         ),
                         focusedBorder:   OutlineInputBorder(
                          
                               borderSide: BorderSide(color: Color(0xFF1F54D3),width: 1.5)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        maximumSize:Size(MediaQuery.of(context).size.width - 60, 60),
                        backgroundColor: const Color(0xFF1F54D3),
                        elevation: 5,
                        animationDuration: const Duration(milliseconds: 1000),
                       
                        shape: const RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(10)))),
                        onPressed: isLoading?null :() {
                           String otp = '';
                           for (var controller in controllers) {
                               otp += controller.text;
                           }
                           if(otp.length!=5){
                             customSnackBar.showErrorSnackBar(context, "لطفا کد را به صورت صحیح وارد کنید");
                             return;
                           }
                           DeviceInformation().getUniqueId().then((value){
                             if(value!=null){
                                 setState(() {
                                   isLoading = true ;
                                 });
                                 verificationCodeController.verifyCode(
                                   VerificationCodeRequestModel(
                                      username:int.parse(widget.username),
                                      verifycode: otp,
                                      uniqcode: value 
                                   )
                                ).then((responce){
                                  setState(() {
                                    isLoading =false;
                                  });
                                  
                                   responce.fold(
                                    (res) {
                                       
                                       Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                             type: PageTransitionType.fade,
                                             child:  const LoginPage(),
                                             childCurrent: context.widget,
                                             duration: const Duration( milliseconds: 200),
                                             reverseDuration: const Duration(milliseconds: 200)
                                           )
                                        );
                                        customSnackBar.showSuccessSnackBar(context, "هویت شما تایید شد لطفا وارد شوید");
                                    },
                                    (error) {
                                      customSnackBar.showErrorSnackBar(context, error.message);
                                      
                                    });
                                
                                });
                             }else{
                              customSnackBar.showSuccessSnackBar(context, "خطای دسترسی به مشخصات گوشی");
                             }
                           });
                          
                          //  CustomSnackBar().showSuccessSnackBar(context, otp);
                          //  Navigator.pushReplacement(
                          //       context,
                          //       PageTransition(
                          //          type: PageTransitionType.leftToRightJoined,
                          //          child:  const LoginPage(),
                          //          childCurrent: context.widget,
                          //          duration: const Duration( milliseconds: 200),
                          //          reverseDuration: const Duration(milliseconds: 200)
                          //         )
                          //       );
                   
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
                           isLoading? "لطفا صبر کنید":"تایید",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    )),
            
          ],
        ),
      ),
    );
  }
  
  

}
