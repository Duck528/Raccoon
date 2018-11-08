//
//  PlayListCellViewModel.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import RxCocoa

class PlayListCellViewModel {
    let playItem: BehaviorRelay<PlayItem>
    
    init(playItem: PlayItem) {
        self.playItem = BehaviorRelay<PlayItem>(value: playItem)
    }
}
