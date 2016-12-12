//
//  GettyDataRequestQuery.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

struct GettyDataRequestParams {
    let currentPage: Int
    let searchPhrase: String?
}

struct GettyDataRequestQuery {
    
    let params: GettyDataRequestParams
    
    init(params: GettyDataRequestParams) {
        self.params = params
    }
    var queryItem: [URLQueryItem] {
        var queryItems = [
            URLQueryItem(name: "page", value: String(params.currentPage)),
            URLQueryItem(name: "page_size", value: String(Constants.paginationSizePerPage))
            
        ]
        if params.searchPhrase != nil {
            queryItems.append(URLQueryItem(name: "phrase", value: String(params.searchPhrase!)))
        }
        return queryItems
    }
    
    var urlComponents: URLComponents  {
        var urlComps =  URLComponents(string: Constants.baseURL)!
        urlComps.queryItems = self.queryItem
        return urlComps
    }
}
