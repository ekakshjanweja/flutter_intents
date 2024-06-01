package com.example.methodchannel
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"

    private var sharedText: String? = null
    private val NEW_CHANNEL = "app.channel.process.data"

    private  var sharedUrl: String? = null
    private val TEST_CHANNEL = "app.channel.process.urls"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent = intent
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_PROCESS_TEXT == action && type != null) {
            if ("text/plain" == type) {
                handleSendText(intent)
            }
        }

        if (Intent.ACTION_SEND == action && type != null) {
            if ("text/*" == type) {
                handleSendUrl(intent)
            }
        }
    }

//    private fun sendTextToFlutter(text: String) {
//        val intent = Intent(this, MainActivity::class.java).apply {
//            action = Intent.ACTION_SEND
//            putExtra(Intent.EXTRA_TEXT, text)
//            type = "text/plain"
//        }
//        startActivity(intent)
//    }

    private fun handleSendText(intent: Intent) {
        sharedText = intent.getStringExtra(Intent.EXTRA_PROCESS_TEXT)
    }

    private fun handleSendUrl(intent: Intent){
        sharedUrl = intent.getStringExtra(Intent.EXTRA_TEXT)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NEW_CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.contentEquals("getSharedText")) {
                        result.success(sharedText);
                        sharedText = null;
                    } else {
                        result.notImplemented();
                    }
                }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TEST_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method.contentEquals("getSharedUrl")) {
                    result.success(sharedUrl);
                    sharedUrl = null;
                } else {
                    result.notImplemented();
                }
            }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}


