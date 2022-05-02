package com.cleardil.reactnative.sdk;

import android.app.Activity;
import android.content.Intent;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;


class ClearDilSdkActivityEventListener extends BaseActivityEventListener {

    private Promise currentPromise = null;

    public ClearDilSdkActivityEventListener(){

    }

    /**
     * Sets the current promise to be resolved.
     * 
     * @param currentPromise the promise to set
     */
    public void setCurrentPromise(Promise currentPromise) {
        this.currentPromise = currentPromise;
    }

    @Override
    public void onActivityResult(final Activity activity, final int requestCode, final int resultCode, final Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }
};