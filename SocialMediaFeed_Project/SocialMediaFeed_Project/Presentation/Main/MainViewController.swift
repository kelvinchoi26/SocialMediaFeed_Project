//
//  MainViewController.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: - Properties
    private var collectionView: UICollectionView?
    private let viewModel = MainViewModel()
    private var mainCollectionView: UICollectionView!
    private var subCollectionViews = [UICollectionView]()
    
    let contents = ["https://images.pexels.com/photos/15110299/pexels-photo-15110299.jpeg?auto=compress&cs=tinysrgb&h=650&w=940", "https://images.pexels.com/photos/15171147/pexels-photo-15171147.jpeg?auto=compress&cs=tinysrgb&h=650&w=940", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"]
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        print("나 문제 없어!!!")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
    }
    
    // MARK: - Bind
//    override func bind() {
//        viewModel.posts
//            .withUnretained(self)
//            .bind { vc, posts in
//                print(posts)
//            }
//            .disposed(by: disposeBag)
//    }
}

extension MainViewController {
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(FeedVideoViewCell.self, forCellWithReuseIdentifier: FeedVideoViewCell.reuseIdentifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        
        view.addSubview(collectionView ?? UICollectionView())
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedVideoViewCell.reuseIdentifier, for: indexPath) as! FeedVideoViewCell
        
        cell.loadVideo()
        
        print("로드 됨!!")
        return cell
    }
    
    
}
