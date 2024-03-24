package com.example.attendance

import android.content.Context
import android.graphics.BitmapFactory


import android.view.View
import com.carto.core.BinaryData
import com.carto.graphics.Color

import com.carto.styles.AnimationStyle
import com.carto.styles.AnimationStyleBuilder
import com.carto.styles.AnimationType
import com.carto.styles.LineStyle
import com.carto.styles.LineStyleBuilder

import com.carto.styles.MarkerStyleBuilder
import com.carto.styles.PolygonStyle

import com.carto.styles.PolygonStyleBuilder
import io.flutter.plugin.common.BinaryMessenger

import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import org.neshan.common.model.LatLng
import org.neshan.mapsdk.MapView
import org.neshan.mapsdk.internal.utils.BitmapUtils
import org.neshan.mapsdk.model.Marker

import org.neshan.mapsdk.model.Polygon


class CustomMapViewFactory(private val messanger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE){


    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {

        return CustomMapView(context,messanger ,viewId)
    }
    internal class CustomMapView(private val context: Context, messanger: BinaryMessenger, id: Int) : PlatformView,MethodChannel.MethodCallHandler  {
        private  var polygon:Polygon? =null;
        private var   map: MapView = MapView(context)
        private lateinit var animSt: AnimationStyle
        private val methodChannel:MethodChannel= MethodChannel(messanger,"NeshanMapChannel")
        override fun getView(): View{
            return map
        }


        override fun dispose() {}

        init {
          //  map.moveCamera(LatLng(35.767234, 51.330743), 0f)
          //  map.setZoom(14f, 0f)
        
            // Set cache location
           // map.cacheBaseStyle?.data
          map.settings.setMinZoomLevel(1f)
          map.settings.setMaxZoomLevel(19f)
            map.isPoiEnabled=true
          //  map.settings.setNeshanLogoMargins(10,-200)
           methodChannel.setMethodCallHandler(this)

        }

        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) =
            when(call.method){

                "goToLocation"->{
                    map.clearMarkers()

                    val argument=call.arguments as Map<*, *>
                    val lat:Double=argument["lat"] as Double
                    val lon:Double=argument["lon"] as Double
                    val zoom:Double=argument["zoom"] as Double
                    map.moveCamera(LatLng(lat,lon),1f)
                    map.setZoom(18f,1f)
                    val loc=LatLng(lat,lon)
                    map.addMarker(createMarker(loc))
                }
                "drawPolygon"->{
//                    if(polygon!=null){
//                        map.removePolygon(polygon)
//                    }
                    val argument=call.arguments as Map<*, *>
                    val isIn:Boolean = argument["isIn"] as Boolean
                    val arrayList:ArrayList<LatLng> = ArrayList()
 //                   arrayList.add(LatLng(35.762294, 51.325525))
 //                   arrayList.add(LatLng(35.756548, 51.323768))
 //                   arrayList.add(LatLng(35.755394, 51.328617))
 //                   arrayList.add(LatLng(35.760905, 51.330666))
                    ((argument["position"] ) as List<*>).forEach {
                        val data = it as Map<*,*>
                        val lat: Double = data["lat"] as Double
                        val lon: Double = data["lon"] as Double
                        arrayList.add(LatLng(lat, lon))
                    }
//                     for (data in )  {
//                         print(data)
//
//
//
//
//                    }
                    polygon = Polygon(arrayList,getPolygonStyle(isIn))
                    map.addPolygon(polygon)
                    //result.error("100",(argument["position"]).toString(),"");
                    map.moveCamera(LatLng(arrayList[0].latitude, arrayList[0].longitude), .5f)
                    map.setZoom(18.0f,1f);
                    //val argument=call.arguments as Map<*, *>
                   // val lat:Double=argument["lat"] as Double
                   // val lon:Double=argument["lon"] as Double
                   // val zoom:Double=argument["zoom"] as Double
                  //  map.moveCamera(LatLng(lat,lon),1f)
                  //  map.setZoom(zoom.toFloat(),1f)
                   // val loc=LatLng(lat,lon)
                   // map.addMarker(createMarker(loc))
                }
                else->result.error("100","Not Implemented Yet","unknown method")
            }
        private fun getLineStyle(): LineStyle {
            val lineStyleBuilder = LineStyleBuilder()
            lineStyleBuilder.color =  Color(2, 119, 189, 190)
            lineStyleBuilder.width = 4f
            return lineStyleBuilder.buildStyle()
        }

        private fun getPolygonStyle(isIn:Boolean): PolygonStyle {
            var polygonStyleBuilder = PolygonStyleBuilder()
            polygonStyleBuilder.lineStyle = getLineStyle()
            polygonStyleBuilder.color = if(isIn){ Color(10, 200,25, 250 )}else{Color(200, 55,10, 250)}
            return polygonStyleBuilder.buildStyle()
        }
        private fun createMarker(loc: LatLng): Marker {
            // Creating animation for marker. We should use an object of type AnimationStyleBuilder, set
            // all animation features on it and then call buildStyle() method that returns an object of type
            // AnimationStyle
            val animStBl = AnimationStyleBuilder()
            animStBl.fadeAnimationType = AnimationType.ANIMATION_TYPE_SMOOTHSTEP
            animStBl.sizeAnimationType = AnimationType.ANIMATION_TYPE_SPRING
            animStBl.phaseInDuration = 0.5f
            animStBl.phaseOutDuration = 0.5f
            animSt = animStBl.buildStyle()

            // Creating marker style. We should use an object of type MarkerStyleCreator, set all features on it
            // and then call buildStyle method on it. This method returns an object of type MarkerStyle
            val markStCr = MarkerStyleBuilder()
            markStCr.size = 30f
            markStCr.bitmap = BitmapUtils.createBitmapFromAndroidBitmap(
                BitmapFactory.decodeResource(
                  context.resources,R.drawable.ic_marker_blue
                )
            )
            // AnimationStyle object - that was created before - is used here
            markStCr.animationStyle = animSt
            val markSt = markStCr.buildStyle()

            // Creating marker
            return Marker(loc, markSt)
        }


    }






}



