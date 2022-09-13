package kh.ad.notifications_listener_service.utils;

import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

public class NotificationServiceFlutterEngineUtils {
    private static final String FlutterEngineKey = "kh.ad.notifications_listener_service/FlutterEngineKey";

    public static FlutterEngine updateEngine(@NonNull Context context, boolean state) {
        FlutterEngine engine = state ? getEngine() : null;
        if (engine == null) {
            engine = new FlutterEngine(context);
            // Define a DartEntrypoint
            DartExecutor.DartEntrypoint entrypoint =
                    DartExecutor.DartEntrypoint.createDefault();
            // Execute the DartEntrypoint within the FlutterEngine.
            engine.getDartExecutor().executeDartEntrypoint(entrypoint);
        }

        if (!engine.getAccessibilityChannel().flutterJNI.isAttached()) {
            FlutterInjector.instance().flutterLoader().startInitialization(context);
            FlutterInjector.instance().flutterLoader().ensureInitializationComplete(context, new String[]{});
            engine.getAccessibilityChannel().flutterJNI.attachToNative();
        }

        cacheEngine(engine);

        return engine;
    }

    private static FlutterEngine getEngine() {
        return FlutterEngineCache.getInstance().get(FlutterEngineKey);
    }

    public static void cacheEngine(FlutterEngine engine) {
        FlutterEngineCache.getInstance().put(FlutterEngineKey, engine);
    }
}
