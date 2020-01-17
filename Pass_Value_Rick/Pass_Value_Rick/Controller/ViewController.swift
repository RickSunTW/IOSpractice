//
//  ViewController.swift
//  Pass_Value_Rick
//
//  Created by RickSun on 2020/1/16.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var numberArray: [String] = ["2", "3", "4", "5"]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func nextPageAction(_ sender: Any) {
        performSegue(withIdentifier: "NextPage", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? NextPageViewController
        controller?.receiveData = (sender as? String)!
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RickTest", for: indexPath) as? RickTableViewCell else { return UITableViewCell() }
        
        cell.numberLabel.text = numberArray[indexPath.row]
        
        cell.deleteBtn.tag = indexPath.row
        
        print(indexPath.row)
        
        
        cell.deleteHandler = {[weak self] (row) in
            
            self?.numberArray.remove(at: row)
            
            self?.tableView.reloadData()
            
            
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NextPage", sender: numberArray[indexPath.row])
    }
    

    
}

