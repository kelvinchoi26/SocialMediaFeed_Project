//
//  MainViewModel.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation
import RxSwift
import RxCocoa

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
        isMuted.accept(!isMuted.value)
    }
    
}
