package com.cleardil.reactnative.sdk;

import android.app.Activity;

import com.cleardil.sdk.KycModule;
import com.facebook.react.bridge.NoSuchKeyException;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.UnexpectedNativeTypeException;
import java.util.List;
import java.util.ArrayList;
import io.flutter.embedding.android.FlutterActivity;

public class ClearDilSdkModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private Promise currentPromise = null;
    private final ClearDilSdkActivityEventListener activityEventListener;

    public ClearDilSdkModule(final ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.activityEventListener = new ClearDilSdkActivityEventListener();
        reactContext.addActivityEventListener(activityEventListener);
    }

    private void setPromise(Promise promise) {
        if (currentPromise != null) {
            // If the current promise is not resolved, reject it with a cancellation error.
            // If the current promise is resolved, calling reject will have no effect.
            // Reference https://github.com/facebook/react-native/blob/master/ReactAndroid/src/main/java/com/facebook/react/bridge/PromiseImpl.java#L232-L233
            currentPromise.reject("error", new Exception("New activity was started before old promise was resolved."));
        }
        currentPromise = promise;
        activityEventListener.setCurrentPromise(promise);
    }

    @Override
    public String getName() {
        return "ClearDilSdk";
    }

    /** NOTE: This indirection is used to allow unit tests to mock this method */
    protected Activity getCurrentActivityInParentClass() {
        return super.getCurrentActivity();
    }

    @ReactMethod
    public void start(final ReadableMap config, final Promise promise) {

        setPromise(promise);

        try {
            final String sdkToken;
            ReadableMap captureDocument = null;
            ReadableMap captureLicence=null;
            ReadableMap captureIdentity=null;
            Boolean isCaptureDocument=false;
            Boolean isCaptureDrivingLicence=false;
            Boolean isCaptureNationalCard=false;
            try {
                sdkToken = getSdkTokenFromConfig(config);

                final ReadableMap flowSteps = config.getMap("flowSteps");

                captureDocument = flowSteps.getMap("captureDocument");
                if(captureDocument!=null){
                    if(captureDocument.getString("docType").equals("PASSPORT")){
                        isCaptureDocument=true;
                    }

                }
                captureLicence = flowSteps.getMap("captureLicence");

                if(captureLicence!=null){
                    if(captureLicence.getString("docType").equals("DRIVING_LICENCE")){
                        isCaptureDrivingLicence=true;
                    }

                }
                captureIdentity = flowSteps.getMap("captureIdentity");

                if(captureIdentity!=null){
                    if(captureIdentity.getString("docType").equals("NATIONAL_IDENTITY_CARD")){
                        isCaptureNationalCard=true;
                    }

                }

                final Activity currentActivity = getCurrentActivityInParentClass();
                if (currentActivity == null) {
                    currentPromise.reject("error", new Exception("Android activity does not exist"));
                    currentPromise = null;
                    return;
                }
                if(isCaptureDocument &&isCaptureDrivingLicence&&isCaptureNationalCard){

                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {

                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                                    }else if(isCaptureDocument &&isCaptureDrivingLicence&&!isCaptureNationalCard){
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
                                    .allowDriverLicense()
                                    .allowPassport()
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);



                        }
                    });
                }else if(isCaptureDocument &&!isCaptureDrivingLicence&&isCaptureNationalCard){
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
                                    .allowIdentityCard()
                                    .allowPassport()
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                }else if(!isCaptureDocument &&isCaptureDrivingLicence&&isCaptureNationalCard){
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
                                    .allowPassport()
                                    .allowDriverLicense()
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                }else if(!isCaptureDocument &&!isCaptureDrivingLicence&&isCaptureNationalCard){
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
                                    .allowIdentityCard()
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                }else if(!isCaptureDocument &&isCaptureDrivingLicence&&!isCaptureNationalCard){
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
                                    .allowDriverLicense()
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                }else if(isCaptureDocument &&!isCaptureDrivingLicence&&!isCaptureNationalCard){
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
                                    .allowPassport()
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                }else{
                    currentActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            KycModule.builder()
                                    .withSdkToken(sdkToken)
                                    .withEnvironment(KycModule.Environment.Demo)
//                                    .withTargetActivity(TargetActivity.class)
                                    .build()
                                    .start(currentActivity);


                        }
                    });
                }


            } catch (Exception e) {
                currentPromise.reject("config_error", e);
                currentPromise = null;
                return;
            }

        } catch (final Exception e) {
            e.printStackTrace();
            // Wrap all unexpected exceptions.
            currentPromise.reject("error", new Exception("Unexpected error starting ClearDil page", e));
            currentPromise = null;
            return;
        }
    }

    public static String getSdkTokenFromConfig(final ReadableMap config) {
        final String sdkToken = config.getString("sdkToken");
        return sdkToken;
    }





    private boolean getBooleanFromConfig(ReadableMap config, String key) {
        return config.hasKey(key) && config.getBoolean(key);
    }
}
