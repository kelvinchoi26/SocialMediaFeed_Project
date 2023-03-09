//
//  BaseCollectionViewCell.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation
import UIKit
import SnapKit
import Then

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {}
    
    func setConstraints() {}
    
}
