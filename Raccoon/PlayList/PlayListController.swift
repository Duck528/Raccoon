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

class PlayListController: UIViewController, Bindable {
    typealias ViewModelType = PlayListViewModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellReuseID = "CardCell"
    
    var viewModel: PlayListViewModel!
    
    func bindViewModel() {
        
    }
}

extension PlayListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 520)
    }
}

extension PlayListController {
    private func bindCollectionView() {
        
    }
}


extension PlayListController {
    static func create() -> PlayListController {
        let sb = UIStoryboard(name: "PlayList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PlayList") as! PlayListController
        return vc
    }
}


