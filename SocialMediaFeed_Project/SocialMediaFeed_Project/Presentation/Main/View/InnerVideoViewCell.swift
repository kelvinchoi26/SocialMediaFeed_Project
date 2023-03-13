//
//  InnerVideoVIewCell.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/12.
//

import UIKit
import AVFoundation
import RxSwift

final class InnerVideoViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "InnerVideoViewCell"
    
    var post: Post?
    var content: Content?
    
    var videoPlayer: AVPlayer?
    let playerLayer = AVPlayerLayer()
    
    let volumeButton = UIButton()
    
    let influencerName = UILabel()
    let influencerProfile = UIImageView()
    
    let likeButton = UIButton()
    
    let followButton = UIButton()
    
    let moreInfo = UIImageView()
    
    let descriptionTextView = UITextView()
    
    let videoContainer = UIView()
    
    // MARK: - Overridden Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 이미지가 설정된 이후에 cornerRadius 설정
        influencerProfile.layer.cornerRadius = influencerProfile.frame.width / 2
        influencerProfile.clipsToBounds = true
    }
    
    override func bind() {
        super.bind()
        
        // 볼륨 버튼 탭하는 경우 디바이스 음소거 적용
        volumeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.toggleMute()
            })
            .disposed(by: disposeBag)
        
        viewModel.isMuted
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isMuted in
                print("❤️❤️❤️❤️❤️")
                self?.videoPlayer?.volume = isMuted ? 0.0 : 1.0
            })
            .disposed(by: disposeBag)
    }
    
    // 영상 탭하는 경우 디바이스 음소거 적용
    override func setupVolumeButtonTap() {
        super.setupVolumeButtonTap()
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupVolumeButtonTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Attributes
    override func configureUI() {
        videoPlayer?.do {
            $0.volume = 1.0
            $0.play()
        }
        
        playerLayer.do {
            $0.player = videoPlayer
            $0.frame = contentView.bounds
            
            // 영상 비율 지키면서 화면 채움
            $0.videoGravity = .resizeAspectFill
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
        
        videoContainer.layer.addSublayer(playerLayer)
        contentView.clipsToBounds = true
        
        [videoContainer, volumeButton, moreInfo, followButton, likeButton, descriptionTextView, influencerProfile, influencerName].forEach {
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

extension InnerVideoViewCell {
    func configureVideoCell(with post: Post, content: Content) {
        self.post = post
        self.content = content

        guard let videoURL = URL(string: content.contentURL) else { print("유효하지 않은 영상 URL!")
            return
        }
        
        print(videoURL)

        DispatchQueue.main.async { [weak self] in
            self?.videoPlayer = AVPlayer(url: videoURL)
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
            self?.likeButton.setTitle(String(post.likeCount.toThousands()), for: .normal)
            self?.likeButton.alignTextBelow()
            self?.followButton.setTitle(String(post.influencer.followCount.toThousands()), for: .normal)
            self?.followButton.alignTextBelow()
            self?.configureUI()
        }
    }
}
