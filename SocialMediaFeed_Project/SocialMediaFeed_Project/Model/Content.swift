//
//  Content.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation

struct Content {
    let url: URL
    let type: String
    
    init(url: URL, type: String) {
        self.url = url
        self.type = type
    }
}
