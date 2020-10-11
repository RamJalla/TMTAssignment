//
//  NewsFeedViewModel.swift
//  RedditClient
//
//  Created by Ram Jalla on 09/10/20.
//

import Foundation
import UIKit

class NewsFeedViewModel: NSObject {
    
    weak var service: NewsFeedService?
    weak var dataSource: GenericDataSource<FeedChild>?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    private var isFetching: Bool = false
    private var after: String?

    init(with service: NewsFeedService = NewsFeedService.shared, dataSource: GenericDataSource<FeedChild>?) {
        super.init()
        self.dataSource = dataSource
        self.dataSource?.delegate = self
        self.service = service
    }
    
    func fetchFeeds(after: String? = nil) {
        guard !isFetching else {
            print("Feeds already being fetched")
            return
        }
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "No service available"))
            return
        }
        isFetching = true
        service.fetchFeeds(after: after) { (result) in
            self.isFetching = false
            DispatchQueue.global().async {
                switch result {
                case .success(let feedObject):
                    self.after = feedObject.data.after
                    self.dataSource?.data.value.append(contentsOf: feedObject.data.children)
                case .failure(let error):
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}

//MARK:- GenericDataSourceDelegate
extension NewsFeedViewModel: GenericDataSourceDelegate {
    func shouldFetchMoreFeeds() {
        fetchFeeds(after: self.after)
    }
}
