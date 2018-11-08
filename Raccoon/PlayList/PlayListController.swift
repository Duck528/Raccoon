//
//  PlayListController.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class PlayListController: UIViewController, Bindable {
    typealias ViewModelType = PlayListViewModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    let cellReuseID = "CardCell"
    
    var viewModel: PlayListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        collectionView.reloadData()
    }
    
    func bindViewModel() {
        bindCollectionView()
    }
}

extension PlayListController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PlayListCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 520)
    }
}

extension PlayListController {
    private func bindCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        viewModel.cellViewModels
//            .subscribe(onNext: { [weak self] _ in
//                self?.collectionView.reloadData()
//            }).disposed(by: disposeBag)
//
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.rx.setDataSource(self).disposed(by: disposeBag)
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<Void, PlayListCellViewModel>>(
            configureCell: { _, collectionView, indexPath, cellViewModel -> UICollectionViewCell in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PlayListCell else {
                    return UICollectionViewCell()
                }
                cell.bindViewModel(to: cellViewModel)
                return cell
        })
        
        viewModel.cellViewModels
            .map { [SectionModel<Void, PlayListCellViewModel>(model: (), items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}


extension PlayListController {
    static func create() -> PlayListController {
        let sb = UIStoryboard(name: "PlayList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PlayList") as! PlayListController
        return vc
    }
    
    private func setupCollectionViewLayout() {
        if let cardRotateLayout = collectionView.collectionViewLayout as? CardRotateLayout {
            cardRotateLayout.cardSize = CGSize(width: 320, height: 400)
        }
    }
}

