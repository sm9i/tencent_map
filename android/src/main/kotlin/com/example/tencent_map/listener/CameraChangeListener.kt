package com.example.tencent_map.listener

import com.example.tencent_map.util.Convert
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import io.flutter.plugin.common.EventChannel

/**
 * 地图移动listener
 */
class CameraChangeListener : TencentMap.OnCameraChangeListener, EventChannel.StreamHandler {
    private var mEvent: EventChannel.EventSink? = null

    override fun onCameraChange(position: CameraPosition) {
        mEvent?.success(Convert.setCameraChange(position, true))
    }

    override fun onCameraChangeFinished(position: CameraPosition) {
        mEvent?.success(Convert.setCameraChange(position, false))
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        mEvent = events
    }

    override fun onCancel(arguments: Any?) {
        mEvent = null
    }
}