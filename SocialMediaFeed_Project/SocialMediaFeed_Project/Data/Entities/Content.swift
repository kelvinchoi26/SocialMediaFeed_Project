//
//  Content.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation

struct Content: Codable {
    let url: String
    let type: String
    
    init(url: String, type: String) {
        self.url = url
        self.type = type
    }
}
