//
//  Item.swift
//  InstagramThanksys
//
//  Created by Hubert LABORDE on 02/12/2017.
//  Copyright © 2017 Hubert LABORDE. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SwiftyJSON
import AFDateHelper

public protocol ResponseObjectSerializable {
    init?(json: JSON)
}

public protocol ResponseCollectionSerializable {
    static func collection(json: JSON) -> [Self]
}

public final class  Item: Object, ResponseObjectSerializable, ResponseCollectionSerializable {
    
    @objc dynamic var id: String?
    @objc dynamic var type: String?
    @objc dynamic var url: String?
    @objc dynamic var date: Date?
    
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    
    public init?(json: JSON) {
        super.init()
        for (_,_):(String, JSON) in json {
            if let id =  json["id"].string {
                self.id = id
            }
            if let type =  json["type"].string {
                self.type = type
            }
            
            let date  = json["created_time"].intValue
            let dateFormat = date.dateFromMilliseconds()
            self.date = dateFormat
            
            for (_, subJsonImg) in json["images"] {
                if let url_thumbnail =  subJsonImg["url"].string {
                    self.url = url_thumbnail
                }
            }
        }
    }
    
    public init?(id: String?, type: String?, url: String?, date: Date?) {
        super.init()
        self.id = id
        self.type = type
        self.url = url
        self.date = date
        
    }
    
    required public init() {
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
        
    }
    
    required public init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    public static func collection(json: JSON) -> [Item] {
        var items: [Item] = []
        for (_,subJson):(String, JSON) in json["data"] {
            if let item = Item(json: subJson) {
                items.append(item)
            }
        }
        
        return items
    }
    
    public func toJSON() -> Dictionary<String, AnyObject> {
        var dict = [String:AnyObject]()
        if id != nil {
            dict["id"] = self.id as AnyObject
        }
        if type != nil {
            dict["type"] = self.type as AnyObject
        }
        if url != nil {
            dict["url"] = self.url as AnyObject
        }
        if date != nil {
            dict["created_time"] = self.date as AnyObject
        }
        return dict
    }
}
