//
//  PostsTarget.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import Foundation
import Moya

enum PhotosTarget {
    case getPhotosData(page: Int)
}

extension PhotosTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://www.flickr.com")!
    }
    
    var path: String {
        switch self {
        case .getPhotosData(let page):
            return "/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=50&text=Color&page=\(page)&per_page=20&api_key=d17378e37e555ebef55ab86c4180e8dc"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotosData:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
