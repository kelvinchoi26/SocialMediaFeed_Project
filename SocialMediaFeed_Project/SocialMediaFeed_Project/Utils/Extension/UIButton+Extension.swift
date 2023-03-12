//
//  UIButton+Extension.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/11.
//

import UIKit

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 1.0) {
        guard let image = self.imageView else {
            return
        }
        
        guard let titleLabel = self.titleLabel else {
            return
        }
        
        guard let titleText = titleLabel.text else {
            return
        }
        
        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])
        
        let imageOffsetX = (self.bounds.width - image.frame.width) / 2.0
        let imageOffsetY = (self.bounds.height - image.frame.height - titleSize.height - spacing) / 2.0
        imageEdgeInsets = UIEdgeInsets(top: imageOffsetY - 15, left: imageOffsetX - 8, bottom: 0, right: -imageOffsetX + 8)
        titleEdgeInsets = UIEdgeInsets(top: imageOffsetY + image.frame.height + spacing, left: -image.frame.width - 15, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: -imageOffsetX + 5, bottom: 0, right: -imageOffsetX + 5)
        titleLabel.textAlignment = .center
    }
}
