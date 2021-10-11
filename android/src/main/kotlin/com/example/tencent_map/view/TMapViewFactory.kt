package com.example.tencent_map.view


import android.content.Context
import androidx.annotation.NonNull
import com.example.tencent_map.lifecycle.LifecycleProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


class TMapViewFactory private constructor(
        private val lifecycleProvider: LifecycleProvider,
        private val binaryMessenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {


    companion object {
        fun create(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding, @NonNull lifecycleProvider: LifecycleProvider) {
            flutterPluginBinding.platformViewRegistry.registerViewFactory(
                    "t_map_view",
                    TMapViewFactory(lifecycleProvider, flutterPluginBinding.binaryMessenger))
        }
    }


    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return TMapView(context, viewId, lifecycleProvider, binaryMessenger,args)
    }


}