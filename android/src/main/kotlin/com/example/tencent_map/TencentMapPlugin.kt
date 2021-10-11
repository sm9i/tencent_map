package com.example.tencent_map

import androidx.annotation.NonNull
import com.example.tencent_map.view.TMapViewFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import androidx.lifecycle.Lifecycle
import com.example.tencent_map.lifecycle.LifecycleProvider
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference


/** TencentMapPlugin */
class TencentMapPlugin : FlutterPlugin, ActivityAware {

    private var lifecycle: Lifecycle? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        TMapViewFactory.create(flutterPluginBinding, object : LifecycleProvider {
            override fun getLifecycle(): Lifecycle = lifecycle!!
        })
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = (binding.lifecycle as HiddenLifecycleReference).lifecycle
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        lifecycle = null
    }
}
