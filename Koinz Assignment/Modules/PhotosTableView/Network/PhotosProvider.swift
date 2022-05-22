//
//  HomeProvider.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

protocol PhotosNetwork: AnyObject {
    func getPhotos(page: Int) -> Observable<AllPhotos>
}

class PhotosNetworkImplementation: PhotosNetwork {
    private let provider = MoyaProvider<PhotosTarget>()
    
    func getPhotos(page: Int) -> Observable<AllPhotos> {
        
        return provider.rx
            .request(.getPhotosData(page: page))
            .filterSuccessfulStatusCodes()
            .map(AllPhotos.self)
            .asObservable()
    }
}
