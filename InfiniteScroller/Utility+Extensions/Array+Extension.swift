//
//  Array+Extension.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation

extension Array {
    func convertToIndexPath(withIncrement: Int = 0, section: Int = 0) -> [IndexPath] {
        var tempIndexPathArray = [IndexPath]()
        for (index, _) in self.enumerated() {
            tempIndexPathArray.append(IndexPath(row: index + withIncrement, section: section))
        }
        return tempIndexPathArray
    }
}
