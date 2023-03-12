//
//  UIView+Extension.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/12.
//

import UIKit

extension UIView {
    func shadowEffect() {
        // Add shadow effect
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
    }
}
