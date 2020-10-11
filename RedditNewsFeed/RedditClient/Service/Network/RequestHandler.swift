//
//  RequestHandler.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation

class RequestHandler {
    func networkResult<T: Parceable>(completion: @escaping (Result<T, ErrorResult>) -> Void) -> (Result<Data, ErrorResult>) -> Void {
        return { dataResult in
            DispatchQueue.global(qos: .background).async {
                switch dataResult {
                case .success(let data):
                    ParseHelper.parse(data: data, completion: completion)
                    break
                case .failure(let error):
                    completion(.failure(.network(string: "Network error: \(error.localizedDescription)")))
                }
            }
        }
    }
}
