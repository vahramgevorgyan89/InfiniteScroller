//
//  DownloadImageOperation.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

class DownloadImageOperation: Operation {
    var imageData: Data?
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    override func main() {
        
        if let data = LocalCache.sharedInstance.getObject(for: url as AnyObject) {
            imageData = data as? Data
            return
        }
        
        if self.isCancelled {
            return
        }
        
        imageData = try? Data(contentsOf: self.url)
        
        if imageData != nil {
            LocalCache.sharedInstance.setObject(obj: imageData as AnyObject, forKey: url as AnyObject)
        }
    }
}
