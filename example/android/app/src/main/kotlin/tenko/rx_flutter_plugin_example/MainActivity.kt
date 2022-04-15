package tenko.rx_flutter_plugin_example


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
  lateinit var testingChannel: RxFlutterTestingChannel

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    testingChannel = RxFlutterTestingChannel(flutterEngine.dartExecutor.binaryMessenger)
    super.configureFlutterEngine(flutterEngine)
  }
}
