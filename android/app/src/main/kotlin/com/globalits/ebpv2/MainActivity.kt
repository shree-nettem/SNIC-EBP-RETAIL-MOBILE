package com.globalits.ebpv2



import androidx.annotation.NonNull
import com.mastercard.gateway.android.sdk.Gateway
import com.mastercard.gateway.android.sdk.GatewayCallback
import com.mastercard.gateway.android.sdk.GatewayMap
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel




class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "credimax.channel.payment"
    private val callback=  UpdateSessionCallback()

    lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "credimaxPayment") {
                val gateway = Gateway()
                gateway.setMerchantId(call.argument("merchant"))
                gateway.setRegion(Gateway.Region.ASIA_PACIFIC)
                val request = GatewayMap()
                    .set("sourceOfFunds.provided.card.nameOnCard", call.argument("nameOnCard"))
                    .set("sourceOfFunds.provided.card.number", call.argument("cardNumber"))
                    .set("sourceOfFunds.provided.card.securityCode", call.argument("securityCode"))
                    .set("sourceOfFunds.provided.card.expiry.month", call.argument("expiryMonth"))
                    .set("sourceOfFunds.provided.card.expiry.year", call.argument("expiryYear"))

                gateway.updateSession(call.argument("id"),"56", request, callback)

            }
        }
        configureChannel(flutterEngine)

    }

    fun configureChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    }
    inner class UpdateSessionCallback : GatewayCallback {

        override fun onSuccess(response: GatewayMap) {
            methodChannel.invokeMethod("_didRecievePaymentUpdate", true)        }

        override fun onError(throwable: Throwable) {
            methodChannel.invokeMethod("_didRecievePaymentUpdate", false)
        }

        }
    }

