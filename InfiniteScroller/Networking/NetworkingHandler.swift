//
//  NetworkingHandler.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

class NetworkingHandler: Networkable {
    let session: URLSession
    var currentTask: URLSessionDataTask?
    required init(httpHeaders: [AnyHashable : Any]) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = httpHeaders
        session = URLSession(configuration: sessionConfig)
    }
    
    func makeRequest<T: ResponseModel>(with urlComponents: URLComponents, responseType: T.Type, result: @escaping (T?, Error?) -> Void) {
        currentTask?.cancel()
        guard let url = urlComponents.url else { result(nil, NSError(domain: "Unable to construct url", code: 1, userInfo: nil)); return }
        let requestURL = URLRequest(url: url)
        currentTask = session.dataTask(with: requestURL) { data, response, error in
            
            if error != nil {
                result(nil, error!)
            }
            
            guard let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
                let finalData =  jsonData as? NSDictionary else {
                    result(nil, NSError(domain: "Unable to construct json", code: 2, userInfo: nil))
                    return
            }
            
            let parsedResult = responseType.init(response: finalData)
            result(parsedResult, nil)
        }
        currentTask?.resume()
    }
}
