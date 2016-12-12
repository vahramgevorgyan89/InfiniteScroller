//
//  GettyImageResponse.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

class GettyImageResponse: ResponseModel {
    let id: String?
    let caption: String?
    let title: String?
    let url: String?
    
    required init(response: NSDictionary) {
        id = response.object(forKey: "id") as? String
        caption = response.object(forKey: "caption") as? String
        title = response.object(forKey: "title") as? String
        url = ((response.object(forKey: "display_sizes") as? NSArray)?.firstObject as? NSDictionary)?.object(forKey: "uri") as? String
        
    }
}
