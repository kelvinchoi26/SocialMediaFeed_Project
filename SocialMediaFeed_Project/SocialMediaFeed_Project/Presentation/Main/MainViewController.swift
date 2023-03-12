//
//  MainViewController.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit
import RxSwift

final class MainViewController: BaseViewController {
    
    // MARK: - Properties
    private var collectionView: UICollectionView?
    private let viewModel = MainViewModel()
    private var mainCollectionView: UICollectionView!
    private var subCollectionViews = [UICollectionView]()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    // MARK: - Bind
    override func bind() {
        viewModel.fetchContents(page: 0)
        
        viewModel.posts
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
        // cell 사이 빈 공간 제거 (화면에 딱 맞게 설정)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        
        view.addSubview(collectionView ?? UICollectionView())
        
        collectionView?.frame = view.bounds
        
        // 첫번째 cell의 navigation bar 위치에 발생하는 공간 제거
        collectionView?.contentInsetAdjustmentBehavior = .never
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = viewModel.posts.value[indexPath.row]
        
        // 영상인 경우 FeedVideoViewCell, 이미지인 경우 FeedImageViewCell
        if post.contents[0].type == "image" {
            print("image")
            collectionView.register(FeedImageViewCell.self, forCellWithReuseIdentifier: FeedImageViewCell.reuseIdentifier)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedImageViewCell.reuseIdentifier, for: indexPath) as? FeedImageViewCell else {
                return UICollectionViewCell()
            }
            cell.configureImageCell(with: post, content: post.contents[0])
            
            return cell
        } else {
            print("video!")
            collectionView.register(FeedVideoViewCell.self, forCellWithReuseIdentifier: FeedVideoViewCell.reuseIdentifier)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedVideoViewCell.reuseIdentifier, for: indexPath) as? FeedVideoViewCell else {
                return UICollectionViewCell()
            }
            cell.configureVideoCell(with: post, content: post.contents[0])
            
            return cell
        }
    }
}
