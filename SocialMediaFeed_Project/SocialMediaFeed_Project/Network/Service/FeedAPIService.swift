//
//  FeedAPIService.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class FeedAPIService {
    
    // Singleton Pattern
    static let shared = FeedAPIService()
    
    private init() { }
    
    func fetchPosts(page: Int, completion: @escaping (Result<FeedResponseDTO, NetworkError>) -> Void) {
        let url = URLPath.baseURL + String(page)
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: FeedResponseDTO.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure:
                    completion(.failure(.decodeError))
                }
            }
    }
}
