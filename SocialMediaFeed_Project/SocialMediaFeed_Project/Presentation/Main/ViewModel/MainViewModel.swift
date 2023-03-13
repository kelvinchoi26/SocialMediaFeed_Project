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
    var currentPage: Int = 0
    
    // BehaviorRelay - 항상 현재 값을 지니고 있음
    var posts = BehaviorRelay<[Post]>(value: [])
    var isMuted = BehaviorRelay<Bool>(value: false)
    var currentCellIndexPath = BehaviorSubject<IndexPath?>(value: nil)
    
    // MARK: - Methods
    func fetchContents(page: Int) -> Single<[Post]> {
        self.currentPage = page
        
        return Single.create { [weak self] single in
            self?.service.fetchPosts(page: page) { result in
                switch result {
                case .success(let data):
                    let posts = data.returnPosts()
                    single(.success(posts))
                    
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func fetchNextPage() -> Single<[Post]> {
        let nextPage = currentPage + 1
        
        return fetchContents(page: nextPage).map { [weak self] posts -> [Post] in
            guard let self = self else { return [] }
            
            self.posts.accept(self.posts.value + posts)
            self.currentPage += 1
            return posts
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
