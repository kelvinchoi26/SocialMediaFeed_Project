//
//  FeedResponseDTO.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation

struct FeedResponseDTO: Decodable {
    let id: String
    let influencer: Influencer
    let contents: [Content]
    let likeCount: Int
    let description: String
}

