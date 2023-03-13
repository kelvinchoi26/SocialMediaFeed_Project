//
//  BaseCollectionViewCell.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    let viewModel = MainViewModel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
        configureCell()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureUI() {}
    
    func setConstraints() {}
    
    func configureCell() {}
    
    func bind() {}
    
    func setupVolumeButtonTap() {
        let tapGesture = UITapGestureRecognizer()
        contentView.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.toggleMute()
            })
            .disposed(by: disposeBag)
    }
    
}
