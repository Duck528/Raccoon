//
//  PlayItemRepository.swift
//  Raccoon
//
//  Created by thekan on 08/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import RxSwift

protocol PlayItemRepository {
    func fetchAll() -> Observable<[PlayItem]>
}

class DemoPlayItemRepository: PlayItemRepository {
    func fetchAll() -> Observable<[PlayItem]> {
        var playList: [PlayItem] = []
        let playItem01 = PlayItem(title: "play item 01", imageUrlString: "")
        let playItem02 = PlayItem(title: "play item 02", imageUrlString: "")
        let playItem03 = PlayItem(title: "play item 03", imageUrlString: "")
        playList.append(playItem01!)
        playList.append(playItem02!)
        playList.append(playItem03!)
        return .just(playList)
    }
}
