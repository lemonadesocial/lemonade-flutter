package social.lemonade.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

import android.content.Context
import androidx.multidex.MultiDex
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.content.Intent

class MainActivity : FlutterFragmentActivity() {
    
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return provideEngine(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // do nothing, because the engine was been configured in provideEngine
    }

    companion object {
        var engine: FlutterEngine? = null
        fun provideEngine(context: Context): FlutterEngine {
            var eng = engine ?: FlutterEngine(context, emptyArray(), true, false)
            engine = eng
            return eng
        }
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
    }
}