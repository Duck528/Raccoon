//
//  URL+Extension.swift
//  Raccoon
//
//  Created by thekan on 05/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation

extension URL {
    
    enum UrlType {
        case phAsset
        case url
        case unknown
    }
    
    var urlType: UrlType {
        guard let scheme = scheme else {
            return .unknown
        }
        switch scheme.lowercased() {
        case "phasset":
            return .phAsset
        case "http", "https":
            return .url
        default:
            return .unknown
        }
    }
}
