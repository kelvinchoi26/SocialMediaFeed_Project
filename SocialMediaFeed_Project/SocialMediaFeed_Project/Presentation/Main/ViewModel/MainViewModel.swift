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
    let service = FeedAPIService.shared
    let posts = BehaviorRelay<[Post]>(value: [])
    
    // MARK: - Methods
    func fetchContents(page: Int) {
        service.fetchPosts(page: page) { result in
            switch result {
            case .success(let data):
                self.posts.accept(data)
            case .failure(let error):
                print("Error fetching Content: \(error.localizedDescription)")
            }
        }
    }
    
}
