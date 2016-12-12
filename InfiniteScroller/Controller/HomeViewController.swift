//
//  HomeViewController.swift
//  InfiniteScroller
//
//  Created by Vahram Gevorgyan on 12/10/16.
//  Copyright © 2016 gevorgyan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    private let operationQueue: OperationQueue = {
        let operationsQueue = OperationQueue()
        operationsQueue.maxConcurrentOperationCount = Constants.maxDownloadOperations
        return operationsQueue
    }()
    
    private var downloadImageOperations: [DownloadImageOperation] = [DownloadImageOperation]()
    var dataModel: [GettyImageResponse] = [GettyImageResponse]()
    var searchPhrase: String? = nil
    private let networkHandler = NetworkingHandler(httpHeaders: Constants.networkingHeaders)

    
    var totalSearchCount: Int = 0 {
        didSet {
            self.searchBar.prompt = "\(totalSearchCount) results found"
        }
    }
    var downloadDataQuery: GettyDataRequestQuery {
        return GettyDataRequestQuery(params: GettyDataRequestParams(currentPage: self.currentPage, searchPhrase: self.searchPhrase));
    }
    
    var currentPage = 1 {
        didSet {
            self.downloadDataWithQuery(downloadQuery: self.downloadDataQuery)
        }
    }
    
    override func viewDidLayoutSubviews() {
        let superViewBounds = self.activityIndicator.superview?.bounds ?? CGRect.zero
        self.activityIndicator.center = CGPoint(x: superViewBounds.size.width / 2, y: superViewBounds.size.height  / 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: Constants.gettyCellXibName, bundle: nil), forCellReuseIdentifier: Constants.gettyCellIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        self.addActivityIndicator()
        self.downloadDataWithQuery(downloadQuery: self.downloadDataQuery)
    }
    
    func addActivityIndicator() {
        let heightOffset: CGFloat = 10.0
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.activityIndicator.frame.size.height + heightOffset))
        view.backgroundColor = UIColor.clear
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        self.tableView.tableFooterView = view
    }
    
    func downloadDataWithQuery(downloadQuery: GettyDataRequestQuery) {
        self.activityIndicator.startAnimating()
        networkHandler.makeRequest(with: downloadQuery.urlComponents, responseType: GettyResponse.self) { [unowned self] result, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                guard let images = result?.images else { return }
                
                self.totalSearchCount = result?.resultCount ?? 0
                self.dataModel  = self.dataModel + images
                
                self.tableView.insertRows(at: (images.convertToIndexPath(withIncrement: self.tableView.numberOfRows(inSection: 0) , section: 0)), with: .bottom)
            }
        }
    }

    func downloadImagesFor(indexes: [IndexPath]) {
        for indexPath in indexes {
            guard let currentURL =  self.dataModel[indexPath.row].url,
                let encodedURL = currentURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let encodedURLString = URL(string: encodedURL) else {
                    continue
            }
            
            let downloadOperation = DownloadImageOperation(url: encodedURLString)
            self.downloadImageOperations.append(downloadOperation)
            
            downloadOperation.completionBlock = { [weak downloadOperation, weak tableview = self.tableView] in
                DispatchQueue.main.async {
                    guard let data = downloadOperation?.imageData,
                        let cell = tableview?.cellForRow(at: indexPath) as? GettyImageTableViewCell else {
                            return
                    }
                    cell.gettyImageView?.image = UIImage(data: data)
                    cell.setNeedsLayout()
                }
            }
            operationQueue.addOperation(downloadOperation)
        }
    }
    
    func cancelAllOperations() {
        self.operationQueue.cancelAllOperations()
        self.downloadImageOperations.removeAll()
    }
    
    func resetSearch() {
        self.cancelAllOperations()
        self.dataModel.removeAll()
        self.tableView.reloadData()
        self.currentPage = 1
    }

}

