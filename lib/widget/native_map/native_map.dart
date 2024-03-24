


import 'package:attendance/page/student_page/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';


class NativeMap extends StatelessWidget {
 
  final NativeMapAndroidController controller;

  const NativeMap({super.key, required this.controller});
  
  @override
   Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  const String viewType = 'NeshanCustomMap';
  // Pass parameters to the platform side.
  

  return PlatformViewLink(
    viewType: viewType,
    surfaceFactory: (context, controller) {
      return AndroidViewSurface(
        controller: controller as AndroidViewController,
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      );
    },
    onCreatePlatformView: (params) {
      
      return PlatformViewsService.initSurfaceAndroidView(
        id: params.id,
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
    
        creationParamsCodec: const StandardMessageCodec(),
        onFocus: () {
          params.onFocusChanged(true);
        },
      )
        ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
        ..create();
    },
  );
} 
}
class NativeMapAndroidController{
   final methodChannel =const MethodChannel("NeshanMapChannel");
   void goToLocation(double latitude, double longitude, double zoom){
    Map<String, Object> arguments ={};
    arguments["lon"]=longitude;
    arguments["lat"]=latitude;
    arguments["zoom"]=zoom;
    methodChannel.invokeMethod("goToLocation",arguments);
   }
   void drawPolygon(List<LatLon> data,bool isIn){
    Map<String, dynamic> arguments ={};

    arguments["isIn"]=isIn;

    arguments["position"]=List.generate(data.length,(index){
       return {'lat' :data[index].lat, 'lon' :data[index].lon};
    });
  
    methodChannel.invokeMethod("drawPolygon",arguments);
   }
 
 
}