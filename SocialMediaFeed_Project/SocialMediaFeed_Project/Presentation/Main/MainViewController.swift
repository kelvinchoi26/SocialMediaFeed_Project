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
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    // MARK: - Bind
    override func bind() {
        viewModel.posts
            .bind(to: collectionView!.rx.items(cellIdentifier: FeedVideoViewCell.reuseIdentifier, cellType: FeedVideoViewCell.self)) { row, post, cell in
                cell.post = post
            }
            .disposed(by: disposeBag)
        
        viewModel.fetchContents(page: 0)
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
        collectionView?.register(FeedVideoViewCell.self, forCellWithReuseIdentifier: FeedVideoViewCell.reuseIdentifier)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedVideoViewCell.reuseIdentifier, for: indexPath) as? FeedVideoViewCell else {
            return UICollectionViewCell()
        }
        
        let post = viewModel.posts.value[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
