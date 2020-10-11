//
//  ParseHelper.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation
protocol Parceable {
    static func parseObject(data: Data) -> Result<Self, ErrorResult>
}

final class ParseHelper {
    static func parse<T: Parceable>(data: Data, completion: (Result<T, ErrorResult>) -> Void) {
            switch T.parseObject(data: data) {
            case .success(let newValue):
                completion(.success(newValue))
            case .failure(let error):
                completion(.failure(.parser(string: "Errro while parsing data: \(error.localizedDescription)")))
            }
    }
}

