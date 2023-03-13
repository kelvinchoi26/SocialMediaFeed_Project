//
//  Post.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation

struct Post: Codable {
    let id: String
    let influencer: Influencer
    let contents: [Content]
    let likeCount: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, influencer, contents, description
        case likeCount = "like_count"
    }
}
