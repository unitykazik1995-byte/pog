package com.okosaurona

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.okosaurona/core"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "initEngine") {
                val status = CoreBridge.initEngine()
                result.success(status)
            } else {
                result.notImplemented()
            }
        }
    }
}

object CoreBridge {
    init {
        System.loadLibrary("oko_saurona_core")
    }

    external fun initEngine(): String
}
