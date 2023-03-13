//
//  Content.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation

struct Content: Codable {
    let contentURL: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case contentURL = "content_url"
        case type
    }
}
