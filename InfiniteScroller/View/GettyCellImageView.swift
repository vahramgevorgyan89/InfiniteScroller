//
//  GettyCellImageView.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation
import UIKit

class GettyCellImageView: UIImageView {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func layoutSubviews() {
        activityIndicator.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
    }
    
    override func awakeFromNib() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    override var image: UIImage? {
        didSet {
            image == nil  ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
}
