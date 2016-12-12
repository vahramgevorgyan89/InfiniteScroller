//
//  HomeViewController+UISearchBarDelegate.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/12/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchPhrase = self.searchBar.text
        searchBar.resignFirstResponder()
        self.resetSearch()
    }
}
