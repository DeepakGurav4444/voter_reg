package com.example.voter_reg

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Custom method to get flavor
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "flavor"
        ).setMethodCallHandler { call, result ->
            if (call.method == "getFlavor") {
                result.success(BuildConfig.FLAVOR) // Return the flavor from BuildConfig
            } else {
                result.notImplemented()
            }
        }
    }
}
