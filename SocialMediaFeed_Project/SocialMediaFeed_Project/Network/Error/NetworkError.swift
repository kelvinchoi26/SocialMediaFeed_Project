//
//  NetworkError.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/08.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case decodeError
    case unstableNetworkError
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "알 수 없는 에러 발생"
        case .decodeError:
            return "디코딩 에러 발생"
        case .unstableNetworkError:
            return "불안정한 네트워크 상태로 인한 에러 발생"
        }
    }
}
