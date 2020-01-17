//
//  ViewController.swift
//  AppSchoolKKboxRick
//
//  Created by RickSun on 2020/1/17.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation
import KKBOXOpenAPISwift

class ViewController: UIViewController {
    var KkboxHitdata = [KKTrackInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func GetData(){
        let API = KKBOXOpenAPI(clientID: "ade446c7887276df94ca75e3a346ff91", secret: "4f76c666c916d651f9dad4cbe2530f7f")
                  
                  var getAccessToken: String = String()
                  
                  var _ = try? API.fetchAccessTokenByClientCredential { result in
                      
                      switch result {
                          
                      case .error(let error):
                          
                          print("error")
                          
                      case .success(let accessToken):
                          
                          getAccessToken = accessToken.accessToken
                          
                          print(getAccessToken)
                      }
                  }
                  
                  var _ = try? API.fetch(tracksInPlaylist: "DZrC8m29ciOFY2JAm3") { result in
                      switch result {
                      case .error(let error):
                          print("error")
                      case .success(let data):
                       self.KkboxHitdata =  data.tracks
                        
                       print(self.KkboxHitdata.count)
                        
                
                      }
                  }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
      
    }
    
}

extension ViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.KkboxHitdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KkboxCellIdentifiler", for: indexPath) as? KkboxHitListTableViewCell else { return UITableViewCell() }
        cell.kkboxHitLabel.text = KkboxHitdata[indexPath.row].name
        return cell
    }
    
    
}


extension ViewController: UITableViewDelegate {
    
}
