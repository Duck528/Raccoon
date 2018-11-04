//
//  UIWindow+Extension.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import UIKit

extension UIWindow {
    class var hasNotch: Bool {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        if max(height, width) / min(height, width) > 2 {
            return true
        }
        return false
    }
}
