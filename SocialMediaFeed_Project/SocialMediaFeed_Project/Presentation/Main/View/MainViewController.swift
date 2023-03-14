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
    private var volumeSlider: UISlider?
    
    private let errorView = UIView()
    private let retryButton = UIButton()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        collectionView?.delegate = self
        
    }
    
    // MARK: - Bind
    override func bind() {
        viewModel.fetchContents(page: 0)
            .subscribe({ [weak self] result in
                switch result {
                case .success(let posts):
                    self?.viewModel.posts.accept(posts)
                    self?.collectionView?.reloadData()
                    
                case .failure(let error):
                    print("Error fetching Content: \(error.localizedDescription)")
                    self?.configureErrorView()
                    self?.showErrorView()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.posts
            .bind(onNext: { [weak self] _ in
                self?.collectionView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func configureErrorView() {
        retryButton.do {
            $0.setTitle("다시 시도하기", for: .normal)
            $0.titleLabel?.font = Constants.Font.regular
            $0.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        }
        
        errorView.do {
            $0.backgroundColor = .black
        }
        
        view.addSubview(errorView)
        
        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.addSubview(retryButton)
        
        retryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

extension MainViewController {
    private func configureCollectionView() {
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
        
        collectionView?.showsVerticalScrollIndicator = false
    }
    
    private func showErrorView() {
        view.addSubview(errorView)
        view.bringSubviewToFront(errorView)
    }
    
    @objc private func retryButtonTapped() {
        errorView.removeFromSuperview()
        
        bind()
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < viewModel.posts.value.count else {
            return UICollectionViewCell()
        }
        
        let post = viewModel.posts.value[indexPath.row]
        
        guard let firstContent = post.contents.first else {
            return UICollectionViewCell()
        }
        
        // 영상인 경우 FeedVideoViewCell, 이미지인 경우 FeedImageViewCell
        if firstContent.type == ContentType.image.rawValue {
            collectionView.register(FeedImageViewCell.self, forCellWithReuseIdentifier: FeedImageViewCell.reuseIdentifier)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedImageViewCell.reuseIdentifier, for: indexPath) as? FeedImageViewCell else {
                return UICollectionViewCell()
            }
            cell.configureImageCell(with: post, content: post.contents, indexPath: indexPath)
            cell.outerCollectionView = collectionView
            cell.indexPath = indexPath
            
            return cell
        } else {
            collectionView.register(FeedVideoViewCell.self, forCellWithReuseIdentifier: FeedVideoViewCell.reuseIdentifier)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedVideoViewCell.reuseIdentifier, for: indexPath) as? FeedVideoViewCell else {
                return UICollectionViewCell()
            }
            cell.configureVideoCell(with: post, content: post.contents, indexPath: indexPath)
            cell.outerCollectionView = collectionView
            cell.indexPath = indexPath
            
            return cell
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else { return }
        
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        print(visibleIndexPaths)
        // scroll이 멈출 때 마다 뷰모델에 현재의 indexPath 값을 보냄
        if let indexPath = visibleIndexPaths.first {
            print(indexPath)
            print("❌")
            viewModel.currentCellIndexPath.onNext(indexPath)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 페이지네이션
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.fetchNextPage()
                .subscribe({ [weak self] result in
                    switch result {
                    case .success(let posts):
                        self?.viewModel.posts.accept(self?.viewModel.posts.value ?? [] + posts)
                        self?.collectionView?.reloadData()
                        
                    case .failure(let error):
                        print("Error fetching Next Page: \(error.localizedDescription)")
                        self?.view.makeToast("API 오류 발생", duration: 3.0, position: .bottom)
                    }
                })
                .disposed(by: disposeBag)
        }
        
        // 스크롤 시 알파 값 변경
        let visibleIndexPaths = collectionView?.indexPathsForVisibleItems ?? []
        let visibleCells = visibleIndexPaths.compactMap { collectionView?.cellForItem(at: $0) }

        let middleY = collectionView?.frame.midY ?? 0

        for cell in visibleCells {
            let cellMiddleY = cell.frame.midY - scrollView.contentOffset.y
            let distance = abs(cellMiddleY - middleY)
            let alpha = min(1, distance/(collectionView?.frame.height ?? 1))
            cell.alpha = 1 - alpha
        }
    }

}
