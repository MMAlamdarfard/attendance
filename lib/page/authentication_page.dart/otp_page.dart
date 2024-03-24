import 'package:flutter/material.dart';


class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> controllers = List.generate(5, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
  final FocusNode firstFocusNode = FocusNode();
  @override
  void initState() {
    
    super.initState();
    //  for (var i = 0; i < 4; i++) {
    //   controllers[i].addListener(() {
    //     print(i);
    //     if (controllers[i].text.isEmpty && i > 0) {
    //       FocusScope.of(context).requestFocus(focusNodes[i +1]);
    //     }
    //   });
    // }
  }
  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                          FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                        }
                        else if(value.isEmpty && index > 0){
                          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // String otp = '';
                // for (var controller in controllers) {
                //   otp += controller.text;
                // }
                //print('Entered OTP: $otp');
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
