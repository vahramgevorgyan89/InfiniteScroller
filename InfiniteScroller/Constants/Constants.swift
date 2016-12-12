//
//  Constants.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static let tooltipCellStoryboardID = "ToolTipViewController"
    static let tooltipColor = UIColor(colorLiteralRed: 41.0 / 255.0, green: 192.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    static let gettyCellIdentifier = "gettyImageCell"
    static let gettyCellXibName = "GettyImageTableViewCell"
    static let paginationSizePerPage = 20
    static let networkingHeaders = ["Api-Key": "s4t28xcvj4q7rrpgsea2bgv6"]
    static let baseURL = "https://api.gettyimages.com:443/v3/search/images"
    /* Maximum number operation that Getty API can handle per second - best performance achieved using this number of concurrent operations
     */
    static let maxDownloadOperations = 5
}
