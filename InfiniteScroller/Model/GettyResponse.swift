//
//  GettyResponse.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

class GettyResponse: ResponseModel {
    let resultCount: Int?
    let images: [GettyImageResponse]?
    required init(response: NSDictionary) {
        resultCount = response.object(forKey: "result_count") as? Int
        guard let imagesJSON = response.object(forKey: "images") as? NSArray else { self.images = nil; return }
     
        var tempImages: [GettyImageResponse] = [GettyImageResponse]()
        
        for imageData in imagesJSON where imageData is NSDictionary {
            let imageResponse = GettyImageResponse(response: imageData as! NSDictionary)
            tempImages.append(imageResponse)
        }
        self.images = tempImages
    }
}
