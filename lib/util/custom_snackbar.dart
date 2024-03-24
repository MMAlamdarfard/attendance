import 'package:flutter/material.dart';



class CustomSnackBar{
   void show(BuildContext context, IconData iconData, Color color, String description) {
    final snackBarController = AnimationController(
      vsync: ScaffoldMessenger.of(context),
      duration: const Duration(seconds: 2),
    )..forward();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              color: color,
                              iconData,
                              size: 35,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                description,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: snackBarController,
                      builder: (context, child) {
                        return SizedBox(
                          height: 4,
                          child: LinearProgressIndicator(
                            backgroundColor: color.withOpacity(0.1),
                            value: snackBarController.value,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            minHeight: 4,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
             
              Container(
                
                width: 10,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
              ),
           
            ],
          ),
        ),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    show(context, Icons.error, const Color(0xFFF13637),message);
  }
  

   void showWarningSnackBar(BuildContext context, String message) {
    show(context, Icons.warning, const Color(0xFFFD8E39) , message);
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    show(context, Icons.check_circle,const Color( 0xFF3DC13C),message);
  }
 
}