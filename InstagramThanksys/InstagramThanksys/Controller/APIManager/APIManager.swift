
//
//  APIManager.swift
//  InstagramThanksys
//
//  Created by Hubert LABORDE on 02/12/2017.
//  Copyright © 2017 Hubert LABORDE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class Network {
    
    public static let sharedInstance = Network()
    
    public var items = [Item]()
    
    static let baseUrl = "http://www.laborde-hubert.com"
    
    public func getPictures(success:@escaping ([Item]) -> Void, failureType: @escaping FailureHandler) {
        let url:String = "\(Network.baseUrl)/instagram.json"
        //if(isReachable()) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON {response in
                if (response.result.isSuccess) {
                    let json = JSON(response.data as Any)
                    if json != "" {
                        let item = Item.collection(json: json)
                        success(item)
                    }
                } else {
                    print("! error has occured: \(String(describing: response.error))")
                }
        }
    }
    
    public func isReachable() -> Bool {
        if SSASwiftReachability.sharedManager?.isReachable() == true {
            print("We have internet!!!")
            return true
        } else {
            print("Check your internet connection!!!")
            return false
        }
    }
}
