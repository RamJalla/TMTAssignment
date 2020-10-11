//
//  NewsFeedDataSource.swift
//  RedditClient
//
//  Created by Ram Jalla on 09/10/20.
//

import Foundation
import UIKit

class NewsFeedDataSource: GenericDataSource<FeedChild>, UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = data.value.count
        //showing the spinner while fetching data
        if count == 0 {
            tableView.showSpinner()
        } else {
            tableView.hideSpinner()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell", for: indexPath) as! NewsFeedTableViewCell
        let feed = data.value[indexPath.row]
        cell.configure(with: feed.data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Fetching more data when user scrolls to last row
        if indexPath.row == data.value.count - 1 {
            delegate?.shouldFetchMoreFeeds?()
        }
    }
    
    
}
