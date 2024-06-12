package com.johnstef.flutter_user_certificates_android

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.security.KeyStore
import java.security.cert.X509Certificate

/** FlutterUserCertificatesAndroidPlugin */
class FlutterUserCertificatesAndroidPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_user_certificates_android")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method){
      "getUserCertificates" -> getUserCertificates(result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getUserCertificates(result: Result) {
    val userInstalledCaCertificates: List<X509Certificate> = try {
      val keyStore = KeyStore.getInstance("AndroidCAStore")
      keyStore.load(null, null)
      val aliasList = keyStore.aliases().toList().filter { it.startsWith("user") }
      aliasList.map { keyStore.getCertificate(it) as X509Certificate }
    } catch (e: Exception) {
      emptyList()
    }

    val mapOfBytes = userInstalledCaCertificates.associate { it.issuerX500Principal.name to it.encoded }
    result.success(mapOfBytes)
  }
}
