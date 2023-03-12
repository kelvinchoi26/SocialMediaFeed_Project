//
//  FeedImageViewCell.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit

final class FeedImageViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "FeedImageViewCell"
    
    var post: Post?
    var content: Content?
    
    let contentImageView = UIImageView()
    
    let volumeButton = UIButton()
    
    let influencerName = UILabel()
    let influencerProfile = UIImageView()
    
    let likeButton = UIButton()
    
    let followButton = UIButton()
    
    let moreInfo = UIImageView()
    
    let descriptionTextView = UITextView()
    
    let imageContainer = UIView()
    
    // MARK: - Overridden Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 이미지가 설정된 이후에 cornerRadius 설정
        influencerProfile.layer.cornerRadius = influencerProfile.frame.width / 2
        influencerProfile.clipsToBounds = true
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Attributes
    override func configureUI() {
        contentImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        volumeButton.do {
            $0.setImage(UIImage(named: "speaker.wave.2.fill"), for: .normal)
            $0.backgroundColor = .clear
            $0.tintColor = .white
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        likeButton.do {
            $0.setImage(UIImage(named: "heart.fill"), for: .normal)
            $0.backgroundColor = .clear
            $0.tintColor = .white
            
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = Constants.Font.MediumFont
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        followButton.do {
            $0.setImage(UIImage(named: "person.crop.circle.badge.plus"), for: .normal)
            $0.backgroundColor = .clear
            $0.tintColor = .white
            
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = Constants.Font.MediumFont
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        moreInfo.do {
            $0.image = UIImage(named: "ellipsis")
            $0.tintColor = .white
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        influencerProfile.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.clipsToBounds = true
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        influencerName.do {
            $0.font = Constants.Font.MediumFont
            $0.textColor = .white
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        descriptionTextView.do {
            $0.font = Constants.Font.RegularFont
            $0.textColor = .white
            $0.backgroundColor = .clear
            
            // Add shadow effect
            $0.shadowEffect()
        }
        
        contentView.addSubview(contentImageView)
        contentView.clipsToBounds = true
        
        [contentImageView, volumeButton, moreInfo, followButton, likeButton, descriptionTextView, influencerProfile, influencerName].forEach {
            contentView.addSubview($0)
        }
        
        // 이미지가 다른 components보다 뒤로 위치되게
        contentView.sendSubviewToBack(contentImageView)
    }
    
    // MARK: - Constraints
    override func setConstraints() {
        contentImageView.frame = contentView.bounds
        
        volumeButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
        moreInfo.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(100)
        }
        
        followButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(1)
            $0.bottom.equalTo(moreInfo.snp.top).offset(-25)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(1)
            $0.bottom.equalTo(followButton.snp.top).offset(-25)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.65)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.06)
            $0.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        influencerProfile.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.04)
            $0.bottom.equalTo(descriptionTextView.snp.top)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(18)
        }
        
        influencerName.snp.makeConstraints {
            $0.leading.equalTo(influencerProfile.snp.trailing).offset(10)
            $0.bottom.equalTo(descriptionTextView.snp.top).offset(-5)
        }
    }
}

extension FeedImageViewCell {
    func configureImageCell(with post: Post, content: Content) {
        self.post = post
        self.content = content
        
        guard let imageURL = URL(string: content.contentURL) else { print("유효하지 않은 이미지 URL!")
            return
        }
        
        // 이미지 URL에서 불러오는 작업은 메인 쓰레드에서 진행하지 않도록
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.contentImageView.image = image
                    }
                }
            }
        }
        
        guard let influencerURL = URL(string: post.influencer.profileThumbnailUrl) else { print("유효하지 않은 인플루언서 이미지 URL!")
            return
        }
        
        // 이미지 URL에서 불러오는 작업은 메인 쓰레드에서 진행하지 않도록
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: influencerURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.influencerName.text = post.influencer.displayName
                        self?.influencerProfile.image = image
                    }
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.descriptionTextView.text = post.description
            self?.likeButton.setTitle(String(post.likeCount), for: .normal)
            self?.likeButton.alignTextBelow()
            self?.followButton.setTitle(String(post.influencer.followCount), for: .normal)
            self?.followButton.alignTextBelow()
        }
    }
}
