//
//  RootViewController.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var statusBackView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    let viewModel = RootViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "PlayList":
            guard let vc = segue.destination as? PlayListController else {
                return
            }
            vc.bindViewModel(to: viewModel.playListViewModel)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBackView.findConstraint(for: .height)?.constant = UIWindow.hasNotch ? 44 : 20
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
