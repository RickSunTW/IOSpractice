//
//  ViewController.swift
//  GCD_Rick
//
//  Created by RickSun on 2020/1/14.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var queue1DataRoad: String = ""
    var queue2DataRoad: String = ""
    var queue3DataRoad: String = ""
    var queue1DataspeedLimit: String = ""
    var queue2DataspeedLimit: String = ""
    var queue3DataspeedLimit: String = ""
    
    //    var dataFinish: Bool = false
    
    @IBOutlet weak var queue1DataRodeLabel: UILabel!
    
    @IBOutlet weak var queue1DataSLLabel: UILabel!
    
    @IBOutlet weak var queue2DataRodeLabel: UILabel!
    
    @IBOutlet weak var queue2DataSLLabel: UILabel!
    
    @IBOutlet weak var queue3DataRodeLabel: UILabel!
    
    @IBOutlet weak var queue3DataSLLabel: UILabel!
    
    @IBOutlet weak var groupBtn: UIButton! 
    
    @IBAction func getAllInfoActionBtn(_ sender: Any) {
        loadGroupData()
        
    }
    
    @IBAction func clearAllBtn(_ sender: Any) {
        self.queue1DataRodeLabel.text = ""
        self.queue2DataRodeLabel.text = ""
        self.queue3DataRodeLabel.text = ""
        self.queue1DataSLLabel.text = ""
        self.queue2DataSLLabel.text = ""
        self.queue3DataSLLabel.text = ""
    }
    
    @IBAction func gcdSemaphoreBtnAction(_ sender: Any) {
        
        loadsemaphoreData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        loadGroupData()
    }
    
    func loadGroupData() {
        let group: DispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
        
        queue1.async {
            group.enter()
            let section = URLSession(configuration: .default)
            
            let task1 = section.dataTask(with: URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=0")!) { (Data, response, error) in
                
                guard let data1 = Data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(speedCamera.self, from: data1)
                    
                    self.queue1DataRoad = result.result.results[0].road
                    
                    self.queue1DataspeedLimit = result.result.results[0].speedLimit
                    
                    group.leave() // 結束呼叫 API1
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
            task1.resume()
            
            group.enter() // 開始呼叫 API2
            
            let task2 = section.dataTask(with: URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=10")!) { (Data, response, error) in
                
                guard let data2 = Data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(speedCamera.self, from: data2)
                    
                    self.queue2DataRoad = result.result.results[0].road
                    
                    self.queue2DataspeedLimit = result.result.results[0].speedLimit
                    
                    group.leave() // 結束呼叫 API2
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
            task2.resume()
            
            group.enter() // 開始呼叫 API3
            
            let task3 = section.dataTask(with: URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=20")!) { (Data, response, error) in
                
                guard let data3 = Data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(speedCamera.self, from: data3)
                    
                    self.queue3DataRoad = result.result.results[0].road
                    
                    self.queue3DataspeedLimit = result.result.results[0].speedLimit
                    
                    group.leave()  // 結束呼叫 API3
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
            task3.resume()
            
        }
        
        group.notify(queue: DispatchQueue.main) {
            // 完成所有 Call 後端 API 的動作
            print("完成所有 Call 後端 API 的動作...")
            DispatchQueue.main.async {
                self.queue1DataRodeLabel.text = self.queue1DataRoad
                self.queue2DataRodeLabel.text = self.queue2DataRoad
                self.queue3DataRodeLabel.text = self.queue3DataRoad
                self.queue1DataSLLabel.text = self.queue1DataspeedLimit
                self.queue2DataSLLabel.text = self.queue1DataspeedLimit
                self.queue3DataSLLabel.text = self.queue1DataspeedLimit
                
            }
            
        }
        
    }
    
    func loadsemaphoreData() {
        
        let semaphoreSec = DispatchSemaphore(value: 0)
        
        let semaphoreLast = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            let section = URLSession(configuration: .default)
            
            let task1 = section.dataTask(with: URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=0")!) { (Data, response, error) in
                
                guard let data1 = Data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(speedCamera.self, from: data1)
                    DispatchQueue.main.async {
                        
                        self.queue1DataRodeLabel.text = result.result.results[0].road
                        
                        self.queue1DataSLLabel.text = result.result.results[0].speedLimit
                        
                    }
                    
                    semaphoreSec.signal()
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
            task1.resume()
            
            semaphoreSec.wait()
            
            let task2 = section.dataTask(with: URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=10")!) { (Data, response, error) in
                
                guard let data2 = Data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(speedCamera.self, from: data2)
                    DispatchQueue.main.async {
                        
                        self.queue2DataRodeLabel.text = result.result.results[0].road
                        
                        self.queue2DataSLLabel.text = result.result.results[0].speedLimit
                    }
                    
                    semaphoreLast.signal()
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
            task2.resume()
            
            semaphoreLast.wait()
            
            let task = section.dataTask(with: URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=20")!) { (Data, response, error) in
                
                guard let data = Data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(speedCamera.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.queue3DataRodeLabel.text = result.result.results[0].road
                        
                        self.queue3DataSLLabel.text = result.result.results[0].speedLimit
                    }
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
            task.resume()
            
        }
    }
}

struct speedCamera: Codable {
    
    let result: Result
    
}

struct Result: Codable {
    
    var limit: Int
    
    var offset: Int
    
    var count: Int
    
    var sort: String
    
    var results: [Results]
    
}

struct Results: Codable {
    
    var functions: String
    
    var area: String
    
    var no: String
    
    var direction: String
    
    var speedLimit: String
    
    var location: String
    
    var id: Int
    
    var road: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case speedLimit = "speed_limit"
        case functions, area, no, direction, location, road
    }
    
}
