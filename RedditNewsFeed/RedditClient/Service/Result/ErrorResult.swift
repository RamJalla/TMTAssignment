//
//  ErrorResult.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
