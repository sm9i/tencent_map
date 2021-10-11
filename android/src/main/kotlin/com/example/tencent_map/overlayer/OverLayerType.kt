package com.example.tencent_map.overlayer

/**
 * 添加overLayer 类型
 */
enum class OverLayerType(private val overType: Int) {
    Marker(0),
    Polyline(1);

    companion object {
        fun fromInt(value: Int) = OverLayerType.values().first { it.overType == value }
    }


}