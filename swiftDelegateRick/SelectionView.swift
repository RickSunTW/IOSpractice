//
//  SelectionView.swift
//  swiftDelegateRick
//
//  Created by RickSun on 2020/1/13.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

//設定Button的數量, 標題, 文字格式, 顏色  Indicator的顏色 且property 要AnyObject

protocol SelectionViewDataSource: AnyObject {
    
    func numberOfButtons(in selectionView: SelectionView) -> Int
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String
    
    func fontOfTitle(_ selectionView: SelectionView) -> UIFont
    
    func colorOfTitle(_ selectionView: SelectionView, at index: Int) -> UIColor?
    
    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor?
    
    func initialButtonIndex(_ selectionView: SelectionView) -> Int
}

//因為要設為optional所以要使用objc  property 要AnyObject

@objc protocol SelectionViewDelegate: AnyObject {
    
    @objc optional func didSelectedButton(_ selectionView: SelectionView, at index: Int)
    
    @objc optional func shouldSelectedButton(_ selectionView: SelectionView, at index: Int) -> Bool
    
}

// 在DataSource設定初始資料

extension SelectionViewDataSource {
    
    func numberOfButtons(in selectionView: SelectionView) -> Int { return 3 }
    
    func fontOfTitle(_ selectionView: SelectionView) -> UIFont { return UIFont.systemFont(ofSize: 18)}
    
    func colorOfTitle(_ selectionView: SelectionView, at index: Int) -> UIColor? { return UIColor.white }
    
    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor { return UIColor.white }

    func initialButtonIndex(_ selectionView: SelectionView) -> Int {return 0 }
    
}

//建立SelectionView 其中包含dataSourece 與 delegate 前面要記得加weak

class SelectionView: UIView {
    
    weak var dataSource: SelectionViewDataSource? {
        
        didSet {
            
            setupSelectionViews()
            setupIndicatorView()
            
        }
    }
    
    weak var delegate: SelectionViewDelegate?
    
    var selectedIndex: Int?
    
    var stackView: UIStackView = {
        
        let stack = UIStackView()
        
        stack.axis = NSLayoutConstraint.Axis.horizontal
        
        stack.distribution = UIStackView.Distribution.fillEqually
        
        return stack
    }()
    
    let indicatorView = UIView()
    
    var indicatorCenterXContraint: NSLayoutConstraint?
    
    //兩個 method 一個為button的stack View 一個為Indicator View
    
    func setupSelectionViews() {
        
        guard let dataSource = dataSource else { return }
        
        for index in 0...(dataSource.numberOfButtons(in: self) - 1) {
            
            let button = UIButton()
            
            button.tag = index
            
            button.setTitle(dataSource.titleOfButton(self, at: index), for: .normal)
            
            button.setTitleColor(dataSource.colorOfTitle(self, at: index), for: .normal)
            
            button.addTarget(self, action: #selector(userDidTouchButton(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupIndicatorView() {
        
        guard let dataSource = dataSource else { return }
        
        let initialBtn = stackView.arrangedSubviews[dataSource.initialButtonIndex(self)]
        
        selectedIndex = dataSource.initialButtonIndex(self)
        
        indicatorView.backgroundColor = dataSource.colorOfIndicator(self)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicatorView)
        
        indicatorCenterXContraint = indicatorView.centerXAnchor.constraint(equalTo: initialBtn.centerXAnchor)
        
        NSLayoutConstraint.activate([
            indicatorView.bottomAnchor.constraint(equalTo: initialBtn.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2),
            indicatorView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / CGFloat(dataSource.numberOfButtons(in: self)) / 2),
            indicatorCenterXContraint!
        ])
        
    }
    
//    button action 的 method
    @objc func userDidTouchButton(_ sender: UIButton) {
        
        guard delegate?.shouldSelectedButton?(self, at: sender.tag) == true else { return }
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: { [weak self] in
            
            self?.indicatorCenterXContraint?.isActive = false
            
            self?.indicatorCenterXContraint = self?.indicatorView.centerXAnchor.constraint(equalTo: sender.centerXAnchor)
            
            self?.indicatorCenterXContraint?.isActive = true
            
            self?.layoutIfNeeded()
        })
        
        animator.startAnimation()
        
        delegate?.didSelectedButton?(self, at: sender.tag)
        
        selectedIndex = sender.tag
        
    }
}


