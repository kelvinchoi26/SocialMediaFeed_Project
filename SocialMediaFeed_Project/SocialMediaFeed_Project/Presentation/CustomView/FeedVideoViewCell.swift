//
//  FeedViewCell.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit
import AVFoundation

final class FeedVideoViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "FeedVideoViewCell"
    
    var post = Post(id: "1bb7dd70-21f9-4a24-9363-74788d45860c", influencer: Influencer(displayName: "Adam", profileThumbnailUrl: "https://randomuser.me/api/portraits/men/66.jpg", followCount: 28599), contents: [Content(url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", type: "video")], likeCount: 19908, description: "She discovered van life is difficult with 2 cats and a dog.")
    
    let urlPath = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")
    
    var videoPlayer: AVPlayer?
    let playerLayer = AVPlayerLayer()
    
    let volumeButton = UIImageView()
    
    let influencerName = UILabel()
    let influencerProfile = UIImageView()
    
    let likeButton = UIImageView()
    let likeCount = UILabel()
    
    let followButton = UIImageView()
    let followCount = UILabel()
    
    let moreInfo = UIImageView()
    
    let descriptionTextView = UITextView()
    
    let videoContainer = UIView()
    
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
        videoPlayer = AVPlayer(url: urlPath!)
        
        videoPlayer?.do {
            $0.volume = 0
            $0.play()
        }
        
        playerLayer.do {
            $0.player = videoPlayer
            $0.frame = contentView.bounds
            
            // 영상 비율 지키면서 화면 채움
            $0.videoGravity = .resizeAspectFill
        }
        
        volumeButton.do {
            $0.image = UIImage(named: "speaker.wave.2.fill")
            $0.backgroundColor = .clear
            $0.tintColor = .white
        }
        
        likeButton.do {
            $0.image = UIImage(named: "heart.fill")
            $0.backgroundColor = .clear
            $0.tintColor = .white
        }
        
        likeCount.do {
            $0.adjustsFontSizeToFitWidth = true
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        followButton.do {
            $0.image = UIImage(named: "person.crop.circle.badge.plus")
            $0.backgroundColor = .clear
            $0.tintColor = .white
        }
        
        followCount.do {
            $0.adjustsFontSizeToFitWidth = true
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        moreInfo.do {
            $0.image = UIImage(named: "ellipsis")
            $0.tintColor = .white
        }
        
        influencerProfile.do {
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.clipsToBounds = true
        }
        
        influencerName.do {
            $0.adjustsFontSizeToFitWidth = true
            $0.textColor = .white
        }
        
        descriptionTextView.do {
            $0.adjustsFontForContentSizeCategory = true
            $0.textColor = .white
            $0.backgroundColor = .clear
        }
        
        videoContainer.layer.addSublayer(playerLayer)
        contentView.clipsToBounds = true
        
        [videoContainer, volumeButton, moreInfo, followCount, followButton, likeCount, likeButton, descriptionTextView, influencerProfile, influencerName].forEach {
            contentView.addSubview($0)
        }
        
        videoContainer.clipsToBounds = true
        
        // videoContainer UIView를 이용해 영상/이미지가 다른 components보다 뒤로 위치되게
        contentView.sendSubviewToBack(videoContainer)
    }
    
    // MARK: - Constraints
    override func setConstraints() {
        videoContainer.frame = contentView.bounds
        
        volumeButton.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        moreInfo.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(100)
        }
        
        followCount.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(moreInfo.snp.top).inset(25)
        }
        
        followButton.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(followCount.snp.top).inset(5)
        }
        
        likeCount.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(followButton.snp.top).inset(25)
        }
        
        likeButton.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(likeCount.snp.top).inset(5)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.65)
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.06)
            $0.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        influencerProfile.snp.makeConstraints {
            $0.width.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
            $0.bottom.equalTo(descriptionTextView.snp.top).inset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        influencerName.snp.makeConstraints {
            $0.leading.equalTo(influencerProfile.snp.trailing).inset(10)
            $0.bottom.equalTo(descriptionTextView.snp.top).inset(10)
        }
    }
}

extension FeedVideoViewCell {
    
    public func loadVideo() {
        guard let urlPath = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4") else { print("로드 안된다 임마")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.videoPlayer = AVPlayer(url: urlPath)
        }
        
        let url = URL(string: "https://randomuser.me/api/portraits/men/66.jpg")
        if let data = try? Data(contentsOf: url!) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.influencerName.text = "Adam"
                    self?.influencerProfile.image = image
                }
            }
        }
        
        descriptionTextView.text = "She discovered van life is difficult with 2 cats and a dog."
        
        likeCount.text = "19908"
        followCount.text = "28599"
    }
}
