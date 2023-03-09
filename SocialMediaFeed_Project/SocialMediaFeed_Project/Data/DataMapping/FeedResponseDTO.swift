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
        var postList = [Post]()
        
        posts.forEach {
            $0.contents
        }
    }
}



