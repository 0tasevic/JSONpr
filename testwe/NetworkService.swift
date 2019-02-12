//
//  NetworkService.swift
//  testwe
//
//  Created by Milos Otasevic on 11/02/2019.
//  Copyright © 2019 Milos Otasevic. All rights reserved.
//

import Foundation
import Moya

enum Ozon {
    case vijesti
}

extension Ozon: TargetType {
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: "http://ozon.org.me")! }
    
    var path: String {
        switch self {
        case .vijesti:
            return "/wp-json/wp/v2/posts?category_name=vijesti"
            
        }
    }
    var method: Moya.Method {
        switch self {
        case .vijesti:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .vijesti: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {
        return Data()
        
    }
}
