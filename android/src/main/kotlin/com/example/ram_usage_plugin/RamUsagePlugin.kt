package com.example.ram_usage_plugin

import android.app.ActivityManager
import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.fixedRateTimer

class RamUsagePlugin : FlutterPlugin, EventChannel.StreamHandler {

    private lateinit var eventChannel: EventChannel
    private lateinit var context: Context
    private var timer: Timer? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "ram_usage_plugin")
        eventChannel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

        timer = fixedRateTimer("ramUsageTimer", initialDelay = 0, period = 500) {
            val memoryInfo = ActivityManager.MemoryInfo()
            activityManager.getMemoryInfo(memoryInfo)
            val totalRam = memoryInfo.totalMem.toDouble()
            val availableRam = memoryInfo.availMem.toDouble()
            val usagePercentage = ((totalRam - availableRam) / totalRam) * 100

            // Переключение на главный поток
            mainHandler.post {
                events?.success(usagePercentage)
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        timer?.cancel()
        timer = null
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        timer?.cancel()
        eventChannel.setStreamHandler(null)
    }
}
