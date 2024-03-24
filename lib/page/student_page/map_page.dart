import 'dart:convert';

import 'package:attendance/model/geolocation.dart';
import 'package:attendance/util/custom_snackbar.dart';
import 'package:attendance/util/utill.dart';
import 'package:attendance/widget/classTimeLineWidget/class_timeline.dart';
import 'package:attendance/widget/native_map/native_map.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MapPage extends StatefulWidget {
  final SortedClassData model;
  final Building building;
  const MapPage({super.key, required this.model, required this.building});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final NativeMapAndroidController _controller = NativeMapAndroidController();
  final GeolocatorPlatform _platform = GeolocatorPlatform.instance;
  bool isIn = false;
  List<LatLon> positions = [];
  double heading = 0;
  Position? position;
  int hitButton = 0;
  CustomSnackBar customSnackBar = CustomSnackBar();
  LocationType locationType = LocationType.noPermission;
  WifiType wifiType = WifiType.noPermissionGPS;
  late AnimationController animatinController;
  late Animation<double> animation;
  final NetworkInfo info = NetworkInfo();
  bool isGPS = true;
  bool isNetwork = false;
  String currentBssid="";
  Future<void> gotoLocation() async {
    Position? position = await _platform.getLastKnownPosition();
    if (position != null) {
      _controller.goToLocation(position.latitude, position.longitude, 15.0);
    }
  }

  void checkFirstDataGPS() async {
    LocationPermission permission = await _platform.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        locationType = LocationType.noPermission;
      });
    } else {
      if (await _platform.isLocationServiceEnabled()) {
        setState(() {
          locationType = LocationType.gpsSet;
          checkingLocation(fromGPS: true);
        });
      } else {
        setState(() {
          locationType = LocationType.noGPS;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    animatinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: animatinController, curve: Curves.decelerate);
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);
    currentBssid=(widget.building.bssidWifi??[]).isEmpty?"":widget.building.bssidWifi?[0]??"";
    String data = widget.building.jsonData ?? "";
    dynamic jsonData = jsonDecode(data);
   
    for (var element in jsonData[0]) {
      positions.add(LatLon(lat: element["lat"], lon: element["lng"]));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      findPosition();
    });
    checkFirstDataGPS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: NativeMap(
                controller: _controller,
              )),
          Positioned(
              right: 15,
              top: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 50),
                    backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back),
              )),
          AnimatedBuilder(
            animation: animation,
            builder: (context, builder) {
              return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 50),
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                findLocation(fromGPS: true);
                              },
                              child: Icon(setGPSicon()),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 50),
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                if (!animatinController.isAnimating) {
                                  if (!isGPS) {
                                    animatinController.reverse();
                                    checkFirstDataGPS();
                                    isGPS = true;
                                  } else {
                                    animatinController.forward();
                                    checkFirstDataWifi();
                                    isGPS = false;
                                  }
                                  setState(() {
                                    isGPS;
                                  });
                                }
                              },
                              child:
                                  Icon(isGPS ? Icons.wifi : Icons.location_on),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        height: 200,
                        child: Stack(
                          children: [
                           if(isGPS)  Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Opacity(
                                  opacity: 1 - animation.value,
                                  child: setLocationWidget(),
                                )),
                           if(!isGPS)  Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Opacity(
                                    opacity: (animation.value),
                                    child: setWifiWidget())),
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          ),
        ],
      ),
    );
  }

  Future<bool> checkWifi()async {
    
    
    return (await info.getWifiBSSID())?.replaceAll("\"", "") == currentBssid ;
  }
  
  Widget? setErrorForGPS() {
    if (locationType == LocationType.noPermission) {
      return Row(
        children: [
          const Text(
            "برای انجام حضور وغیاب نیاز به مجوز است",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
              onTap: () {
                checkingLocation();
              },
              child: const Text(
                "اعطای مجوز",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ))
        ],
      );
    } else if (locationType == LocationType.noGPS) {
      return const Row(
        children: [
          Text(
            "لطفا GPS خود را روشن کنید",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return null;
  }

  Widget setLocationWidget() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(
                    Icons.class_outlined,
                    size: 20,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.model.classes!.className ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.model.classes?.maestro ?? "نامعلوم",
                      style: const TextStyle(
                          color: Color(0xFF858585),
                          fontWeight: FontWeight.w600),
                    ),
                    Wrap(
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 15,
                            color: Color(0xFF858585),
                          ),
                          Text(
                            "${widget.model.classes?.start ?? ""} الی ${widget.model.classes?.end ?? ""}"
                                .toPersianNumber(),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xFF858585),
                                fontWeight: FontWeight.w600),
                          ),
                        ]),

                    //    Icon(
                    //   Icons.add_location_alt_outlined,
                    //   size: 18,
                    //   color: isIn?const Color( 0xFF3DC13C):const Color(0xFFF13637),
                    //  ),
                    //   const SizedBox(width: 5,),
                    //   Text(
                    //     "شما در ${widget.model.classes!.apartment ?? ""} قرار ${isIn? "دارید":"ندارید"}",
                    //     style:  TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 15,
                    //       color: isIn?const Color( 0xFF3DC13C):const Color(0xFFF13637)
                    //     ),
                    //   ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.add_location_alt_outlined,
                      size: 18,
                      color: isIn
                          ? const Color(0xFF3DC13C)
                          : const Color(0xFFF13637),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "شما در ${widget.model.classes!.apartment ?? ""} قرار ${isIn ? "دارید" : "ندارید"}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: isIn
                              ? const Color(0xFF3DC13C)
                              : const Color(0xFFF13637)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          setErrorForGPS() ?? const SizedBox.shrink(),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 60, 50),
                backgroundColor: const Color(0xFF1F54D3),
                elevation: 5,
                animationDuration: const Duration(milliseconds: 1000),
             
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            onPressed: () {
              
              gpsAuthorization();
            },
            child: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "ثبت حضور",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget setWifiWidget() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(
                    Icons.class_outlined,
                    size: 20,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.model.classes!.className ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.model.classes?.maestro ?? "نامعلوم",
                      style: const TextStyle(
                          color: Color(0xFF858585),
                          fontWeight: FontWeight.w600),
                    ),
                    Wrap(
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 15,
                            color: Color(0xFF858585),
                          ),
                          Text(
                            "${widget.model.classes?.start ?? ""} الی ${widget.model.classes?.end ?? ""}"
                                .toPersianNumber(),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xFF858585),
                                fontWeight: FontWeight.w600),
                          ),
                        ]),

                    //    Icon(
                    //   Icons.add_location_alt_outlined,
                    //   size: 18,
                    //   color: isIn?const Color( 0xFF3DC13C):const Color(0xFFF13637),
                    //  ),
                    //   const SizedBox(width: 5,),
                    //   Text(
                    //     "شما در ${widget.model.classes!.apartment ?? ""} قرار ${isIn? "دارید":"ندارید"}",
                    //     style:  TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 15,
                    //       color: isIn?const Color( 0xFF3DC13C):const Color(0xFFF13637)
                    //     ),
                    //   ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.signal_wifi_connected_no_internet_4,
                      size: 18,
                      color: isNetwork?
                           const Color(0xFF3DC13C):const Color(0xFFF13637)
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "شما به Wifi ${widget.model.classes!.apartment ?? ""} متصل ${isNetwork ? "هستید" : "نیستید"}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: isNetwork? 
                             const Color(0xFF3DC13C):
                             const Color(0xFFF13637)
                           ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          setErrorForWIFI() ?? const SizedBox.shrink(),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 60, 50),
                backgroundColor: const Color(0xFF1F54D3),
                elevation: 5,
                animationDuration: const Duration(milliseconds: 1000),
           
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            onPressed: () {
              wifiAuthorization();
            },
            child: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.wifi_outlined,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "ثبت حضور",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void checkingLocation({
    bool? fromGPS,
    bool? fromRenew,
  }) async {
    LocationType data =
        await findLocation(fromGPS: fromGPS, fromRenew: fromRenew);

    setState(() {
      locationType = data;
    });
  }

  IconData setGPSicon() {
    if (locationType == LocationType.gpsSet) {
      return Icons.gps_fixed;
    } else if (locationType == LocationType.noGPS) {
      return Icons.gps_off;
    } else {
      return Icons.gps_not_fixed;
    }
  }

  Future<LocationType> findLocation({
    bool? fromGPS,
    bool? fromRenew,
  }) async {
    gotoLocation();
    LocationPermission permission = await _platform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _platform.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationType.noPermission;
      } else if (permission == LocationPermission.deniedForever) {
        Geolocator.openLocationSettings();
        return LocationType.noPermission;
      } else {
        await findLocation();
        return LocationType.permissionSet;
      }
    }
    if (await _platform.isLocationServiceEnabled()) {
      Geolocator.getPositionStream().listen((Position position) {
        //  setState(() {
        //    position = position;
        //  });
      });
      if (fromGPS ?? false) {
        //position =Position(latitude:34.00992594555889,longitude:51.364527290770525  , timestamp: DateTime.now() ,accuracy: 1,altitude: 20,altitudeAccuracy: 10,heading: 19,headingAccuracy:9,speed:23,speedAccuracy: 12);
        position = await _platform.getCurrentPosition(
            locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ));
        // ,
        //
        findPosition();
        _controller.goToLocation(position!.latitude, position!.longitude, 18.0);
      }

      return LocationType.gpsSet;
    } else {
      if (fromRenew ?? false) {
        customSnackBar.showErrorSnackBar(context, "GPS شما خاموش است");
      }
      return LocationType.noGPS;
    }
  }

  void findPosition() {
    if (position != null) {
      final LatLon currentPoint =
          LatLon(lat: position!.latitude, lon: position!.longitude);
      setState(() {
        isIn = isPointInsidePolygon(currentPoint, positions);
      });
    }

    _controller.drawPolygon(positions, isIn);
  }

  bool isPointInsidePolygon(LatLon point, List<LatLon> polygon) {
    bool isInside = false;
    int n = polygon.length;
    double minX = polygon[0].lat;
    double maxX = polygon[0].lat;
    double minY = polygon[0].lon;
    double maxY = polygon[0].lon;
    for (int i = 1; i < n; i++) {
      if (polygon[i].lat < minX) minX = polygon[i].lat;
      if (polygon[i].lat > maxX) maxX = polygon[i].lat;
      if (polygon[i].lon < minY) minY = polygon[i].lon;
      if (polygon[i].lon > maxY) maxY = polygon[i].lon;
    }
    if (point.lat < minX ||
        point.lat > maxX ||
        point.lon < minY ||
        point.lon > maxY) {
      return false;
    }
    int i = 0, j = n - 1;
    for (i = 0; i < n; i++) {
      if ((polygon[i].lon > point.lon) != (polygon[j].lon > point.lon) &&
          point.lat <
              (polygon[j].lat - polygon[i].lat) *
                      (point.lon - polygon[i].lon) /
                      (polygon[j].lon - polygon[i].lon) +
                  polygon[i].lat) {
        isInside = !isInside;
      }
      j = i;
    }
    return isInside;
  }

  void gpsAuthorization() {
   
    findLocation().then((value) {
      setState(() {
        locationType = value;
      });
      
      if (locationType == LocationType.noGPS) {
        customSnackBar.showErrorSnackBar(
            context, "لطفا موقعیت مکانی خود را فعال کنید");
      } else if (locationType == LocationType.noPermission) {
        customSnackBar.showErrorSnackBar(
            context, "برای انجام حضور و غیاب نیاز به مجوز است");
      } else {
        findPosition();
        if (isIn) {
          customSnackBar.showSuccessSnackBar(context, "حضوری شما ثبت شد");
          hitButton = 0;
        } else {
          if (hitButton < 2) {
            customSnackBar.showErrorSnackBar(
                context, "شما در موقعیت موردنظر قرار ندارید حضوری شما ثبت نشد");
          } else {
            customSnackBar.showErrorSnackBar(context,
                "  در صورت بروز مشکل در موقعیت مکانی میتوانید از Wifi استفاده کنید");
          }
          hitButton++;
        }
      }
    });
  }
  
  Widget? setErrorForWIFI() {
    
     if (wifiType == WifiType.noPermissionGPS) {
      return Row(
        children: [
          const Text(
            "برای انجام حضور وغیاب نیاز به مجوز است",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
              onTap: () {
                checkingLocation();
                checkFirstDataWifi();
              },
              child: const Text(
                "اعطای مجوز",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ))
        ],
      );
    } else if (wifiType == WifiType.noGPS) {
      return const Row(
        children: [
          Text(
            "لطفا GPS خود را روشن کنید",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }else if(wifiType == WifiType.noWifi){
      return const Row(
        children: [
          Text(
            " لطفا به Wifiبه مورد نظر متصل شوید",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return null;
   }
   
  void checkFirstDataWifi() async {
    LocationPermission permission = await _platform.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        wifiType = WifiType.noPermissionGPS;
      });
    } else {
      if (await _platform.isLocationServiceEnabled()) {
        final connectivityResult = await (Connectivity().checkConnectivity());
         if (connectivityResult == ConnectivityResult.wifi) {
           if(await checkWifi()){ 
           setState(() {
              wifiType = WifiType.wifiSet;
            isNetwork=true;
          
             });
            
            
           }
           else{
             setState(() {
               wifiType = WifiType.noWifi;
             isNetwork=false;
          
             });
            
           }
           
         }
         else{
           setState(() {
            wifiType = WifiType.noWifi;
          });
         }
       
      } else {
        
        setState(() {
          wifiType = WifiType.noGPS;
        });
      }
    }
  }

 
  void wifiAuthorization() {
   if(wifiType == WifiType.noGPS) {
    customSnackBar.showErrorSnackBar(context, "لطفا موقعیت مکانی خود را فعال کنید");
   }else if(wifiType == WifiType.noPermissionGPS){
     customSnackBar.showErrorSnackBar(context, "لطفا برای حضور و غیاب مجوز را تایید کنید");
   }
   else{
      checkWifi().then((value){
         if(value){
          customSnackBar.showSuccessSnackBar(context, "حضوری شما ثبت شد");  
         }else{
          customSnackBar.showErrorSnackBar(context, "لطفا به Wifi مورد انتظار متصل شوید");  
         }
      });

      
   } 

  }
}

class LatLon {
  final double lat;
  final double lon;

  LatLon({required this.lat, required this.lon});
}

enum LocationType {
  noPermission,
  permissionSet,
  gpsSet,
  noGPS,
}

enum WifiType {
  noPermissionGPS,
  permissionGPSSet,
  gpsSet,
  noGPS,
  wifiSet,
  noWifi,
}
