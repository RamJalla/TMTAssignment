//
//  GenericValue.swift
//  RedditClient
//
//  Created by Ram Jalla on 09/10/20.
//

import Foundation

@objc
protocol GenericDataSourceDelegate:class {
    @objc optional func shouldFetchMoreFeeds()
}

class GenericDataSource<T>: NSObject {
    weak var delegate: GenericDataSourceDelegate?
    var data: GenericValue<[T]> = GenericValue([])
}

class GenericValue<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    var value: T {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String : CompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    func notify() {
        observers.forEach({$0.value(value)})
    }
    
    deinit {
        observers.removeAll()
    }
}
