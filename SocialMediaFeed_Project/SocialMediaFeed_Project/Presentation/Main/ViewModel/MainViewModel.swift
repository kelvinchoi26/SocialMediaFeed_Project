//
//  MainViewModel.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation
import RxSwift
import RxCocoa
import MediaPlayer

final class MainViewModel {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let service = FeedAPIService.shared
    
    // BehaviorRelay - 항상 현재 값을 지니고 있음
    var posts = BehaviorRelay<[Post]>(value: [])
    var isMuted = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Methods
    func fetchContents(page: Int) {
        service.fetchPosts(page: page) { result in
            switch result {
            case .success(let data):
                print(data)
                let posts = data.returnPosts()
                
                // Subscribers(구독자)한테 업데이트된 posts 전송
                self.posts.accept(posts)
                
            case .failure(let error):
                print("Error fetching Content: \(error.localizedDescription)")
            }
        }
    }
    
    func toggleMute() {
        // MPVolumeView 가져오기
        let volumeView = MPVolumeView(frame: .zero)
        
        // 볼륨 조절 슬라이더 찾기
        if let volumeSlider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider {
            // 볼륨 끄기
            if isMuted.value {
                volumeSlider.setValue(0, animated: false)
            } else { // 볼륨 켜기
                volumeSlider.setValue(1, animated: false)
            }
        }
        
        // 현재 음소거 여부 업데이트
        isMuted.accept(!isMuted.value)
    }
}
