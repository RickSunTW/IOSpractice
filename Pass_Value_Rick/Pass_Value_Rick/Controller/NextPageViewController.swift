//
//  NextPageViewController.swift
//  Pass_Value_Rick
//
//  Created by RickSun on 2020/1/16.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation

class NextPageViewController: UIViewController {
    let fullScreenSize = UIScreen.main.bounds.size
    let myTextField = UITextField()
    let myButton = UIButton()
    var receiveData : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldSet()
        buttonSet()
        myTextField.text = receiveData
    }
    
    func textFieldSet(){
        
        myTextField.placeholder = "請輸入文字"
        
        myTextField.borderStyle = .roundedRect
        
        myTextField.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(myTextField)
        
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            myTextField.heightAnchor.constraint(equalToConstant: 40),
            myTextField.widthAnchor.constraint(equalToConstant: fullScreenSize.width * 2 / 3 ),
            myTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        
    }
    
    func buttonSet(){
    
        myButton.setTitle("Button", for: .normal)
        
        myButton.tintColor = UIColor.white
        
        myButton.isEnabled = true
        
        myButton.backgroundColor = UIColor.black
    
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(myButton)
        
        NSLayoutConstraint.activate([
            myButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20),
            myButton.heightAnchor.constraint(equalToConstant: 40),
            myButton.widthAnchor.constraint(equalToConstant: fullScreenSize.width * 2 / 3 ),
            myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
    }
}




