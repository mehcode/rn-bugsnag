package com.mehcode.reactnative.bugsnag;

import android.app.Activity;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

import java.lang.Error;
import java.util.HashMap;
import java.util.Map;

import com.bugsnag.android.*;

class RNBugsnagModule extends ReactContextBaseJavaModule {
    public RNBugsnagModule(ReactApplicationContext reactContext) {
        super(reactContext);

        // Initialize Bugnsang (sets up crash handling)
        Bugsnag.init(reactContext);

        // Ensure we only notify in production (configurable?)
        Bugsnag.setNotifyReleaseStages("production");
    }

    @Override
    public String getName() {
        return "RNBugsnag";
    }

    @ReactMethod
    public void setUser(
            String userID, String userName,
            String userEmail, Promise promise) {
        Bugsnag.setUser(userID, userEmail, userName);

        promise.resolve(null);
    }

    @ReactMethod
    public void clearUser(Promise promise) {
        // BUG: This isn't static for some reason
        Bugsnag.getClient().clearUser();

        promise.resolve(null);
    }

    @ReactMethod
    public void notifyWithMessage(final String message, final String reason, final Promise promise) {
        Error error = new Error(message + reason);
        Bugsnag.notify(error, Severity.ERROR, new MetaData());

        promise.resolve(null);
    }

    @ReactMethod
    public void leaveBreadcrumb(String name, ReadableMap metadata, Promise promise) {
        // Convert ReadableMap to HashMap
        Map<String, String> md = new HashMap<String, String>();
        ReadableMapKeySetIterator iterator = metadata.keySetIterator();
        while (iterator.hasNextKey()) {
            String key = iterator.nextKey();
            ReadableType type = metadata.getType(key);
            switch (type) {
                case String:
                    md.put(key, metadata.getString(key));
                    break;

                default:
                    // Do nothing
                    break;
            }
        }

        Bugsnag.leaveBreadcrumb(name, BreadcrumbType.NAVIGATION, md);

        promise.resolve(null);
    }
}
