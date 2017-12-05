//
//  Failure.swift
//  InstagramThanksys
//
//  Created by Hubert LABORDE on 02/12/2017.
//  Copyright © 2017 Hubert LABORDE. All rights reserved.
//

import UIKit

/*
 This class refer all failure posssible and return by the server
 */


public enum FailureReason:Int {
    case NoConnection = 888
    
    
    public func printable() -> String {
        switch self {
            
        case .NoConnection:
            return "There is a connecton error"
        }
    }
    
    public func action() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        _ = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            print("User did click Ok button")
        }
        
        let shieeeetAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            print("Unknown error...")
        }
        
        switch self {
            
        case .NoConnection:
            alert.title = "Connection error"
            alert.message = "Please verify your internet connection."
            alert.addAction(shieeeetAction)
            showAlert(alert: alert)
        }
        
    }
    
    private func showAlert(alert: UIAlertController) {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
}

public typealias FailureHandler = (_ reason:FailureReason, _ error: NSError) -> ()



