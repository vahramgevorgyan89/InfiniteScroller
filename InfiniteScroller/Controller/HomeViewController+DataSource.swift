//
//  HomeViewController+DataSource.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.gettyCellIdentifier) as! GettyImageTableViewCell
        cell.gettyTitle.text = self.dataModel[indexPath.row].title ?? "No Title"
        cell.gettyID.text = self.dataModel[indexPath.row].id ?? "No ID"
        cell.gettyImageView.image = nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.image = nil
        self.downloadImagesFor(indexes: [indexPath])
        
        let row = indexPath.row
        let sum = self.currentPage * Constants.paginationSizePerPage
        
        if sum - row <= Constants.paginationSizePerPage / 2 && sum <= self.totalSearchCount {
            self.currentPage += 1
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollingFinished()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollingFinished()
    }
    
    
    func scrollingFinished() {
        self.downloadImagesFor(indexes: self.tableView.indexPathsForVisibleRows ?? [])
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.cancelAllOperations()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.cancelAllOperations()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let popover = self.storyboard?.instantiateViewController(withIdentifier: Constants.tooltipCellStoryboardID) as! ToolTipViewController
        popover.captionText = self.dataModel[indexPath.row].caption ?? "No Caption"
        self.tableView.configurePopoverFor(indexPath: indexPath, color: Constants.tooltipColor, popover: popover)
        self.present(popover, animated: true, completion: nil)
    }
    
}

