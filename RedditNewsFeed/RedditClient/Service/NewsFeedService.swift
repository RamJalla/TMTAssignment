//
//  NewsFeedService.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation

final class NewsFeedService: RequestHandler {
    
    static let shared = NewsFeedService()
    private let sourceURLString = "https://www.reddit.com/.json"
    
    var task: URLSessionTask?
    
    func fetchFeeds(after: String? = nil, completion: @escaping (Result<FeedObject, ErrorResult>) -> Void) {
        // cancel fetching if already requested
        cancelFetchFeeds()
        var urlStr = sourceURLString
        if let after = after {
            urlStr += "?after=\(after)"
        }
        task = RequestService().loadData(urlString: urlStr, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchFeeds() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
    
}
