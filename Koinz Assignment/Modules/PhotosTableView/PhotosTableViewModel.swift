//
//  PhotosTableViewModel.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver

class PhotosTableViewModel: ViewModelType {
    @Injected private var photosNetwork: PhotosNetwork
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }
    
    struct Output {
        let photos: Observable<[Photo]>
    }
    
    func transform(input: Input) -> Output {
        let photos = input.viewDidLoadTrigger.flatMapLatest {
            
            return self.photosNetwork.getPhotos(page: 1)
                .map({$0.photos?.photo ?? []})
                .asDriverOnErrorJustComplete()
        }.asObservable()
        return Output(photos: photos)
    }
    
}
