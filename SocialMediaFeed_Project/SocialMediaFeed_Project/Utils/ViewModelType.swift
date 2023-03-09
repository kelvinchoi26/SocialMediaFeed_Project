//
//  ViewModelType.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation

protocol ViewModelType {
    
    // MARK: - Properties
    
    // MARK: - Input/Output
    associatedtype Input
    associatedtype Output
    
    // MARK: - Transform
    func transform(input: Input) -> Output
}
