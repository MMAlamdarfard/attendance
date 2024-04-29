import 'package:attendance/model/another_model/geolocation.dart';
import 'package:attendance/page/student_page/map_page.dart';
import 'package:attendance/util/utill.dart';
import 'package:attendance/widget/classTimeLineWidget/class_timeline.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';



class HomePage extends StatefulWidget {
  final SortedClassData? model;
  final Building building;
  const HomePage({super.key, required this.model, required this.building});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController mainScrollView = ScrollController();
  double scrollOffset = 0;
  double maxScrollOffset = 0;
  void mainScrollListener() {
    final offset = mainScrollView.offset;
    final maxScroll = mainScrollView.position.maxScrollExtent;
    if (offset < (maxScroll * 0.7)) {
      setState(() {
        scrollOffset = offset;
        maxScrollOffset = maxScroll;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mainScrollView.addListener(mainScrollListener);
  }
 String buildClassName(){
  if(widget.model!=null){
    if(widget.model!.classes!=null){
      return widget.model!.classes!.className??"نامشخص";
    }
    
  }
  return "نامشخص";
 }
 String buildTeacherName(){
  if(widget.model!=null){
    if(widget.model!.classes!=null){
      return widget.model!.classes!.maestro??"نامشخص";
    }
    
  }
  return "نامشخص";
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: NestedScrollView(
                controller: mainScrollView,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      stretch: true,
                      elevation: 10,
                      collapsedHeight: 90,
                      expandedHeight: 264,
                      floating: false,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/image/class_intro.png'))),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 10,
                              left: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 10,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.black.withOpacity(0.4)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return FlexibleSpaceBar(
                                    titlePadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20 +
                                            (maxScrollOffset != 0
                                                ? ((scrollOffset /
                                                        maxScrollOffset) *
                                                    50)
                                                : 0),
                                        bottom: 45),
                                    //titlePadding: EdgeInsets.only(right: 20,bottom:innerBoxIsScrolled? 0:35),
                                    title: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                         Text(
                                         buildClassName(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                             buildTeacherName(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white
                                                      .withOpacity(0.8)),
                                            ),
                                            Text(
                                              '(گروه 1)'.toPersianNumber(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    background: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: Image.asset(
                                            'assets/image/class_intro.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                end: Alignment.topCenter,
                                                begin: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: -5,
                              child: Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ))),
                            ),
                            Positioned(
                                left: 10,
                                right: 10,
                                top: 23,
                                child: SizedBox(
                                  height: 75,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.arrow_back_sharp,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                         Navigator.of(context).pop();
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/svg/lesson.png',
                            width: 30, // Adjust the width as needed
                            height: 30, // Adjust the height as needed
                          ),
                          const Text(
                            "شرح درس",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "_${buildClassName()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
        
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text(
                    //     "شرکت کنندگان:",
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 20),
                    //   ),
                    // ),
        
                    // const SizedBox(
                    //   height: 10,
                    // ),
        
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 10),
                    //   child: SizedBox(
                    //       height: 130,
                    //       child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 20,
                    //           itemBuilder: (context, index) {
                    //             return SizedBox(
                    //               width: 85,
                    //               child: IntrinsicHeight(
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.stretch,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     Image.asset(
                    //                       'assets/svg/profile.png',
                    //                       width:
                    //                           75, // Adjust the width as needed
                    //                       height:
                    //                           75, // Adjust the height as needed
                    //                     ),
                    //                     const Expanded(
                    //                       child: Text(
                    //                         "محمد مهدی علمدارفرد",
                    //                         maxLines: 5,
                    //                         overflow: TextOverflow.ellipsis,
                    //                         textAlign: TextAlign.center,
                    //                         style: TextStyle(
                    //                             fontSize: 12,
                    //                             color: Colors.black,
                    //                             fontWeight: FontWeight.w500),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //           })),
                    // ),
        
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          const Text(
                            "جزئیات:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            "(یک غیبت در دوجلسه برای شما ثبت شده)",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
        
                    const SizedBox(
                      height: 10,
                    ),
        
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 75,
                                width: 10,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Color(0xFF0500FF)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/svg/session.png',
                                            width:
                                                30, // Adjust the width as needed
                                            height:
                                                30, // Adjust the height as needed
                                          ),
                                          const Text("جلسه اول هفته",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                              "یک شنبه ساعت 8"
                                                  .toPersianNumber(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              )))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 75,
                                width: 10,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Color(0xFF159500)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/svg/session.png',
                                            width:
                                                30, // Adjust the width as needed
                                            height:
                                                30, // Adjust the height as needed
                                          ),
                                          const Text("جلسه دوم هفته",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                              "سه شنبه ساعت 8"
                                                  .toPersianNumber(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              )))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 75,
                                width: 10,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Color(0xFFFF0000)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/svg/bachelor.png',
                                            width:
                                                30, // Adjust the width as needed
                                            height:
                                                30, // Adjust the height as needed
                                          ),
                                          const Text("مقطع",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text("کارشناسی",
                                              style: TextStyle(
                                                fontSize: 14,
                                              )
                                           )
                                        )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 75,
                                width: 10,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Colors.amber),
                              ),
                                Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/svg/exam.png',
                                            width:
                                                30, // Adjust the width as needed
                                            height:
                                                30, // Adjust the height as needed
                                          ),
                                          const Text("امتحان روز",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                       Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text("سه شنبه ساعت 8 در تاریخ 1403/11/03".toPersianNumber(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              )
                                           )
                                        )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    const SizedBox(height: 20,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "کلاس های برگذارشده:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ), 
                    
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                          height: 180,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                
                     
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                          width: 180.0*1.4,
                          
                          decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow:const [
                               BoxShadow(
                                color: Color.fromRGBO(0, 0, 0,0.15),
                                offset: Offset(1, 1),
                                blurRadius: 4
                                
                              )
                            ]
                          ),
                          child: Row(
                            children:[
                              Container(
                                 width: 5,
                                 height: 100,  
                                 decoration:  const BoxDecoration( 
                                  color:
                                     Colors.blue
                                  ,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                                 ),
                              ),
                              Expanded(
                                 child: Padding(
                                   padding:  const EdgeInsets.only(top: 20,bottom: 5, left:10,right: 12),
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                          Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                  Image.asset(
                                                  'assets/svg/session.png',
                                                  width: 20, // Adjust the width as needed
                                                  height: 20, // Adjust the height as needed
                                                 ),
                                                const Text(
                                                "سیستم های کنترل مدرن",
                                                 maxLines: 1,
                                                 overflow: TextOverflow.ellipsis,
                                                 style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                 ),
                                                                                           ),
                                              ],
                                            ),
                                           Text(                                                    
                                            "جلسه اول در تاریخ 1402/7/12 برگذار شد".toPersianNumber(),
                                             maxLines: 1,
                                             overflow: TextOverflow.ellipsis,
                                             style: const TextStyle(
                                              color: Color(0xFF6D6D6D),
                                              fontSize: 12,                      
                                             ),
                                            ),
                                          ],
                                         ),
                                         const SizedBox(height: 7,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text(                                                                
                                               "جلسه ${index+1} از 20".toPersianNumber(),
                                                 softWrap: true,
                                                 textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                   color: Color(0xFF858585),
                                                   fontWeight: FontWeight.w500
                                                  ),
                                             ),
                                            Container(
                                               padding: const EdgeInsets.symmetric(horizontal: 8),
                                               decoration:  BoxDecoration(
                                                 color: index%2==0?Colors.red :const Color(0xFF00A3FF),
                                                 borderRadius: const BorderRadius.all(Radius.circular(20))
                                               ),
                                               child:  Text(
                                                 index%2==0?"غیبت":"حاضر",
                                                 softWrap: true,
                                                 textAlign: TextAlign.center,
                                                 style: const TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w800,
                                                 ),
                                               ),
                                             )
                                           ],
                                         ), 
                                         const SizedBox(height: 5,),
                                         Container(
                                            height: 2,
                                            //width: double.infinity,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFECECEC)              
                                            ),             
                                          ),
                                          Padding(
                                           padding: const EdgeInsets.only(top: 10,left: 10),
                                           child: Row(
                                           mainAxisAlignment: MainAxisAlignment.start ,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               Text(                                       
                                                 "ساختمان ساتر کلاس 21".toPersianNumber(),
                                                 maxLines: 1,
                                                 overflow: TextOverflow.ellipsis,
                                                 style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                 ),
                                          ),                                                  
                                         ],
                                       ),
                                     ),
                                     ]
                                 ),
                               )
                              )
                          
                          
                            ]
                           ),
                         );
                     
                     
                               
                              })),
                    ),
                 
              
        
                    const SizedBox(height: 75,)
                  ],
                )),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          stops: const [
                        0,
                        0.7,
                        0.9,
                        1
                      ],
                          colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.8),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.05)
                      ])),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F54D3),
                            elevation: 5,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTopJoined, child:  MapPage(model:widget.model??SortedClassData(),building: widget.building,), childCurrent: context.widget));
                        },
                        child: const Text(
                          "ثبت حضور",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  ),
                )),
          ],
        ));
  }
}
// class SecondPageRoute extends PageRouteBuilder {
//   SecondPageRoute() : super(pageBuilder: (BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) => SecondPage());

//   // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return SlideTransition(
//       position: Tween<Offset>(begin: Offset(0, 1), end: Offset(.0, .0))
//           .animate(controller),
//       child: SecondPage(),
//     );
//   }
// }