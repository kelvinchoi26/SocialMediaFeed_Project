//
//  FeedResponseDTO.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation

struct FeedResponseDTO: Decodable {
    let count: Int
    let page: Int
    let posts: [Post]
}

extension FeedResponseDTO {
    func returnPosts() -> [Post] {
        return posts.map {
            Post(id: $0.id, influencer: $0.influencer, contents: $0.contents, likeCount: $0.likeCount, description: $0.description)
        }
    }
}



