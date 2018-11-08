//
//  PlayListViewModel.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class PlayListViewModel {
    let cellViewModels = BehaviorRelay<[PlayListCellViewModel]>(value: [])
    let fetchPlayListUsecase: FetchPlayListUsecase
    
    let disposeBag = DisposeBag()
    
    init() {
        fetchPlayListUsecase = FetchPlayListUsecase(playItemRepository: DemoPlayItemRepository())
        fetchPlayList()
    }
}

extension PlayListViewModel {
    private func fetchPlayList() {
        fetchPlayListUsecase.fetchPlayList()
            .map { $0.map { PlayListCellViewModel(playItem: $0) } }
            .bind(to: cellViewModels)
            .disposed(by: disposeBag)
    }
}
