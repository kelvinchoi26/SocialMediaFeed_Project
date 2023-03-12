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
    
    init(contentURL: String, type: String) {
        self.contentURL = contentURL
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case contentURL = "content_url"
        case type
    }
}
