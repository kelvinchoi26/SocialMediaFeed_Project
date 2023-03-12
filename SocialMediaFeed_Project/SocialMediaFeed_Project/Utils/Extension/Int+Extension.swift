//
//  String+Extension.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/13.
//

import Foundation

extension Int {
    func toThousands() -> String {
        var result: String
        
        if self < 1000 {
            result = String(self)
        } else {
            result = String(format: "%.1f", Double(self)/1000) + "k"
        }
        
        return result
    }
}
