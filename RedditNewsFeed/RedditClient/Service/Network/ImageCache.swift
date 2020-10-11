//
//  ImageCache.swift
//  RedditClient
//
//  Created by Ram Jalla on 10/10/20.
//

import Foundation
import UIKit

public class ImageCache {
    
    typealias CompletionHandler = (UIImage?) -> Void
    static let shared = ImageCache()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [URL : [CompletionHandler]]()
    
    public final func image(at url: NSURL) -> UIImage? {
        cachedImages.object(forKey: url)
    }
    
    final func load(url: URL, completion:@escaping CompletionHandler) {
        
        // Check for a cached image.
        if let cachedImage = image(at: url as NSURL) {
            DispatchQueue.global().async {
                completion(cachedImage)
            }
            return
        }
        
        // if we already having requests append it otherwise add completion
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
        }else {
            loadingResponses[url] = [completion]
        }
        
        // fetch the image from server
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data), let blocks = self.loadingResponses[url] else {
                print("Error while fetching image: \(String(describing: error?.localizedDescription))")
                completion(nil)
                return
            }
            // cache the image
            self.cachedImages.setObject(image, forKey: url as NSURL)
            blocks.forEach({$0(image)})
        }
        task.resume()
    }
}
