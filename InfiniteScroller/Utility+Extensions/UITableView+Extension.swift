//
//  UITableView+Extension.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {    
    func configurePopoverFor(indexPath: IndexPath, color: UIColor, popover: UIViewController)  {
        let sourceRect = self.cellForRow(at: indexPath)?.bounds ?? CGRect.zero
        popover.popoverPresentationController?.sourceView = self.cellForRow(at: indexPath)
        popover.popoverPresentationController?.sourceRect = sourceRect
        popover.popoverPresentationController?.backgroundColor = color
        popover.preferredContentSize = CGSize(width: sourceRect.size.width * 0.8, height: sourceRect.size.height / 2)
    }
}
