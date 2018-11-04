//
//  Bindable.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import UIKit

protocol Bindable: class {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension Bindable where Self: UIViewController {
    func bindViewModel(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension Bindable where Self: UICollectionViewCell {
    func bindViewModel(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
