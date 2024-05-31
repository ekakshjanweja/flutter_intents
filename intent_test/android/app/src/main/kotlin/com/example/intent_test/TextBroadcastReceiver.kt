package com.example.intent_test

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodChannel
import javax.naming.Context

class TextBroadcastReceiver(private val methodChannel: MethodChannel) : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent != null && intent.action == "com.example.flutter.SEND_TEXT"){
            val text = intent.getStringExtra("text");
            if (text != null) {
                methodChannel.invokeMethod("sendText", text)
            }
        }
    }

}