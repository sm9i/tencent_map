package com.example.tencent_map.overlayer

import android.util.Log
import com.example.tencent_map.result.ChannelResult
import com.example.tencent_map.result.failedResult
import com.example.tencent_map.result.missingParamResult
import com.example.tencent_map.result.successResult
import com.tencent.tencentmap.mapsdk.maps.interfaces.Removable
import com.tencent.tencentmap.mapsdk.maps.model.IOverlay
import io.flutter.plugin.common.MethodCall

class OverLayerManagerImpl : OverLayerManagerEventChannel() {

    companion object {
        const val TAG: String = "OverLayerManagerImpl"
    }

    private val mOverlays = mutableListOf<Any>()


    override fun addOver(any: Any) {
        Log.i(TAG, "addOver")
        mOverlays.add(any)
    }

    override fun removeOver(call: MethodCall): ChannelResult {
        Log.i(TAG, "removeOver")

        return if (call.hasArgument("overId")) {

            val over = mOverlays.find {
                (it as IOverlay).id == call.argument<String>("overId")
            } as Removable?
            if (over != null) {
                over.remove()
                if (over.isRemoved) {
                    mOverlays.remove(over)
                    successResult
                }
            }
            failedResult
        } else {
            missingParamResult
        }
    }

    override fun removeAll(): ChannelResult {
        Log.i(TAG, "removeAll")
        mOverlays.clear()
        return successResult
    }


}