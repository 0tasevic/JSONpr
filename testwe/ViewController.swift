//
//  ViewController.swift
//  testwe
//
//  Created by Milos Otasevic on 11/02/2019.
//  Copyright © 2019 Milos Otasevic. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    var vrijeme: News!
    
    @IBOutlet weak var prikaz: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        moyaCall()
        
        
    }
    
    func moyaCall(){
        let provider = MoyaProvider<Ozon>()
        provider.request(.vijesti) { result in
            print(result)
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                
                let decoded = try? JSONDecoder().decode([News].self, from: data)
                self.vrijeme = decoded?.first
                DispatchQueue.main.async {
                    self.prikaz.text = self.vrijeme.title
                }
                
            // do something in your app
            case let .failure(error):
                // TODO: handle the error == best. comment. ever.
                print(error)
            }
            
        }
    }
    
    func po(){
        let url = URL(string: "http://ozon.org.me/wp-json/wp/v2/posts?category_name=vijesti")
        URLSession.shared.dataTask(with: url!){ (data, respondse, error) in
            
            guard let data = data else{return}
            do{
                print(data)
                let decoded = try? JSONDecoder().decode([News].self, from: data)
                self.vrijeme = decoded?.first
                DispatchQueue.main.async {
                    self.prikaz.text = self.vrijeme.title
                }
            }
            catch let error{
                debugPrint(error as Any)
            }
            
            
            
            
            
            }.resume()
    }
}

struct News: Codable {
    let title: String?
    let link: String?
    let date, content: String?
    let image: String?
}


