//
//  MainViewController.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension MainViewController {
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView 
        
    }
}
