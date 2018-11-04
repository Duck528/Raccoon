//
//  PlayListService.swift
//  Raccoon
//
//  Created by thekan on 05/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class PlayListService {
    func fetchPlayList() -> Observable<[PlayListItem]> {
        return .just([])
    }
}
