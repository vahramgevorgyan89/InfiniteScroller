//
//  Networkable.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

protocol Networkable {
    init(httpHeaders: [AnyHashable : Any])
    var session: URLSession { get }
    var currentTask: URLSessionDataTask? { get }
    func makeRequest<T: ResponseModel>(with urlComponents: URLComponents, responseType: T.Type, result: @escaping (T?, Error?) -> Void)
}
