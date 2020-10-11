//
//  Result.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
