//
//  API.swift
//  PartOne
//
//  Created by Mauricio Vazquez on 9/28/17.
//  Copyright © 2017 Mauricio Vazquez. All rights reserved.
//

import UIKit

class API: NSObject {
  
  class var sharedInstance: API {
    struct Singleton {
      static let instance = API()
    }
    return Singleton.instance
  }
  
  func loadImages(completionClosure: @escaping (Bool, [String]?) -> Void) {
    do {
      if let file = Bundle.main.url(forResource: "images", withExtension: "json") {
        let data = try Data(contentsOf: file)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        if let object = json as? [String] {
          completionClosure(true, object)
        } else {
          completionClosure(false, nil)
        }
      } else {
        completionClosure(false, nil)
      }
    } catch {
      completionClosure(false, nil)
    }
  }
}
