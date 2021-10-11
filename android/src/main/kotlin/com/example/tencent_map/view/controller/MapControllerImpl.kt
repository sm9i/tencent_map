package com.example.tencent_map.view.controller

import android.graphics.Bitmap
import android.util.Log
import com.example.tencent_map.result.ChannelResult
import com.example.tencent_map.result.missingParamResult
import com.example.tencent_map.result.successResult
import com.example.tencent_map.util.Convert
import com.example.tencent_map.overlayer.OverLayerManager
import com.example.tencent_map.overlayer.OverLayerType
import com.tencent.tencentmap.mapsdk.maps.CameraUpdate
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MapControllerImpl(
        override val map: TencentMap,
        private val mOverLayerManager: OverLayerManager
) : MapController {
    companion object {
        const val TAG: String = "MapControllerImpl"
    }


    override fun setMapType(call: MethodCall): ChannelResult {
        Log.i(TAG, "setMapType")
        return if (call.hasArgument("type")) {
            map.mapType = call.argument<Int>("type")!!
            successResult
        } else {
            missingParamResult
        }
    }

    override fun setShowMyLocation(call: MethodCall): ChannelResult {
        Log.i(TAG, "setShowMyLocation")
        return if (call.hasArgument("enable")) {
            map.isMyLocationEnabled = call.argument<Boolean>("enable")!!
            //TODO
            successResult
        } else {
            missingParamResult
        }
    }

    override fun moveCamera(call: MethodCall): ChannelResult {
        Log.i(TAG, "moveCamera")
        val param = call.arguments<Map<*, *>>()
        return if (param.isNotEmpty()) {
            moveCamera(
                    Convert.getCameraUpdate(param), param.containsKey("anim"),
                    "${param["duration"]}".toLongOrNull()
            )
            successResult
        } else {
            missingParamResult
        }
    }


    override fun addOverLayer(call: MethodCall): ChannelResult {
        Log.i(TAG, "addOverLayer")
        val param = call.arguments<Map<*, *>>()
        return if (param.containsKey("overType")) {
            when (OverLayerType.fromInt(param["overType"] as Int)) {
                OverLayerType.Marker -> {
                    Log.i(TAG, "addOverLayerMarker")
                    val data = param["data"] as Map<*, *>
                    val marker = map.addMarker(Convert.getMarkerOptions(data))
                    mOverLayerManager.addOver(marker)
                    ChannelResult(true, data = marker.id)
                }
                OverLayerType.Polyline -> {
                    Log.i(TAG, "addOverLayerMarkerPolyline")
                    val data = param["data"] as Map<*, *>
                    val polyline = map.addPolyline(Convert.getPolylineOptions(data))
                    mOverLayerManager.addOver(polyline)
                    ChannelResult(true, data = polyline.id)
                }
            }

        } else {
            missingParamResult
        }
    }


    override fun getCameraPosition(): ChannelResult {
        Log.i(TAG, "getCameraPosition")
        return ChannelResult(true, data = Convert.setCameraPosition(map.cameraPosition))
    }

    override fun getSnapshot(success: (any: Any?) -> Unit) {
        Log.i(TAG, "getSnapshot")
        map.snapshot {


            val output = ByteArrayOutputStream()
            it.compress(Bitmap.CompressFormat.PNG, 100, output)
            it.recycle()
            val res = output.toByteArray()
            try {
                output.close()
            } catch (e: Exception) {
                e.printStackTrace()
            }
            success(res)

        }

    }

    override fun removeAllOverLayer() {
        Log.i(TAG, "removeAllOverLayer")
        map.clearAllOverlays()
        mOverLayerManager.removeAll()
    }

    private fun moveCamera(cameraUpdate: CameraUpdate, isAnim: Boolean, duration: Long?) {
        Log.i(TAG, "moveCamera")
        if (isAnim) {
            map.animateCamera(cameraUpdate, duration!!, null)
        } else {
            map.moveCamera(cameraUpdate)
        }
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "map#setMapType" -> result.success(setMapType(call).toMap())
            "map#setShowMyLocation" -> result.success(setShowMyLocation(call).toMap())
            "map#moveCamera" -> result.success(moveCamera(call).toMap())
            "map#addOverLayer" -> result.success(addOverLayer(call).toMap())
            "map#getCameraPosition" -> result.success(getCameraPosition().toMap())
            "map#getSnapshot" -> getSnapshot { result.success(it) }
            "map#removeAllOverLayer" -> {
                removeAllOverLayer()
                result.success(true)
            }
            else -> result.notImplemented()
        }

    }

    override fun dispose() {
        Log.i(TAG, "dispose")
        mOverLayerManager.dispose()
    }


}