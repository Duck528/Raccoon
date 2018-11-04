//
//  ImageSource.swift
//  Raccoon
//
//  Created by thekan on 05/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import Photos
import RxSwift
import UIKit

class ImageSource {
    
    enum ImageSourceType {
        case phAsset(PHAsset)
        case url(URL)
    }
    
    enum Errors: Error {
        case fetchImageFromPHAssetError
        case fetchImageFromUrlError
        case notSupportedError
    }
    
    let imageSourceType: ImageSourceType
    
    init(imageSourceType: ImageSourceType) {
        self.imageSourceType = imageSourceType
    }
    
    func fetchImage() -> Observable<UIImage> {
        switch imageSourceType {
        case .phAsset(let phAsset):
            return fetchImage(from: phAsset)
        case .url:
            return .error(Errors.notSupportedError)
        }
    }
    
    private func fetchImage(from phAsset: PHAsset) -> Observable<UIImage> {
        return Observable.create { observer in
            PHImageManager.default()
                .requestImageData(for: phAsset, options: nil) { data, _, orientation, _ in
                    guard let data = data, let image = UIImage(data: data) else {
                        return observer.onError(Errors.fetchImageFromPHAssetError)
                    }
                    return observer.onNext(image)
            }
            return Disposables.create()
        }
    }
}
