//
//  RequestService.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation

final class RequestService {
    
    func loadData(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>)-> Void) -> URLSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong URL format")))
            return nil
        }
        let request = RequestFactory.request(method: .GET, url: url)
        
        //TODO:- implement reachabily here if required
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.network(string: "Error while requesting: \(error!.localizedDescription)")))
                return
            }
            completion(.success(data))
        }
        task.resume()
        return task
    }
}
