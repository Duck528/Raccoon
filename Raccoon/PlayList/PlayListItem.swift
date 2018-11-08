//
//  PlayListItem.swift
//  Raccoon
//
//  Created by thekan on 05/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import RxCocoa

struct PlayItem {
    let title: String
    let imageUrlString: String
    
    init?(title: String, imageUrlString: String) {
        self.title = title
        self.imageUrlString = imageUrlString
    }
}
