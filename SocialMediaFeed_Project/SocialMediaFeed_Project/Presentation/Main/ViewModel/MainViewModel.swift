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
    
    var posts = BehaviorRelay<[Post]>(value: [])
    
    // MARK: - Methods
    func fetchContents(page: Int) {
        service.fetchPosts(page: page) { result in
            switch result {
            case .success(let data):
                let posts = data.returnPosts()
                self.posts.accept(posts)
            case .failure(let error):
                print("Error fetching Content: \(error.localizedDescription)")
            }
        }
    }
    
}
