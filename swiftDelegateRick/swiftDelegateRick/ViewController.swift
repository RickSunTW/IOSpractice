//
//  ViewController.swift
//  swiftDelegateRick
//
//  Created by RickSun on 2020/1/13.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

enum ButtonSet: String {
    
    case yellow = "yellow"
    
    case blue = "blue"
    
    case red = "red"
    
    case green = "green"
    
    case gray = "gray"
    
    func color() -> UIColor {
        
        switch self {
            
        case .yellow: return .yellow
            
        case .blue: return .blue
            
        case .red: return .red
        
        case .green: return .green
            
        case .gray: return .gray
            
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var topSelectionView: SelectionView! {
        
        didSet {
            
            topSelectionView.dataSource = self
            
            topSelectionView.delegate = self
            
        }
    }
 
    @IBOutlet weak var bottomSelectionView: SelectionView! {
        
        didSet{
            
            bottomSelectionView.dataSource = self
            
            bottomSelectionView.delegate = self
        }
    }
    
    @IBOutlet weak var testSelectionView: SelectionView! {
        
        didSet{
            
            testSelectionView.dataSource = self
                   
            testSelectionView.delegate = self
        }
        
    }
    
    let topArray: [ButtonSet] = [.red, .blue, .gray, .green]
    
    let bottomArray: [ButtonSet] = [.red, .blue, .yellow]
    
    let testArray: [ButtonSet] = [.green, .gray, .yellow, .blue, .red]
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var testView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.backgroundColor = topArray.first?.color()
        
        bottomView.backgroundColor = bottomArray.first?.color()
        
        testView.backgroundColor = testArray.first?.color()

    }
}

extension ViewController: SelectionViewDataSource {
    
    func numberOfButtons(in selectionView: SelectionView) -> Int {
        
        if selectionView == topSelectionView {
            
            return topArray.count
        
        } else if selectionView == bottomSelectionView {
        
            return bottomArray.count
            
        } else {
            
            return testArray.count
        }
    }
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String {
        
        if selectionView == topSelectionView {
            
            return topArray[index].rawValue
            
        } else if selectionView == bottomSelectionView {
            
            return bottomArray[index].rawValue
            
        } else {
            
            return testArray[index].rawValue
        }
    }
    
    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor? {

        return UIColor.white
    }
}

extension ViewController: SelectionViewDelegate {
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
    
        if selectionView == topSelectionView {
            
            topView.backgroundColor = topArray[index].color()
            
        } else if selectionView == bottomSelectionView {
            
            bottomView.backgroundColor = bottomArray[index].color()
        } else {
            
            testView.backgroundColor = testArray[index].color()
        }
    }
    
    func shouldSelectedButton(_ selectionView: SelectionView, at index: Int) -> Bool {
        
        if selectionView == topSelectionView {
            
            return true
            
        } else {

            if topSelectionView.selectedIndex == topArray.count - 1 {

                return false

            } else {

                return true
            }
        }
    }
}
