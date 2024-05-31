package com.example.intent_test

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutter/text"
    private lateinit var textBroadcastReceiver: TextBroadcastReceiver

    override fun onCreate(savedInstanceState: Bundle?) {
        super(savedInstanceState)

        val methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
        textBroadcastReceiver = TextBroadcastReceiver(methodChannel)
        val filter = IntentFilter("com.example.flutter.SEND_TEXT")
        registerReceiver(textBroadcastReceiver, filter)
    }

    override fun onDestroy() {
        super.onDestroy()
        // Unregister the BroadcastReceiver to avoid memory leaks
        unregisterReceiver(textBroadcastReceiver)
    }

    private fun sendTextToFlutter(text: String) {
        val intent = Intent("com.example.flutter.SEND_TEXT").apply {
            putExtra("text", text)
        }
        sendBroadcast(intent)
    }

    sendTextToFlutter("Hello from Kotlin!")

}
