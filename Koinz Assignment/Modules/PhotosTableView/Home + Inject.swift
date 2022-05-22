//
//  Home + Inject.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    static func registerHomeModule() {
        register {
            HomeNetworkImplementation()
        }
        .implements(PhotosNetwork.self)
        
        register {
            PhotosTableViewModel()
        }
        
        register {
            PhotosTableViewController()
        }
        
        
    }
}
