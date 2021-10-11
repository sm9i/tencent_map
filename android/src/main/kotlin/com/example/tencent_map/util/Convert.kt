package com.example.tencent_map.util

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import com.tencent.tencentmap.mapsdk.maps.CameraUpdate
import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.UiSettings
import com.tencent.tencentmap.mapsdk.maps.model.*

object Convert {


    /**
     * {
     * "latLng":{lat:,lng:},
     * "zoom":,
     * }
     */
    fun getCameraUpdate(map: Map<*, *>): CameraUpdate {
        var update: CameraUpdate
        val latLng = getLatLng(map)
        update = if (map.containsKey("zoom")) {
            CameraUpdateFactory.newLatLngZoom(latLng, "${map["zoom"]}".toFloat())
        } else {
            CameraUpdateFactory.newLatLng(latLng)
        }
        return update
    }

    fun getMarkerOptions(map: Map<*, *>): MarkerOptions {
        val options = MarkerOptions(getLatLng(map))
        if (map.containsKey("icon")) {
            val byteArray = map["icon"] as ByteArray
            options.icon(BitmapDescriptorFactory.fromBitmap(BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)))
        }
        if (map.containsKey("anchor")) {
            val anchor = map["anchor"] as Map<*, *>
            "${anchor["anchorU"]}".toFloatOrNull()?.let { "${anchor["anchorV"]}".toFloatOrNull()?.let { it1 -> options.anchor(it, it1) } }
        }
        if (map.containsKey("alpha")) {
            "${map["alpha"]}".toFloatOrNull()?.let { options.alpha(it) }
        }
        if (map.containsKey("flat")) {
            options.flat("${map["flat"]}".toBoolean())
        }
        if (map.containsKey("rotation")) {
            "${map["rotation"]}".toFloatOrNull()?.let { options.rotation(it) }
        }
        if (map.containsKey("clockwise")) {
            options.clockwise("${map["clockwise"]}".toBoolean())
        }
        if (map.containsKey("level")) {
            "${map["level"]}".toIntOrNull()?.let { options.level(it) }
        }
        if (map.containsKey("zIndex")) {
            "${map["zIndex"]}".toFloatOrNull()?.let { options.zIndex(it) }
        }
        if (map.containsKey("visible")) {
            options.visible("${map["visible"]}".toBoolean())
        }
        if (map.containsKey("draggable")) {
            options.draggable("${map["draggable"]}".toBoolean())
        }
        if (map.containsKey("fastLoad")) {
            options.fastLoad("${map["fastLoad"]}".toBoolean())
        }
        if (map.containsKey("infoWindowEnable")) {

            options.infoWindowEnable("${map["infoWindowEnable"]}".toBoolean())
        }
        if (map.containsKey("infoWindowArch")) {
            val infoWindowArch = map["infoWindowArch"] as Map<*, *>
            "${infoWindowArch["infoWindowArchU"]}".toFloatOrNull()?.let {
                "${infoWindowArch["infoWindowArchV"]}".toFloatOrNull()?.let { it2 ->
                    options.infoWindowAnchor(it, it2)
                }
            }
        }
        if (map.containsKey("infoWindowOffset")) {
            val infoWindowArch = map["infoWindowOffset"] as Map<*, *>
            "${infoWindowArch["infoWindowOffsetU"]}".toFloatOrNull()?.let {
                "${infoWindowArch["infoWindowOffsetV"]}".toFloatOrNull()?.let { it2 ->
                    options.infoWindowOffset(it.toInt(), it2.toInt())
                }
            }
        }
        if (map.containsKey("viewInfoWindow")) {

            options.viewInfoWindow("${map["viewInfoWindow"]}".toBoolean())
        }
        if (map.containsKey("title")) {
            options.title("${map["title"]}")
        }
        if (map.containsKey("snippet")) {
            options.snippet("${map["snippet"]}")
        }
        if (map.containsKey("indoorInfo")) {
//            "${map["indoorInfo"]}"
//            options.indoorInfo(IndoorInfo())
        }
        return options

    }

    fun getPolylineOptions(map: Map<*, *>): PolylineOptions? {
        val options = PolylineOptions()
        if (map["latLng"] is List<*>) {

            val latLng = (map["latLng"] as List<*>).map {
                getLatLng(it as Map<*, *>)
            }
            if (latLng.isEmpty()) {
                return null
            }
            options.latLngs(latLng)
        }
        if (map.containsKey("lineCap")) {
            options.lineCap("${map["lineCap"]}".toBoolean())
        }
        if (map.containsKey("color")) {
            "${map["color"]}".toLongOrNull()?.let {
                options.color(it.toInt())
            }
        }
        if (map.containsKey("width")) {
            "${map["width"]}".toFloatOrNull()?.let {
                options.width(it)
            }
        }
        if (map.containsKey("borderColor")) {
            "${map["borderColor"]}".toLongOrNull()?.let {
                options.borderColor(it.toInt())
            }
        }
        if (map.containsKey("borderWidth")) {
            "${map["borderWidth"]}".toFloatOrNull()?.let {
                options.borderWidth(it)
            }
        }
        return options
    }

    fun getUiSetting(args: Any?, uiSettings: UiSettings) {
        if (args != null && args is Map<*, *>) {
            val map: Map<*, *> = args
            if (map.isEmpty()) {
                return
            }

            if (map.containsKey("zoomGesturesEnabled")) {
                uiSettings.isZoomGesturesEnabled = map["zoomGesturesEnabled"] as Boolean
            }
            if (map.containsKey("tiltGesturesEnabled")) {
                uiSettings.isTiltGesturesEnabled = map["tiltGesturesEnabled"] as Boolean
            }
            if (map.containsKey("scrollGesturesEnabled")) {
                uiSettings.isScrollGesturesEnabled = map["scrollGesturesEnabled"] as Boolean
            }
            if (map.containsKey("scaleViewEnabled")) {
                uiSettings.isScaleViewEnabled = map["scaleViewEnabled"] as Boolean
            }
            if (map.containsKey("rotateGesturesEnabled")) {
                uiSettings.isRotateGesturesEnabled = map["rotateGesturesEnabled"] as Boolean
            }
            if (map.containsKey("myLocationButtonEnabled")) {
                uiSettings.isMyLocationButtonEnabled = map["myLocationButtonEnabled"] as Boolean
            }

        }

    }


    private fun getLatLng(map: Map<*, *>): LatLng {
        return LatLng(map["lat"] as Double, map["lng"] as Double)
    }


    fun setCameraChange(position: CameraPosition, change: Boolean): Map<String, Any> {
        val result = setCameraPosition(position).toMutableMap()
        result["change"] = change
        return result
    }

    fun setCameraPosition(position: CameraPosition): Map<String, Any> {
        val result = setLatLng(position.target).toMutableMap()
        result.putAll(mapOf(
                "zoom" to position.zoom,
                "tilt" to position.tilt,
                "bearing" to position.bearing
        ))
        return result
    }

    private fun setLatLng(latLng: LatLng): Map<String, Any> {

        return mapOf<String, Any>(
                "lat" to latLng.latitude,
                "lng" to latLng.longitude
        )
    }


    fun setOverLayerId(marker: IOverlay): Map<String, Any> {
        return mapOf<String, Any>(
                "markerId" to marker.id
        )
    }
}