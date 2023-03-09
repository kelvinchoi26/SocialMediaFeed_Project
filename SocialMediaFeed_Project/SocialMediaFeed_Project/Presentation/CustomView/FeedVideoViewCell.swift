//
//  FeedViewCell.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit
import AVFoundation

final class FeedVideoViewCell: BaseCollectionViewCell {
    
    static let reuseIdentifier = "FeedVideoViewCell"
    
    private var post: Post?
    
    let urlPath = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")
    
    var videoPlayer: AVPlayer?
    let playerLayer = AVPlayerLayer()
    
    let influencerName = UILabel()
    let influencerProfile = UIImageView()
    
    let likeButton = UIButton()
    let likeCount = UILabel()
    
    let followCount = UILabel()
    
    let moreInfo = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        contentView.layer.addSublayer(playerLayer)
        contentView.backgroundColor = .red
        contentView.clipsToBounds = true
    }
}

extension FeedVideoViewCell {
    
    public func loadVideo(url: String) {
        guard let urlPath = URL(string: url) else { print("로드 안된다 임마")
            return
        }
        
        print(urlPath)

        videoPlayer = AVPlayer(url: urlPath)
    }
}
