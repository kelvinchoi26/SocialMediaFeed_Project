//
//  BaseViewController.swift
//  SocialMediaFeed_Project
//
//  Created by 최형민 on 2023/03/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    // Designated Init (모든 프로퍼티가 초기화 되어야 함)
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // 보조 이니셜라이저 - 기본값 지정
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    // MARK: - Overridden Functions
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setConstraints()

        bind()
    }

    // MARK: - Attributes
    func setAttributes() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - Constraints
    func setConstraints() {}
    
    // MARK: - Bind
    func bind() {}
}
