
import 'package:flutter/material.dart';


import 'package:attendance/widget/classTimeLineWidget/painters/class_arrow_painter.dart';

class TimeLineClassLoading extends StatelessWidget {
  
  
  const TimeLineClassLoading(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 40,
                      child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              AnimatedContainer(
                                height: 40,
                                width: 100,
                                duration: const Duration(milliseconds: 200),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: CustomPaint(
                                  painter: ClassArrowPainter(false),
                                ),
                              )
                            ],
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
                    child: Container(
                      height: 3,
                      color: Colors.white,
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height / 12,
                    left: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height / 4.7,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(3, (index) {
                                final double height =
                                    ((MediaQuery.of(context).size.height / 4) -
                                            20)
                                        .abs();
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  width: 0,
                                  constraints: BoxConstraints(
                                    minWidth: 250,
                                    maxHeight: height,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              }),
                            ],
                          )),
                    )),
              ],
            ),
          );
       
  }
}


