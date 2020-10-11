//
//  NewsFeedViewController.swift
//  RedditClient
//
//  Created by Ram Jalla on 09/10/20.
//

import UIKit

class NewsFeedViewController: UIViewController {

    let dataSource = NewsFeedDataSource()
    
    var tableView: UITableView?
    
    lazy var viewModel: NewsFeedViewModel = {
        let model = NewsFeedViewModel(dataSource: dataSource)
        return model
    }()
    
    override func loadView() {
        super.loadView()
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView!)
        tableView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView?.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "newsFeedCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self.dataSource
        tableView?.delegate = self.dataSource
        self.viewModel.dataSource?.data.addAndNotify(observer: self, completionHandler: { (feeds) in
            OperationQueue.main.addOperation {
                self.tableView?.reloadData()
            }
        })
        
        self.viewModel.onErrorHandling = { [weak self] error in
            OperationQueue.main.addOperation {
                let controller = UIAlertController(title: "An error occured", message: error?.localizedDescription, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self?.present(controller, animated: true, completion: nil)
            }
        }
        
        self.viewModel.fetchFeeds()
        
    }


}

