//
//  Influencer.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation

struct Influencer {
    let displayName: String
    let profileThumbnailUrl: String
    let followCount: Int
    
    init(displayName: String, profileThumbnailUrl: String, followCount: Int) {
        self.displayName = displayName
        self.profileThumbnailUrl = profileThumbnailUrl
        self.followCount = followCount
    }
}
