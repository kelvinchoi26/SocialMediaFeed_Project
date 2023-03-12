//
//  FeedImageViewCell+CollectionView.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/12.
//

import UIKit

extension FeedImageViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post?.contents.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newPost = post else {
            print("collectionView post 불러오기 실패")
            return UICollectionViewCell()
        }
        
        guard let newContent = post?.contents[indexPath.row] else {
            print("collectionView content 불러오기 실패")
            return UICollectionViewCell()
        }
        
        // 타입에 따라서 다른 cell register
        if newContent.type == "image" {
            collectionView.register(InnerImageViewCell.self, forCellWithReuseIdentifier: InnerImageViewCell.reuseIdentifier)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerImageViewCell.reuseIdentifier, for: indexPath) as! InnerImageViewCell
            cell.configureImageCell(with: newPost, content: newContent)
            
            return cell
        } else {
            collectionView.register(InnerVideoViewCell.self, forCellWithReuseIdentifier: InnerVideoViewCell.reuseIdentifier)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerVideoViewCell.reuseIdentifier, for: indexPath) as! InnerVideoViewCell
            cell.configureVideoCell(with: newPost, content: newContent)
            
            return cell
        }
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.safeAreaInsets.top - self.safeAreaInsets.bottom)
        
        // cell 사이 빈 공간 제거 (화면에 딱 맞게 설정)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        innerCollectionView?.isPagingEnabled = true
        innerCollectionView?.dataSource = self
        
        self.addSubview(innerCollectionView ?? UICollectionView())
        
        innerCollectionView?.frame = self.bounds
        
        // 첫번째 cell의 navigation bar 위치에 발생하는 공간 제거
        innerCollectionView?.contentInsetAdjustmentBehavior = .never
        
        innerCollectionView?.reloadData()
    }
}
