package com.example.tencent_map.view.controller

import com.example.tencent_map.result.ChannelResult
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

interface MapController : MethodChannel.MethodCallHandler {


    /**
     * 设置地图类型
     */
    fun setMapType(call: MethodCall): ChannelResult

    /**
     * 设置是否显示我的位置
     */
    fun setShowMyLocation(call: MethodCall): ChannelResult

    /**
     * 移动地图
     */
    fun moveCamera(call: MethodCall): ChannelResult

    /**
     * 添加 overLayer
     */
    fun addOverLayer(call: MethodCall): ChannelResult

    /**
     * 获取当前中心
     */
    fun getCameraPosition(): ChannelResult

    /**
     * 截屏
     */
    fun getSnapshot(success: (any: Any?) -> Unit)

    /**
     * 删除所有overLayer
     */
    fun removeAllOverLayer()


    fun dispose()

    val map: TencentMap


}