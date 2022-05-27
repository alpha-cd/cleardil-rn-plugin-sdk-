//
//  ClearDilSdk.swift
//  ClearDilSdk
//
//  Created by Nitish on 4/26/22.
//  Copyright © 2022 ClearDil. All rights reserved.
//
import Foundation
import cleardil_ios_sdk

public class AppearancePublic: NSObject {

    public let primaryColor: UIColor
    public let primaryTitleColor: UIColor
    public let primaryBackgroundPressedColor: UIColor
    public let supportDarkMode: Bool

    public init(
        primaryColor: UIColor,
        primaryTitleColor: UIColor,
        primaryBackgroundPressedColor: UIColor,
        supportDarkMode: Bool = true) {
        self.primaryColor = primaryColor
        self.primaryTitleColor = primaryTitleColor
        self.primaryBackgroundPressedColor = primaryBackgroundPressedColor
        self.supportDarkMode = supportDarkMode
    }
}



@objc(ClearDilSdk)
class ClearDilSdk: NSObject {

  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }

  @objc func start(_ config: NSDictionary,
                      resolver resolve: @escaping RCTPromiseResolveBlock,
                      rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    DispatchQueue.main.async {
      self.run(withConfig: config, resolver: resolve, rejecter: reject)
    }
  }

  private func run(withConfig config: NSDictionary,
                  resolver resolve: @escaping RCTPromiseResolveBlock,
                  rejecter reject: @escaping RCTPromiseRejectBlock) {

//    do {
        var kycModule : KycModule?
        var passportType : Bool = false
        var licenseType : Bool = false
        var identityType : Bool = false

      let sdkToken:String = config["sdkToken"] as! String
      let flowStepss:NSDictionary? = config["flowSteps"] as? NSDictionary
      let captureDocument:NSDictionary? = flowStepss?["captureDocument"] as? NSDictionary
        let captureLicence:NSDictionary? = flowStepss?["captureLicence"] as? NSDictionary
        let captureIdentity:NSDictionary? = flowStepss?["captureIdentity"] as? NSDictionary



        if let docType = captureDocument?["docType"] as? String{
            if docType == "PASSPORT" {
                passportType=true
            }
            
        }
        
        if let docType = captureLicence?["docType"] as? String{
            if docType == "DRIVING_LICENCE" {
                licenseType=true
            }
            
        }
        
        if let docType = captureIdentity?["docType"] as? String{
            if docType == "NATIONAL_IDENTITY_CARD" {
                identityType=true
            }
            
        }
        
        
        if passportType as? Bool == true && licenseType as? Bool == true && identityType as? Bool == true {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
                
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowPassport()
              .allowIdentityCard()
              .allowDriverLicense()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
            

            
        }else if passportType as? Bool == true && licenseType as? Bool == true && identityType as? Bool == false {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
                
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowPassport()
              .allowDriverLicense()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
           
        }else if passportType as? Bool == true && licenseType as? Bool == false && identityType as? Bool == false {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowPassport()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
        }else if passportType as? Bool == false && licenseType as? Bool == true && identityType as? Bool == true {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowIdentityCard()
              .allowDriverLicense()
              .withSdkToken(sdkToken: sdkToken)
                .build()
                kycModule?.start(topVC)
            }
        }else if passportType as? Bool == false && licenseType as? Bool == false && identityType as? Bool == true {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowIdentityCard()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
        }else if passportType as? Bool == false && licenseType as? Bool == true && identityType as? Bool == false {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowDriverLicense()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
        }else if passportType as? Bool == true && licenseType as? Bool == false && identityType as? Bool == true {
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowPassport()
              .allowIdentityCard()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
        }else{
            if let topVC = UIApplication.shared.windows.first?.rootViewController?.findTopMostController() {
            kycModule = KycModuleBuilder()
              .withEnvironment(env: KycModule.Environment.SANDBOX)
              .allowPassport()
              .allowIdentityCard()
              .allowDriverLicense()
              .withSdkToken(sdkToken: sdkToken)
              .build()
                kycModule?.start(topVC)
            }
        }        
    }
}

extension UIColor {

    static var primaryColor: UIColor {
        return decideColor(light: UIColor.from(hex: "#353FF4"), dark: UIColor.from(hex: "#3B43D8"))
    }

    static var primaryButtonColorPressed: UIColor {
        return decideColor(light: UIColor.from(hex: "#232AAD"), dark: UIColor.from(hex: "#5C6CFF"))
    }

    private static func decideColor(light: UIColor, dark: UIColor) -> UIColor {
        #if XCODE11
        guard #available(iOS 13.0, *) else {
            return light
        }
        return UIColor { (collection) -> UIColor in
            return collection.userInterfaceStyle == .dark ? dark : light
        }
        #else
        return light
        #endif
    }

    static func from(hex: String) -> UIColor {

        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let redInt = Int(color >> 16) & mask
        let greenInt = Int(color >> 8) & mask
        let blueInt = Int(color) & mask

        let red = CGFloat(redInt) / 255.0
        let green = CGFloat(greenInt) / 255.0
        let blue = CGFloat(blueInt) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


extension UIViewController {
    public func findTopMostController() -> UIViewController {
        var topController: UIViewController? = self
        while topController!.presentedViewController != nil {
            topController = topController!.presentedViewController!
        }
        return topController!
    }
}
