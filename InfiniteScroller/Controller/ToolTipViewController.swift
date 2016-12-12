//
//  ToolTipViewController.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/11/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import UIKit
import Foundation

class ToolTipViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var captionText: String = ""
    
    @IBOutlet weak var captionTextView: UITextView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = .any

    }
    
    override func viewDidLayoutSubviews() {
        self.captionTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.captionTextView.text = self.captionText
    }
}
