package com.example.tencent_map.view

import android.content.Context
import android.util.Log
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.example.tencent_map.lifecycle.LifecycleProvider
import com.example.tencent_map.util.Convert
import com.example.tencent_map.listener.CameraChangeListener
import com.example.tencent_map.view.controller.MapController
import com.example.tencent_map.view.controller.MapControllerImpl
import com.example.tencent_map.overlayer.OverLayerManager
import com.example.tencent_map.overlayer.OverLayerManagerImpl
import com.tencent.tencentmap.mapsdk.maps.MapView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

//TODO args
//TODO lifecycle
class TMapView(
        context: Context,
        viewId: Int,
        lifecycleProvider: LifecycleProvider,
        binaryMessenger: BinaryMessenger,
        args: Any?
) : PlatformView, DefaultLifecycleObserver {

    companion object {
        private const val TAG: String = "TMapView"
    }

    private val mMapView: MapView
    private val mMapController: MapController
    private val mMapMethodChannel: MethodChannel

    private val mOverManager: OverLayerManager
    private val mMarkerChannel: MethodChannel
    private val mMarkerEventChannel: EventChannel

    private val mCameraChangeEventChannel: EventChannel
    private val mCameraChangeListener: CameraChangeListener


    init {
        Log.i(TAG, "init")

        mMapView = MapView(context)
        mOverManager = OverLayerManagerImpl()
        mCameraChangeListener = CameraChangeListener()
        mMapController = MapControllerImpl(mMapView.map, mOverManager)

        //method channel
        mMapMethodChannel = MethodChannel(binaryMessenger, "t_map_view_$viewId")
        mMapMethodChannel.setMethodCallHandler(mMapController)
        mMarkerChannel = MethodChannel(binaryMessenger, "t_map_view_over_$viewId")
        mMarkerChannel.setMethodCallHandler(mOverManager)

        //event channel
        mMarkerEventChannel = EventChannel(binaryMessenger, "t_map_view_over_event_$viewId")
        mMarkerEventChannel.setStreamHandler(mOverManager)
        mCameraChangeEventChannel = EventChannel(binaryMessenger, "t_map_view_change_event_$viewId")
        mCameraChangeEventChannel.setStreamHandler(mCameraChangeListener)

        // listener
        mMapView.map.setOnCameraChangeListener(mCameraChangeListener)
        mMapView.map.setOnMarkerClickListener(mOverManager)
        mMapView.map.setOnPolylineClickListener(mOverManager)


        Convert.getUiSetting(args, mMapView.map.uiSettings)
        lifecycleProvider.getLifecycle().addObserver(this)

    }

    override fun getView(): View {
        Log.i(TAG, "getView")
        return mMapView
    }

    override fun dispose() {
        Log.i(TAG, "onDestroy")
        mMapView.onDestroy()
        mMapController.dispose()
        mOverManager.dispose()
        mMapMethodChannel
    }

    override fun onCreate(owner: LifecycleOwner) {
        Log.i(TAG, "onCreate")
    }

    override fun onStart(owner: LifecycleOwner) {
        Log.i(TAG, "onStart")
        mMapView.onStart()
    }

    override fun onResume(owner: LifecycleOwner) {
        Log.i(TAG, "onResume")
        mMapView.onResume()
    }

    override fun onPause(owner: LifecycleOwner) {
        Log.i(TAG, "onPause")
        mMapView.onPause()
    }

    override fun onStop(owner: LifecycleOwner) {
        Log.i(TAG, "onStop")
        mMapView.onStop()
    }

    override fun onDestroy(owner: LifecycleOwner) = dispose()
}


