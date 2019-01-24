package me.boqin.fluttersample;

import static me.boqin.fluttersample.NativePlusActivity.TAG;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "qts.flutter.io/route";


  private MethodChannel.Result mResult;


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("startActivity")) {
          String arg = methodCall.argument("path");
          if(arg!=null){
            if (arg.equals("/a")) {
              Intent intent = new Intent(MainActivity.this, NativeActivity.class);
              startActivity(intent);
            }else if(arg.equals("/b")){
              Intent intent = new Intent(MainActivity.this, NativePlusActivity.class);
              intent.putExtra(TAG, (String) methodCall.argument("param"));
              startActivityForResult(intent, 200);
              mResult = result;
            }
          }

        }
      }
    });
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == 200 && mResult!=null) {
      mResult.success("from B");
    }
  }
}
