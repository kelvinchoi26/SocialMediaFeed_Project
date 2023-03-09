//
//  BaseView.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit
import SnapKit
import Then

class BaseView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Attributes
    func setAttributes() {}
    
    // MARK: - Constraints
    func setConstraints() {}
}
