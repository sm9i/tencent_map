package com.example.tencent_map.overlayer

import com.example.tencent_map.result.ChannelResult
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

interface OverLayerManager :
        MethodChannel.MethodCallHandler,
        TencentMap.OnMarkerClickListener,
        TencentMap.OnPolylineClickListener,
        EventChannel.StreamHandler {

    fun addOver(any: Any)

    fun removeOver(call: MethodCall): ChannelResult

    fun removeAll(): ChannelResult

    fun dispose()


}
