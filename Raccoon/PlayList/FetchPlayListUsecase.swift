//
//  FetchPlayListUsecase.swift
//  Raccoon
//
//  Created by thekan on 08/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import RxSwift

class FetchPlayListUsecase {
    private let playItemRepository: PlayItemRepository
    
    init(playItemRepository: PlayItemRepository) {
        self.playItemRepository = playItemRepository
    }
    
    func fetchPlayList() -> Observable<[PlayItem]> {
        return playItemRepository.fetchAll()
    }
}
