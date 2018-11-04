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
    
    var viewModel: PlayListViewModel!
    
    func bindViewModel() {
        
    }
}

extension PlayListController {
    static func create(with viewModel: PlayListViewModel) -> PlayListController {
        let sb = UIStoryboard(name: "PlayList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PlayList") as! PlayListController
        vc.bindViewModel(to: viewModel)
        return vc
    }
}
