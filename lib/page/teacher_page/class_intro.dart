import 'package:attendance/util/utill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ClassIntroTeacher extends StatefulWidget {
  const ClassIntroTeacher({super.key});

  @override
  State<ClassIntroTeacher> createState() => _ClassIntroTeacherState();
}
class _ClassIntroTeacherState extends State<ClassIntroTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: const LinearGradient(
                    colors: [Color(0xff00A3FF),Color(0xff0042C2)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                 boxShadow: [
                   BoxShadow(
                     color: const Color(0xff000000).withOpacity(0.2),
                     spreadRadius: 5,
                     blurRadius: 7,
                     offset: const Offset(0, 3), // changes position of shadow
                   ),
                 ]
                ),
                child:  Column(
                    
                  children: [
                      const Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                                padding: EdgeInsets.only(top:30,right: 15),
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )
                          ],
                          )
                      ),
                      Container(
                       
                        width: MediaQuery.of(context).size.width-20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                          
                        ),
                        height: 150,

                        margin: const EdgeInsets.all(10),
                          child:  Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                             children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "اتوماسیون صنعتی",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        "دانشکده برق و کامپیوتر",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                         
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffCE0327),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "ساختمان ساتر کلاس 14".toPersianNumber(),
                                           style: const TextStyle(
                                             color: Colors.white,
                                             fontSize: 12,
                                          ),
                                        ),
                                      ),
                                     
                                    ],
                                  ), 
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  "جلسه اول هفته",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(
                                                  "یک شنبه ساعت 12:30 الی 14:00".toPersianNumber(),
                                                   style: TextStyle(
                                                     color: Colors.grey.shade600,
                                                     fontSize: 12,
                                    
                                                    ),
                                                )
                                              ],
                                            ),
                                             Column(
                                              children: [
                                                 const Text(
                                                  "جلسه دوم هفته",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(
                                                  "سه شنبه  ساعت 14:00 الی 16:00".toPersianNumber(),
                                                   style: TextStyle(
                                                     color: Colors.grey.shade600,
                                                     fontSize: 12,
                                    
                                             ),
                                           )
                                          ],
                                       ),
                                      ],
                                    ),
                                  )
                                
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                 ),
                               ),
                               const SizedBox(height: 5,),
                               const Row(
                                children: [
                                   Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("جلسه بیستم در حال برگذاری است")
                                  ),

                                ],
                               )
                            
                             ],
                            ),
                          ),
                      ) 
                  ],
                ),
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
               
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                    
                      Container(
                         height: 75,
                         width: 75,
                         decoration: BoxDecoration(
                           gradient: const LinearGradient(
                            colors: [Color(0xffFF0000),Color(0xff690000)],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff000000).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 2), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)
                         ),
                         child: Center(
                           child: SvgPicture.asset(
                            'assets/svg/manage_class.svg',
                            width: 40,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                           ),
                         ),
                      ),
                     
                      const Text(
                            "تنظیمات کلاس",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              
                            ),
                            )
                    ],
                  )
                ),
                    
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                    
                      Container(
                         height: 75,
                         width: 75,
                         decoration: BoxDecoration(
                           gradient: const LinearGradient(
                            colors: [Color(0xff006BCE),Color(0xff002D62)],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff000000).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 2), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)
                         ),
                         child: Center(
                           child: SvgPicture.asset(
                            'assets/svg/school.svg',
                            width: 40,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                           ),
                         ),
                      ),
                     
                      const Text(
                            "کلاس جبرانی",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              
                            ),
                            )
                    ],
                  )
                ),
             
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                    
                      Container(
                         height: 75,
                         width: 75,
                         decoration: BoxDecoration(
                           gradient: const LinearGradient(
                            colors: [Color(0xffA500C0),Color(0xff590056)],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff000000).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 2), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)
                         ),
                         child: Center(
                           child: SvgPicture.asset(
                            'assets/svg/quiz.svg',
                            width: 40,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                           ),
                         ),
                      ),
                     
                      const Text(
                            "امتحان",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                             
                            ),
                            )
                    ],
                  )
                ),
                
              
             
              ],
            )
          ],
        ),
      )
    );
  }
}