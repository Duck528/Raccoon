//
//  ImageSourceView.swift
//  Raccoon
//
//  Created by thekan on 05/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ImageUrlView: UIImageView {
    
    var imageUrl: URL? {
        didSet {
            updateImage()
        }
    }
    
    private func updateImage() {
        guard let imageUrl = imageUrl else {
            return
        }
        
        switch imageUrl.urlType {
        case .phAsset:
            break
        case .url:
            break
        case .unknown:
            break
        }
    }
    
    private func loadImageFromPHAsset(_ url: URL) {
        guard
            let localIdentifier = url.absoluteString.components(separatedBy: "://").last,
            let phAsset = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject else {
                return
        }
        showLoadingIndicator()
        PHImageManager.default()
            .requestImage(
                for: phAsset,
                targetSize: bounds.size,
                contentMode: .aspectFill,
                options: nil) { [weak self] image, _ in
                    if let image = image {
                        self?.image = image
                    } else {
                        // placeholder 삽입
                    }
                    self?.hideLoadingIndicator()
        }
    }
    
    private func showLoadingIndicator() {
        
    }
    
    private func hideLoadingIndicator() {
        
    }
}
