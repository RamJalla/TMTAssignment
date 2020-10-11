//
//  Feed.swift
//  RedditClient
//
//  Created by Ram Jalla on 09/10/20.
//

import Foundation



struct FeedObject: Codable {
    var data: FeedData
    enum FeedObjectKeys: String, CodingKey {
        case data
    }
}

struct FeedData: Codable {
    var after: String?
    var children: [FeedChild]
    
    enum FeedDataCodingKeys: String, CodingKey {
        case after
        case children
    }
}

struct FeedChild: Codable {
    var data: Feed
    enum FeedChildKeys: String, CodingKey {
        case data
    }
}

struct Thumbnail: Codable {
    var url: String?
}

struct Feed {
    var title: String?
    var commentsCount: Int?
    var score: Int?
    var thumbnail: Thumbnail?
    private var url: String?
}

extension Feed: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case score
        case commentsCount = "num_comments"
        case url = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        score = try values.decode(Int.self, forKey: .score)
        commentsCount = try values.decode(Int.self, forKey: .commentsCount)
        url = try values.decode(String.self, forKey: .url)
        thumbnail = Thumbnail(url: url)
    }
}

extension FeedObject: Parceable {
    static func parseObject(data: Data) -> Result<FeedObject, ErrorResult> {
        do {
            let feedObject = try JSONDecoder().decode(FeedObject.self, from: data)
            return .success(feedObject)
        }catch {
            return .failure(.parser(string: error.localizedDescription))
        }
    }
}
