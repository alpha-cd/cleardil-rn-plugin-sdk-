//
//  Response.swift
//  ClearDilSdk
//
//  Copyright © 2022 ClearDil. All rights reserved.
//

import Foundation
//import Onfido

func createResponse(_ results: [Any], faceVariant: String?) -> [String: [String: Any]] {
  var RNResponse = [String: [String: Any]]()

//  let document: OnfidoResult? = results.filter({ result in
//    if case OnfidoResult.document = result { return true }
//    return false
//  }).first
//
//  let face: OnfidoResult? = results.filter({ result in
//    if case OnfidoResult.face = result { return true }
//    return false
//  }).first
//
//  if let documentUnwrapped = document, case OnfidoResult.document(let documentResponse) = documentUnwrapped {
//    RNResponse["document"] = ["front": ["id": documentResponse.front.id]]
//    if (documentResponse.back?.id != documentResponse.front.id) {
//      RNResponse["document"]?["back"] = ["id": documentResponse.back?.id]
//    }
//  }
//
//  if let faceUnwrapped = face, case OnfidoResult.face(let faceResponse) = faceUnwrapped {
//    RNResponse["face"] = ["id": faceResponse.id, "variant": faceVariant!]
//  }

  return RNResponse
}
