![npm](https://img.shields.io/npm/v/alpha-cd/cleardil-rn-plugin-sdk-?color=%47b801)
![NPM](https://img.shields.io/npm/l/alpha-cd/cleardil-rn-plugin-sdk-?color=%47b801)
![Build Status](https://app.bitrise.io/app/8e301f076fdc3e94/status.svg?token=7lDTdIn1dfL81q2VwjUpFA&branch=master)

## Table of contents

- [Table of contents](#table-of-contents)
- [Overview](#overview)
- [Getting started](#getting-started)
  - [1. Obtaining an API token](#1-obtaining-an-api-token)
  - [2. Creating an Applicant](#2-creating-an-applicant)
  - [3. Configuring SDK with Tokens](#3-configuring-sdk-with-tokens)
  - [4. Adding the ClearDil React Native SDK to your project](#4-adding-the-cleardil-react-native-sdk-to-your-project)
    - [This SDK supports React Native versions 0.60.0 and later](#this-sdk-supports-react-native-versions-0600-and-later)
    - [4.1 Adding SDK dependency through npm](#41-adding-sdk-dependency-through-npm)
    - [4.2 Update your Android build.gradle files](#42-update-your-android-buildgradle-files)
    - [4.3 Update your iOS configuration files](#43-update-your-ios-configuration-files)
- [Usage](#usage)
  - [1. Creating the SDK configuration](#1-creating-the-sdk-configuration)
  - [2. Parameter details](#2-parameter-details)
  - [3. Success Response](#3-success-response)
  - [4. Failure Response](#4-failure-response)
  - [5. Localization](#5-localization)
- [Creating checks](#creating-checks)
  - [1. Obtaining an API token](#1-obtaining-an-api-token-1)
  - [2. Creating a check](#2-creating-a-check)
- [Theme Customization](#theme-customization)
- [Going live](#going-live)
- [More Information](#more-information)
  - [Support](#support)
  - [Troubleshooting](#troubleshooting)
- [How is the ClearDil React Native SDK licensed?](#how-is-the-cleardil-react-native-sdk-licensed)


## Overview

This SDK provides a drop-in set of screens and tools for react native applications to allow capturing of identity documents and face photos/live videos for the purpose of identity verification with [ClearDil](https://cleardil.com/). The SDK offers a number of benefits to help you create the best on-boarding/identity verification experience for your customers:

* Carefully designed UI to guide your customers through the entire photo/video-capturing process
* Modular design to help you seamlessly integrate the photo/video-capturing process into your application flow
* Advanced image quality detection technology to ensure the quality of the captured images meets the requirement of the ClearDil identity verification process, guaranteeing the best success rate
* Direct image upload to the ClearDil service, to simplify integration\*

\* **Note**: the SDK is only responsible for capturing and uploading photos/videos. You still need to access the [ClearDil API](https://reference.cleardil.com) to create and manage checks.

* Supports iOS 11+
* Supports Xcode 13+
* Supports Android API level 21+
* Supports iPads and tablets

## Getting started

### 1. Obtaining an API token

In order to start integration, you will need the **API token**. You can use our [sandbox](https://reference.cleardil.com) environment to test your integration, and you will find the API tokens inside your [ClearDil Dashboard](https://docs.cleardil.com). You can create API tokens inside your cleardil Dashboard as well.

### 2. Creating an Applicant

You must create an ClearDil [applicant](https://github.com/alpha-cd/cleardil-rn-sdk/tree/devleop) before you start the flow.

For a document or face check the minimum applicant details required are `firstName` and `lastName`.

You must create applicants from your server:

<!-- ```shell
$ curl https://api.cleardil.com/v3/applicants \
    -H 'Authorization: Token token=YOUR_API_TOKEN' \
    -d 'first_name=Theresa' \
    -d 'last_name=May'
``` -->

The JSON response has an `id` field containing a UUID that identifies the applicant. All documents or live photos/videos uploaded by that instance of the SDK will be associated with that applicant.

### 3. Configuring SDK with Tokens

You will need to generate and include a short-lived JSON Web Token (JWT) every time you initialise the SDK.

To generate an SDK Token you should perform a request to the SDK Token endpoint in the ClearDil API:
<!-- 
```shell
$ curl https://api.cleardil.com/v3/sdk_token \
  -H 'Authorization: Token token=YOUR_API_TOKEN' \
  -F 'applicant_id=YOUR_APPLICANT_ID' \
  -F 'application_id=YOUR_APPLICATION_BUNDLE_IDENTIFIER'
``` -->

Make a note of the token value in the response, as you will need it later on when initialising the SDK.

**Warning:** SDK tokens expire 90 minutes after creation.

The `application_id` is the "Application ID" or "Bundle ID" that was already set up during development.
* For iOS this is usually in the form of `com.your-company.app-name`.
  * To get this value manually, open xcode `ios/YourProjectName`, click on the project root, click the General tab, under Targets click your project name, and check the Bundle Identifier field.
  * To get this value programmatically in native iOS code, see [Stack Overflow Page](https://stackoverflow.com/questions/8873203/how-to-get-bundle-id).
* For Android this is usually in the form of com.example.yourapp.
  * To get this file manually, you can find it in your app's `build.config`.  For example, in `android/app/build.gradle`, it is the value of `applicationId`.
  * To get this value programmatically in native Java code, see [Stack Overflow Page](https://stackoverflow.com/questions/14705874/bundle-id-in-android).

### 4. Adding the ClearDil React Native SDK to your project

#### This SDK supports React Native versions 0.60.0 and later

If you are starting from scratch, you can follow the React Native CLI Quickstart https://reactnative.dev/docs/getting-started.  For examples, once you have installed the React Native tools, you can run:
```shell
$ npx react-native init YourProjectName
```

You cannot use this SDK with Expo: If your project already uses Expo, you will need to follow the eject process https://docs.expo.io/versions/latest/workflow/customizing/.

- NOTE: You will need to download and install [Android Studio](https://developer.android.com/studio/index.html), configured as specified in [the react-native guide for Android](https://facebook.github.io/react-native/docs/getting-started.html#android-development-environment) to run on an android emulator.

#### 4.1 Adding SDK dependency through npm

Navigate to the root directory of your React Native project. The rest of this section (section 4) will assume you are in the root directory. Run the following command:

```shell
$ npm install https://github.com/alpha-cd/cleardil-rn-plugin-sdk- --save
```

#### 4.2 Update your Android build.gradle files

Update your build.grade files to reference the Android SDK, and enable multi-dex.  If you build your project using the `react-native init`, with a `build.gradle` in the `android/` and `android/app/` directories, you can run this script to do it:

```shell
$ npm --prefix node_modules/alpha-cd/cleardil-rn-plugin-sdk-/ run updateBuildGradle
```

<details>
<summary>To manually update build files without the script</summary>

If you want to manually update your build files, you can follow the steps the script takes:

First you will need to specify your credentials to Cleardil artifactory repository in the gradle.properties file :
artifactory_user=<user>
artifactory_password=<password>
artifactory_contextUrl=https://cleardil.jfrog.io/artifactory


Add the maven link `android/build.gradle`:
```gradle
buildscript {
    repositories {
        jcenter()
    }
    dependencies {
        classpath "org.jfrog.buildinfo:build-info-extractor-gradle:4+"
    }
}

allprojects {
    apply plugin: "com.jfrog.artifactory"
}

artifactory {
    contextUrl = "${artifactory_contextUrl}"   //The base Artifactory URL if not overridden by the publisher/resolver
    resolve {
        repository {
            repoKey = 'cleardil-gradle-release'
            username = "${artifactory_user}"
            password = "${artifactory_password}"
            maven = true
        }
    }
}
```

Enable multidex in `android/app/build.gradle`:
```gradle
android {
    String storageUrl = System.env.FLUTTER_STORAGE_BASE_URL ?: "https://storage.googleapis.com"
    repositories {
        maven {
            url "$storageUrl/download.flutter.io"
        }
        maven {
            url "${artifactory_contextUrl}/cleardil-gradle-release"
        }
    }
}

dependencies {
    implementation 'com.cleardil.sdk:cleardil_android_sdk:1.2.0'
}
```
2. Basic calling of Cleardil SDK in your code
Add a Flutter activity to your AndroidManifest.xml :

<activity
  android:name="io.flutter.embedding.android.FlutterActivity"
  android:theme="@android:style/Theme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />


</details>

#### 4.3 Update your iOS configuration files

Change `ios/Podfile` to use version 10:
```
platform :ios, '10.0'
```
* Use latest ruby version
* Use latest cocopods version
* Use following comands to update pod cache

```bash
sudo gem install cocoapods-clean
pod deintegrate
pod clean
pod install
```

* Also open ios project as workspace project .xcworkspace



Add descriptions for camera and microphone permissions to `ios/YourProjectName/Info.plist`:
```xml
<plist version="1.0">
<dict>
  <!-- Add these four elements: -->
	<key>NSCameraUsageDescription</key>
	<string>Required for document and facial capture</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Required for video capture</string>
  <!-- ... -->
</dict>
</plist>
```

Open Xcode and create an empty swift file in your project root.  For example, if your project is called YourProjectName, you can open it from the command line:
```bash
open ios/YourProjectName.xcworkspace
```

Once Xcode is open, add an empty Swift file:  File > New File > Swift > Next > "SwiftVersion" > Create > Don't create Header.  This will update your iOS configuration with a Swift version.  All changes are automatically saved, so you can close Xcode.

Install the pods:
```bash
cd ios
pod install
cd ..
```

#### 4.4 Fix dependency conflict between React Native and ClearDil Android SDK

When using React Native version <= 0.64.0 there is a dependency conflict with okhttp3 on Android that can cause requests from outside of the ClearDil SDK to fail. To fix this you can add the following code to `android/app/build.gradle`:

```
android {
    String storageUrl = System.env.FLUTTER_STORAGE_BASE_URL ?: "https://storage.googleapis.com"
    repositories {
        maven {
            url "$storageUrl/download.flutter.io"
        }
        maven {
            url "${artifactory_contextUrl}/cleardil-gradle-release"
        }
    }
}
```

## Usage

You can launch the app with a call to `ClearDil.start`.  For example, once you have the `sdkTokenFromClearDilServer`, your react component might look like this:

```javascript
import React, {Component} from 'react';
import {Button, View} from 'react-native';
import {
  ClearDil,
  ClearDilDocumentType,
} from 'cleardil-rn-sdk';

export default class App extends Component {
  startSDK() {
     ClearDil.start({
      sdkToken: 'sdkTokenFromClearDilServer',
      flowSteps: {
        captureDocument: {
          docType: ClearDilDocumentType.PASSPORT
        },
        captureLicence: {
          docType: ClearDilDocumentType.DRIVING_LICENCE
        },
        captureIdentity: {
          docType: ClearDilDocumentType.NATIONAL_IDENTITY_CARD
        }
      },
    })
      .then(res => console.warn('CLeardilSDK: Success:', JSON.stringify(res)))
      .catch(err => console.warn('ClearDilSDK: Error:', err.code, err.message));
    }

  render() {
    return (
      <View style={{marginTop: 100}}>
        <Button title="Start ClearDil SDK" onPress={() => this.startSDK()} />
      </View>
    );
  }
}

```

### 1. Creating the SDK configuration

Once you have an added the SDK as a dependency and you have a SDK token, you can configure the SDK:

Example configuration:

```javascript
config = {
  sdkToken: “EXAMPLE-TOKEN-123”,
  flowSteps: {
     captureDocument: {
          docType: ClearDilDocumentType.PASSPORT
        },
        captureLicence: {
          docType: ClearDilDocumentType.DRIVING_LICENCE
        },
        captureIdentity: {
          docType: ClearDilDocumentType.NATIONAL_IDENTITY_CARD
        }
  },
}
```

### 2. Parameter details

* **`sdkToken`**: Required.  This is the JWT sdk token obtained by making a call to the SDK token API.  See section [Configuring SDK with Tokens](#3-configuring-sdk-with-tokens).
* **`flowSteps`**: Required.  This object is used to toggle individual screens on and off and set configurations inside the screens.
* **`captureDocument`**: Optional. This object contains configuration for the capture document screen. If docType and countryCode are not specified, a screen will appear allowing the user to choose these values.  If omitted, this screen does not appear in the flow.
* **`docType`**: Required if countryCode is specified.
  * Valid values in `ClearDilDocumentType`: `PASSPORT`, `DRIVING_LICENCE`, `NATIONAL_IDENTITY_CARD`.



  * Example usage:

  ```javascript
  config = {
    sdkToken: “EXAMPLE-TOKEN-123”,
    flowSteps: {
      ...
    },
  }
  ```

### 3. Success Response

The response will include a `captureDocument` 

Example:

```javascript
{
 document: {
   front: { id: "123-abc" },
   back: { id: "345-def" }
 }
}
```

### 4. Failure Response

The SDK will reject the promise any time the ClearDil SDK exits without a success.  This includes cases where:
* the configuration was invalid,
* the mobile user clicked the back button to exit the ClearDil SDK.

Example

```javascript
{
  code: "config_error",
  message: "sdkToken is missing"
}
```


### 1. Obtaining an API token

All API requests must be made with an API token included in the request headers. You can find your API token (not to be mistaken with the mobile SDK token) inside your [ClearDil Dashboard](https://reference.cleardil.com).

Refer to the [Authentication](https://docs.cleardil.com) section in the API documentation for details. For testing, you should be using the sandbox, and not the live, token.



## Going live

Once you are happy with your integration and are ready to go live, please contact [client-support@cleardil.com](mailto:client-support@cleardil.com) to obtain live versions of the API token and the mobile SDK token. You will have to replace the sandbox tokens in your code with the live tokens.

A few things to check before you go live:

* Make sure you have entered correct billing details inside your [ClearDil Dashboard](https://docs.cleardil.com/)

## More Information

### Troubleshooting

**Resolving dependency conflicts**

Here are some helpful resources if you are experiencing dependency conflicts between this React Native SDK and other packages your app uses:
* [Gradle: Dependency Resolution](https://docs.gradle.org/current/userguide/dependency_resolution.html#header)
* [Gradle: Dependency Constraints](https://docs.gradle.org/current/userguide/dependency_constraints.html#dependency-constraints)

**General advice**

If you see issues, you can try removing `node_modules`, build directories, and cache files. A good tool to help with this is [react-native-clean-project](https://github.com/alpha-cd/cleardil-rn-sdk/tree/devleop)
### Discrepancies between underlying ClearDil native SDKs

Below is a list of known differences in expected behavior between the ClearDil Android and iOS SDKs this React Native SDK wraps:

* Documents with the type `passport` uploaded through the iOS SDK will have the `side` attribute set to `null`, while those uploaded via Android will have `side` as `front`.

### Support

Please open an issue through [GitHub](https://github.com/alpha-cd/cleardil-rn-plugin-sdk-/issues). Please be as detailed as you can. Remember **not** to submit your token in the issue. Also check the closed issues to check whether it has been previously raised and answered.

If you have any issues that contain sensitive information please send us an email with the `ISSUE:` at the start of the subject to [react-native-sdk@cleardil.com](mailto:react-native-sdk@cleardil.com?Subject=ISSUE%3A)

Previous version of the SDK will be supported for a month after a new major version release. Note that when the support period has expired for an SDK version, no bug fixes will be provided, but the SDK will keep functioning (until further notice).

Copyright 2022 ClearDil, Ltd. All rights reserved.

## How is the ClearDil React Native SDK licensed?

The ClearDil React Native SDK is available under the MIT license.
