
import 'package:attendance/controller/classintro_controller.dart';
import 'package:attendance/model/another_model/classdata_model.dart';
import 'package:attendance/model/another_model/geolocation.dart';
import 'package:attendance/page/student_page/class_intro_page.dart';
import 'package:attendance/page/teacher_page/class_intro.dart';
import 'package:attendance/widget/classTimeLineWidget/painters/class_timeline_painter.dart';

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:attendance/util/utill.dart';
import 'package:attendance/widget/classTimeLineWidget/painters/class_arrow_painter.dart';

class TimeLineClass extends StatefulWidget {
  final MainClassDataModel? modelClass;
  final Building building;
  final int hour ;
  final int minute ;
  final bool isStudent;


  const TimeLineClass({
    super.key,
    required this.modelClass,
    required this.building,
    required this.hour,
    required this.minute,
    required this.isStudent});

  @override
  State<TimeLineClass> createState() => _TimeLineClassState();
}

class _TimeLineClassState extends State<TimeLineClass> {
  //late Today selectedToday;
  //late Today todayToday;
  Jalali? today;
  Jalali? selectedDate;
  List<AllSortedData> dateList = [];
  
 // ClassDataModel? classDataModel;
  List<SortedClassData>? sortedClassData;
  //late List<SortedClassData> sortedClassData;
  ScrollController scrollController = ScrollController();

  double currentScroll = -1;
  bool notInit=false;
  int current=1;

 
  @override
  void initState() {
    
    MainClassDataModel? dataModel = widget.modelClass;
    if (dataModel != null) {
      String? date = dataModel.today.date;
      today = Jalali.fromDateTime(date == null ? DateTime.now() : DateTime.parse(date));
      selectedDate = today;
      generateDateList(
        1,
        9,
      );
      

      sortedClassData = dateList.firstWhere((element) => element.today == today!,orElse: (){
        selectedDate = dateList[1].today;
        return dateList.first;
      }).sortedDataClasses;
      

    }
   
    super.initState();
  }

