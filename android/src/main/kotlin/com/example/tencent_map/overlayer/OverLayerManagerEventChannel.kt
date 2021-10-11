package com.example.tencent_map.overlayer

import android.util.Log
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import com.tencent.tencentmap.mapsdk.maps.model.Polyline
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

abstract class OverLayerManagerEventChannel : OverLayerManager {

    companion object {
        const val TAG: String = "OverLayerMEChannel"
    }

    private var events: EventChannel.EventSink? = null


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "over#remove" -> result.success(removeOver(call).toMap())
            else -> result.notImplemented()
        }
    }

    override fun onMarkerClick(marker: Marker): Boolean {
        Log.i(TAG, "onMarkerClick")
        events?.success(marker.id)
        return true
    }

    override fun onPolylineClick(polyline: Polyline, p1: LatLng?) {
        Log.i(TAG, "onPolylineClick")
        events?.success(polyline.id)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Log.i(TAG, "onListen")
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        Log.i(TAG, "onCancel")
        events = null
    }

    override fun dispose() {
        Log.i(TAG, "dispose")
        removeAll()
        events = null
    }


}