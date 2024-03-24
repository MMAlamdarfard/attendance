import 'package:attendance/controller/classintro_controller.dart';
import 'package:attendance/model/activity_model.dart';
import 'package:attendance/model/classdata_model.dart';
import 'package:attendance/model/geolocation.dart';
import 'package:attendance/model/news_model.dart';
import 'package:attendance/util/custom_snackbar.dart';
import 'package:attendance/util/utill.dart';
import 'package:attendance/widget/circular_progressbarWidget/circular_progressbar.dart';
import 'package:attendance/widget/classTimeLineWidget/class_timeline.dart';
import 'package:attendance/widget/classTimeLineWidget/class_timeline_loading.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  final String? map;
  const MyHomePage({super.key,this.map});
 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin  {
  
  
  Activity? activity;
  News? news;
  bool isLoading=false;
  late AnimationController _controller;
  ClassDataController classDataController = ClassDataController();
  MainClassDataModel? classDataModel;
    
  void initializeClassData() async{
    setState(() {
     
      news = null;
      activity = null;
      classDataModel=null; 
      isLoading=true;
    });
   
   classDataModel = await classDataController.prepareMainClassDataModel();
    
   if(classDataModel == null){
     setState(() {
    
      news = null;
      activity = null;
      classDataModel=null; 

      isLoading=true;
    });
   }
   else{
     ReadJsonFile.readJsonData(path: "assets/server_data/activity.json").then((activityData){
       ReadJsonFile.readJsonData(path: "assets/server_data/news.json").then((newsData){
      
      setState(() { 

  
          news = News.fromJson(newsData);
          activity = Activity.fromJson(activityData);
          classDataModel=classDataModel;
          isLoading=false; 
          _controller.forward();
         
      });
      
    });
    });
   
   }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argument = ModalRoute.of(context)?.settings.arguments;
    if (argument!= null) {
      Map? pushArgument = argument as Map;
      CustomSnackBar().showSuccessSnackBar(context, (pushArgument["message"]).toString());
      
    }
  }

  @override
  void initState() {
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
          
      )
    );
     _controller = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds:500),
            animationBehavior: AnimationBehavior.normal,
           );
    initializeClassData();
   
   
     
    
    
     
   
   
   
   
   
    
    
    
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       bottomNavigationBar:  Container(
       decoration: const BoxDecoration(
          color: Colors.white,
         boxShadow:[

                     BoxShadow(
                       color: Color.fromRGBO(0, 0, 0,0.15),
                       offset: Offset(1, 1),
                       blurRadius: 4               
                     )
                   ]
        ), 
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.settings_outlined),
            Transform.translate(
              offset:const Offset(0, -30),
              child: Transform.rotate( 
                angle: -math.pi / 4,
                child: Container(
                   width: 55,
                   height:55,
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0,0),
                   
                      )
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                             Color.fromARGB(255, 12, 121, 211),
                             Color.fromRGBO(2, 183, 255, 1),     
                       ]
                     )
                   ),
                   child: Transform.rotate(
                    angle: math.pi / 4,
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                    )
                    ),
                ),
              ),
            ),
            const Icon(Icons.person_outline),
           
          ]
        ),
       ),
       body: SafeArea(
        child:   Stack(
          children: [ 
            Positioned(
              left:0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SingleChildScrollView(  
                child:animateLoadData(),
                     
                
              ),
            ),
            Positioned(
              left:0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SingleChildScrollView(  
                child: animateMainData(),
                     
                
              ),
            ),
           
          ],
        )
        
      ),
    );
  }
  
  Widget animateLoadData(){
    return AnimatedBuilder(
      animation: _controller,
      builder: (context,child) { 
         return Opacity(
          opacity: ((1-_controller.value)>0.5)?(1-_controller.value):0.0,
           child: Shimmer.fromColors(
                 baseColor: Colors.grey.shade200,
                 highlightColor: Colors.grey.shade50,
                 child: Column(
           children: [
              ...loadingClassData()
           ],
                  ),
                 ),
         );
      }
    );
    
  }
  Widget animateMainData() {
   
    return AnimatedBuilder(
          animation: _controller,
          builder: (context,child) {
            return Opacity(
              opacity:_controller.value,
              child: Column(
                children: [
                   ...mainClassData()
                ],
              ),
            );
          }
        );
  }
  String generateName(){
    if(classDataModel!=null){
     ClassDataModel classData = classDataModel!.classDataModel;
     if(classData.name != null && classData.lastName != null){
       return "${classData.name} ${classData.lastName}";
     } 
    }
    return "ناشناس";
  }
  String generateEducation(){
    if(classDataModel!=null){
     ClassDataModel classData = classDataModel!.classDataModel;
     if(classData.field != null && classData.tendency != null && classData.studentCode !=null){
       return "${classData.field} ${classData.tendency} - ${classData.studentCode.toString().toPersianNumber()}";
     } 
    }
    return "نامعلوم";
  }
  List<Widget> mainClassData(){
    return [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          
                         "assets/image/kashanu_uni.png",
                         width: 80,
                         height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                Text(
                                  generateName(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Icon(
                                   Icons.location_on_outlined,
                                   size: 15,
                                   color: Color(0xFF989898),
                                ),
                                const SizedBox(width: 10,),
                                const Icon(
                                  
                                 Icons.wifi_outlined,
                                 size: 15,
                                color: Color(0xFF989898),
                                ),
                              ],
                            ),
                            Text(
                             generateEducation(),
                              style: const TextStyle(
                                fontSize: 14,
                               
                                color: Color(0xFF989898),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                   
                    Image.asset(
                         "assets/image/user.png",
                         width: 40,
                         height: 40,
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                       "کلاس های شما:",
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                       ),
                    ),
                    Text(
                      classDataModel==null?"": formatDate(Jalali.fromDateTime(DateTime.parse(classDataModel!.today.date??"")  )),
                      style: const TextStyle(
                         fontSize: 14,
                        
                         color: Color(0xFF838383),
                      ),
                    ),
                  ],
                )
              ), 
              const SizedBox(height: 25,),  
              if(!isLoading) TimeLineClass(
                modelClass: classDataModel,
                building: classDataModel?.classGeoLocation.building![0]??Building(),
               ),
              const SizedBox(height: 25,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       Text(
                        "فعالیت های اخیر شما"":",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                       Row(
                        children: [
                          Text(
                            "بیشتر",
                            style: TextStyle(
                               color: Color(0xFF858585),
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Color(0xFF858585),
                          )
                        ],
                      ) 
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              if(activity!=null && activity?.results!=null)
              ...List.generate(activity?.results?.length??0, (index){ 
                 ActivityResults? results= activity?.results?[index];
                 if(results!=null){
                       Color color=(results.color==null)?Colors.white:Color(int.tryParse((results.color??"").replaceAll("#", "0xFF"))??0xFFF);
                       return Container(
                         margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color:Colors.white ,
                           boxShadow:const [
                               BoxShadow(
                                color: Color.fromRGBO(0, 0, 0,0.15),
                                offset: Offset(1, 1),
                                blurRadius: 5
                                
                              )
                            ]
                         ),
                         child:  IntrinsicHeight(
                           child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Container(
                                                               
                                width: 10,
                                                          
                                 decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                  ),
                                      color:  color
                                 ),
                               
                               ),
                               Expanded(
                               
                                child:Padding(
                                  padding: const EdgeInsets.only(right: 10,left:5,top:5,bottom:5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                         
                                          Text(
                                           "${results.className}",
                                         
                                           style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800 ,
                                           ),
                                         ),
                                          Text(
                                           " (${results.totalAbbsent} غیبت از ${results.totalClass} جلسه ثبت شده) ".toPersianNumber(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      
                                      ),
                                      Text.rich(
                                       TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${results.cause}".toPersianNumber(), 
                                           
                                             style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400 ,
                                                
                                             ),
                                           ),
                                          const TextSpan(text:  "       ", ),
                                          WidgetSpan(
                                            child: Container(
                                            
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              decoration: BoxDecoration(
                                                 color:(results.isPresent??false)? const Color(0xFF00A3FF):const Color(0xFFF54747),
                                                 borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Text(
                                               (results.isPresent??false)?"حاضر":"غیبت", 
                                               style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600 ,
                                                color: Colors.white 
                                               ),
                                              ),
                                            )
                                          ) 
                                         ] 
                                       )   
                                     ),
                                    ],
                                  ),
                                ) 
                               ),
                               Center(
                                 child: Container(
                                  margin: const EdgeInsets.only(left:5,top:5,bottom: 5),
                                  height: 65,
                                  width: 65,
                                  child: CircularProgress(value: ((results.totalAbbsent??0.0)/(results.totalClass??1.0))*100, color: color),
                                                               ),
                               )
                            ],
                           ),
                         ),
                       );
                     } 
                     return const SizedBox(); 
              }),
              const SizedBox(height: 10,),
               const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       Text(
                        "اخبار دانشگاه"":",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                       Row(
                        children: [
                          Text(
                            "بیشتر",
                            style: TextStyle(
                               color: Color(0xFF858585),
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Color(0xFF858585),
                          )
                        ],
                      ) 
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              if(news!=null && news?.resultNews!=null)
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                 child: GridView.builder(
                   primary:false,
                   shrinkWrap:true,
                   physics: const NeverScrollableScrollPhysics(),
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:1/1.618
                  )
                   ,
                   itemCount: news?.resultNews?.length,
                   itemBuilder:(context,index){
                    ResultNews? newUni=news?.resultNews?[index];
                     return Container(
                       margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                       padding: const EdgeInsets.all(5), 
                       decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Colors.white,
                              boxShadow:const [
                                  BoxShadow(
                                   color: Color.fromRGBO(0, 0, 0,0.15),
                                   offset: Offset(1, 1),
                                   blurRadius: 5 
                                 )
                               ]
                            ),
                      child: Column(
                        children: [
                           Expanded(
                            flex: 6,
                            child:
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image:AssetImage(newUni?.image??""), 
                                  fit: BoxFit.cover,
                                
                            
                                )
                              ),
                          
                            ) 
                           ),
                           Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    newUni?.title??"",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    newUni?.subtitle??"",
                                    style: const TextStyle(
                                     fontSize: 12,
                                     fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            )
                           ),
                          
                        ],
                      ),      
                     );
                   }               
                 ),
               ),
               const SizedBox(height: 30,)
    ];
  }
  List<Widget> loadingClassData(){
    return [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                         Container(
                            width: 80.0,
                            height: 80.0,
                            
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                         ),
          
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 15,),
                              Container(
                                 width: MediaQuery.of(context).size.width/2,
                                 height: 20.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                               const SizedBox(height: 10,),
                               Container(
                                 width: (MediaQuery.of(context).size.width/2)-50,
                                 height: 20.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                            ],
                          ),
                        )
                      ],
                    ),
                   
                   Container(
                            width: 40.0,
                            height: 40.0,
                             decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                            ),
                         ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Container(
                                 width: 100,
                                 height: 30.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                              
                               Container(
                                 width: 100,
                                 height: 30.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                 ),
                               ),
                  ],
                )
              ), 
              const SizedBox(height: 25,),  
              const TimeLineClassLoading(),
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       Container(
                                 width: 120,
                                 height: 28.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                               const SizedBox(height: 10,),
                               Container(
                                 width: 100,
                                 height: 28.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ...List.generate(3, (index){ 
                
          
                       return Container(
                         height: 80,
                         
                         margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color:Colors.white ,
                           boxShadow:const [
                               BoxShadow(
                                color: Color.fromRGBO(0, 0, 0,0.15),
                                offset: Offset(1, 1),
                                blurRadius: 5
                                
                              )
                            ]
                         ),
                        
                       );
                     } 
                     
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                                 width: 100,
                                 height: 20.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                               const SizedBox(height: 10,),
                               Container(
                                 width: 60,
                                 height: 20.0,
                                 decoration: const BoxDecoration(
                                     color: Colors.white,
                                                            
                                 ),
                               ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
            
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                 child: GridView.builder(
                   primary:false,
                   shrinkWrap:true,
                   physics: const NeverScrollableScrollPhysics(),
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:1/1.618
                  )
                   ,
                   itemCount: 2,
                   itemBuilder:(context,index){
                   
                     return Container(
                       margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                       padding: const EdgeInsets.all(5), 
                       decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Colors.white,
                              boxShadow:const [
                                  BoxShadow(
                                   color: Color.fromRGBO(0, 0, 0,0.15),
                                   offset: Offset(1, 1),
                                   blurRadius: 5 
                                 )
                               ]
                            ),
                     
                     );
                   }               
                 ),
               ),
               const SizedBox(height: 30,)
    ];
  }
  String formatDate(Jalali d) {
  final f = d.formatter;

  return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}'.toPersianNumber();
}

  

}