  void generateDateList(int before, int after) {
     dateList.clear(); 
     if (today != null) {
      MainClassDataModel? mainClassDataModel =  widget.modelClass;
      if(mainClassDataModel != null) {  
        List<Classes>? classesModel = mainClassDataModel.classDataModel.classes;
        if(classesModel != null) {
            List<Jalali> classesJalaliBefore = List.generate(before+(5*current), (index) => today!-((index+1)*current));
            List<Jalali> classesJalaliAfter = List.generate(after+(5*current), (index) => today!+(index+1)*current);
            for (var element in classesJalaliBefore) {
                 if(dateList.length<before){
                   int weekDay=convertWeekDay(element.weekDay);
                   Classes? classes = ((classesModel).firstWhere((element) => (element.day??0)==weekDay,orElse: ()=>Classes(day: -1)));
                   if(((classes.day??-1)!=-1)&& (classes.classData??[]).isNotEmpty){  
                     AllSortedData allsortedData=AllSortedData(
                      sortedDataClasses:generateList(classes.classData??[]),
                      today: element

                     );
                     dateList.add(allsortedData);  
                   }  
                 }else{
                  break;
                 }
                   
            }
            int weekDay=convertWeekDay(today!.weekDay);
            Classes? classes = ((classesModel).firstWhere((element) => (element.day??0)==weekDay,orElse: ()=>Classes(day: -1)));
            if(((classes.day??-1)!=-1)&& (classes.classData??[]).isNotEmpty){  
              AllSortedData allsortedData=AllSortedData(
                      sortedDataClasses:generateList(classes.classData??[]),
                      today: today!
                     );
             dateList.add(allsortedData);   
            } 
            
            for (var element in classesJalaliAfter) {
                 if(dateList.length<after+before+1){
                   int weekDay=convertWeekDay(element.weekDay);
                   Classes? classes = ((classesModel).firstWhere((element) => (element.day??0)==weekDay,orElse: ()=>Classes(day: -1)));
                   if(((classes.day??-1)!=-1)&& (classes.classData??[]).isNotEmpty){  
                     AllSortedData allsortedData=AllSortedData(
                      sortedDataClasses:generateList(classes.classData??[]),
                      today: element

                     );
                     dateList.add(allsortedData);  
                   }  
                 }else{
                  break;
                 }
                   
            }
            
            if(dateList.length<before+after+1){
              current++;
              generateDateList(before, after);
            }
            
          //   if(dateList.length < before + after + 1){

          //    
          //    print(current);
         
          //    generateDateList(before, after);
          //  }
        }
      }
    }
  }
  List<SortedClassData> generateList(List<Class> classes){
   
    classes.sort((first,second){
      List<String> firstSplit =  (first.start??"").split(":");
      List<String> secondSplit =  (second.start??"").split(":");
      Jalali firstJalali = Jalali.now().copy(hour: int.parse(firstSplit[0]), minute:int.parse(firstSplit[1]));
      Jalali secondJalali = Jalali.now().copy(hour: int.parse(secondSplit[0]), minute:int.parse(secondSplit[1])); 
       return firstJalali.compareTo(secondJalali);
    });
    List<SortedClassData> sortedDataClasses=[];
      sortedDataClasses.add(SortedClassData(
      widgetTypes: WidgetTypes.defaultGap
    ));
    sortedDataClasses.add(SortedClassData(
        widgetTypes: WidgetTypes.timeGap,
        gapCount: 2,
      
    ));
    for (int i=0;i<classes.length-1;i++) {
               Class nextClass=classes[i+1];
               Class? currentClass=classes[i];
               Jalali endCurrentJalali = convertToJalali(currentClass.end??"");
               Jalali startNextJalali = convertToJalali(nextClass.start??"");
               int difference=startNextJalali.toDateTime().difference(endCurrentJalali.toDateTime()).inMinutes;
             
              if(sortedDataClasses.any((element) => element.classes!=currentClass)){
                sortedDataClasses.add(SortedClassData(
                widgetTypes: WidgetTypes.container,
                classes: currentClass,
                start: convertToJalali(currentClass.start??""),
                end: convertToJalali(currentClass.end??"")
                )
               );
              }

              if(difference>0){
                sortedDataClasses.add(SortedClassData(
                  widgetTypes: WidgetTypes.timeGap,
                  gapCount: (difference/30).round(),
                  start: endCurrentJalali,
                  end: startNextJalali,
                ));

                }

              else{
                sortedDataClasses.add(SortedClassData(
                  widgetTypes: WidgetTypes.defaultGap,
                ));
              }

          }
     Class endClass = classes[classes.length - 1];
     sortedDataClasses.add(SortedClassData(
        widgetTypes: WidgetTypes.container,
        classes:endClass ,
        start: convertToJalali(endClass.start??""),
        end: convertToJalali(endClass.end??"")
    ));
             sortedDataClasses.add(SortedClassData(
               widgetTypes: WidgetTypes.timeGap,
               start: convertToJalali(endClass.end??""),
               end: convertToJalali(endClass.end??"").toDateTime().add(const Duration(minutes: 60)).toJalali(),
               gapCount: 2
             ));
             sortedDataClasses.add(SortedClassData(
               widgetTypes: WidgetTypes.defaultGap
            ));
    return sortedDataClasses;
  }
  Jalali convertToJalali(String time){
    List<String> timeString = time.split(":");
    return Jalali.now().copy(hour: int.parse(timeString[0]), minute: int.parse(timeString[1]));
  }
  int convertWeekDay(int day) {
    switch (day) {
      case 7:
        return 6;
      case 6:
        return 5;
      case 5:
        return 4;
      case 4:
        return 3;
      case 3:
        return 2;
      case 2:
        return 1;
      case 1:
        return 0;
      default:
        return 0;
    }
  }
  String format1(Date d) {
    final f = d.formatter;
    return ' ${f.mN}(${f.wN})${(f.d).toPersianNumber()}';
  }

