//
//  LocalCache.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

class LocalCache {
    static let sharedInstance : LocalCache = LocalCache()
    
    private init() {}
    
    var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
    func setObject(obj: AnyObject, forKey: AnyObject) {
        self.cache.setObject(obj, forKey: forKey)
    }
    func getObject(for key: AnyObject) -> AnyObject? {
        return self.cache.object(forKey: key)
    }
}