  @override
  Widget build(BuildContext context) {
  
    return 
         Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Color.fromRGBO(111, 199, 249, 0.4),
                  Color.fromRGBO(183, 226, 251, 0.3),
                  Color.fromRGBO(183, 226, 251, 0.1),
                  Color.fromRGBO(183, 226, 251, 0),
                ])),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,

            child: Stack(
              children: [

                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/3,
                    width:MediaQuery.of(context).size.width ,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 40,
                      child: ListView.builder(

                        itemCount: dateList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Jalali date = dateList[index].today;
                          bool isSelected = date == selectedDate;
                          return GestureDetector(


                            onTap: () {

                              setState(() {
                                selectedDate = date;
                                sortedClassData = dateList.firstWhere((element) => element.today == selectedDate!).sortedDataClasses;
                              });
                            },
                            child:Column(
                              children: [
                                AnimatedContainer(
                                   duration: const Duration(milliseconds: 200),
                                   margin: const EdgeInsets.symmetric(horizontal: 1),
                                   padding: EdgeInsets.symmetric(
                                   horizontal: isSelected ? 15 : 5, vertical: 5),
                                   decoration: BoxDecoration(
                                     border: Border.all(
                                     color: isSelected
                                        ? const Color(0xFF006BCE)
                                        : Colors.transparent,
                                     width: 1),
                                    borderRadius: BorderRadius.circular(20)),
                                    child: Row(
                                    children: [
                                      Text(
                                          "${date.formatter.d.toPersianNumber()}${date.formatter.mN}",
                                          style: TextStyle(
                                              color: isSelected
                                                   ? const Color(0xFF006BCE)
                                                  : Colors.black,
                                              fontSize: 20)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          today == date
                                              ? "(امروز)"
                                              : "(${date.formatter.wN})",
                                          style: TextStyle(
                                              color: isSelected
                                                  ? const Color.fromRGBO(98, 175, 246, 1)
                                                  : const Color(0xFF808080),
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Expanded(
                                  child: CustomPaint(
                                   painter: ClassArrowPainter(isSelected),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                    painter: ClassTimeLinePainter(
                      hour: widget.hour, 
                      minute: widget.minute,
                      sortedClassData: sortedClassData??[],
                      currentScroll: currentScroll,
                      widthofMobile: MediaQuery.of(context).size.width,
                      isToday: selectedDate==today
                    ),
                  )
                ) ,

                
                
                Positioned(
                  top: MediaQuery.of(context).size.height/12,
                  left: 0,

                  child:Container(

                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width-10,
                    height: MediaQuery.of(context).size.height/4.7,
                    child: NotificationListener(
                          onNotification: (t){
                          if(t is ScrollUpdateNotification){
                            setState(() {
                              currentScroll=scrollController.offset;
                            });

                          }

                          return t is ScrollUpdateNotification;
                        },
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [

                            
                            if(sortedClassData!=null)
                            ...sortedClassData!.map((e){
                            //SortedClassData sortedClassData = data.sortedDataClasses;
                            final double height=((MediaQuery.of(context).size.height/4)-20).abs();
                            if(e.widgetTypes==WidgetTypes.container){

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(vertical: 12),

                                width: 0,
                                constraints:  BoxConstraints(
                                 minWidth: 250,
                                 maxHeight:height ,
                                ),
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

                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(

                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.white,
                                                elevation: 0,
                                                animationDuration: const Duration(
                                                    milliseconds: 1000),
                                               
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20)))),
                                               onPressed:
                 (){
                    if(widget.isStudent){

                     Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return HomePage(model: e,building: widget.building,);
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return FadeTransition(
                                      opacity: animation,
                                      child: child
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 100),
                                reverseTransitionDuration: const Duration(milliseconds:100)
                              ),

                                 );
                    
                    }
                    else{
                        Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return const ClassIntroTeacher();
                              },
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return FadeTransition(
                                      opacity: animation,
                                      child: child
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 100),
                                reverseTransitionDuration: const Duration(milliseconds:100)
                              ),

                                 );
                    }
                },
                      
                                  child: Row(
                                    children:[
                                      Container(
                                         width: 5,
                                         height: 0.58*height,
                                         decoration:  BoxDecoration(
                                          color:
                                             (e.classes?.color==null)?Colors.blue:Color(int.tryParse((e.classes?.color??"").replaceAll("#", "0xFF"))??0xFFF)
                                          ,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
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
                                                    Text(
                                                   e.classes?.className??"",
                                                     maxLines: 1,
                                                     overflow: TextOverflow.ellipsis,
                                                     style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                     ),
                                                   ),
                                                   Text(

                                                     e.classes?.maestro??"",
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
            
                                                     Wrap(
                                                        direction: Axis.horizontal,
                                                       runAlignment: WrapAlignment.center,
                                                       crossAxisAlignment: WrapCrossAlignment.center,
                                                       spacing: 5,
                                                      children:[
                                                           const Icon(
                                                             Icons.access_time,
                                                             size: 12,
                                                             color: Color(0xFF858585),

                                                          ) ,
                                                          Text(

                                                            "${e.classes?.start??""} الی ${e.classes?.end??""}".toPersianNumber(),
                                                              softWrap: true,
                                                              textAlign: TextAlign.center,
                                                               style: const TextStyle(
                                                                color: Color(0xFF858585),
                                                                fontWeight: FontWeight.w500
                                                               ),
                                                          ),

                                                        ]
                                                                                                ),
                                                    
                                                    
                                                     if((e.classes?.classLocation??"")!="") Container(
                                                       padding: const EdgeInsets.symmetric(horizontal: 6),
                                                       decoration: const BoxDecoration(
                                                         color: Color(0xFF00A3FF),
                                                         borderRadius: BorderRadius.all(Radius.circular(20))
                                                       ),
                                                       child: Text(
                                                         (e.classes?.classLocation??"").toPersianNumber(),
                                                         softWrap: true,
                                                         textAlign: TextAlign.center,
                                                         style: const TextStyle(
                                                           color: Colors.white,
                                                           fontSize: 12,
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
                                                   padding: const EdgeInsets.only(left: 10),
                                                   child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                                     children: [
                                                       Text(
                                                         e.classes?.apartment??"",
                                                         maxLines: 1,
                                                         overflow: TextOverflow.ellipsis,
                                                         style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                         ),
                                                        ),
                                                        Row(
                                                          children: [
                                                             Wrap(
                                                              children: [
                                                                LimitedBox(
                                                                maxHeight: 40,
                                                                child: ListView.builder(
                                                                    scrollDirection: Axis.horizontal,
                                                                    itemCount: ((e.classes?.students?.data?.length)??0)+1,
                                                                    reverse: true,
                                                                    shrinkWrap: true,
                                                                    itemBuilder: (context, index) {
                                                                      if(index==(e.classes?.students?.data?.length)){

                                                                         return Align(
                                                                        widthFactor: 0.2,
                                                                        child: ClipOval(
                                                                        child: Container(
                                                                         decoration: const BoxDecoration(
                                                                          color: Color(0xFFECECEC),
                                                                          borderRadius: BorderRadius.all(Radius.circular(5))

                                                                        ),
                                                                        height: 15,
                                                                        width: 15,
                                                                        child :Center(
                                                                              child: Text(
                                                                                "+${e.classes?.students?.count}",
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 6,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                         )
                                                                        ),
                                                                        ),
                                                                      );
                                                                      }
                                                                      else{

                                                                         Data? data=e.classes?.students?.data?[index];
                                                                         return Align(
                                                                        widthFactor: 0.5,
                                                                        child: ClipOval(
                                                                        child: Container(
                                                                              color: Colors.white,
                                                                              child: SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                                  child : Image.asset(
                                                                                  "${e.classes?.students?.baseUrl??""}${data?.avatar??""}",
                                                                                ) //build your avatar view
                                                                              ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                      }

                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                     ],
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             ]
                                         ),
                                       ))
                                    ]
                                   ),
                                ),
                               );

                            }
                            else if(e.widgetTypes==WidgetTypes.defaultGap){
                               return const SizedBox(
                                width: 5,
                               );
                            }
                            else if(e.widgetTypes==WidgetTypes.timeGap) {
                               return SizedBox(
                                 // width: , 
                                width: ((e.gapCount??0)==1?60:20)*(e.gapCount??0).floorToDouble(),

                               );
                            }
                            else{
                              return const SizedBox();
                            }

                            }
                            )

                          ],
                        )
                      ),
                    ),
                   )
                ),



              ],
            ),
          );
  }

}


  class AllSortedData {
     List<SortedClassData> sortedDataClasses=[];
     Jalali today;
     AllSortedData({
      required this.sortedDataClasses,
      required this.today,
    });
  }
 class SortedClassData{
  final Class? classes;
  final Jalali? start;
  final Jalali? end;
  final WidgetTypes? widgetTypes;
  final int? gapCount;
  SortedClassData({this.classes,this.start,this.end, this.widgetTypes,this.gapCount});
}

  enum WidgetTypes{
    defaultGap,
    timeGap,
    container
}

