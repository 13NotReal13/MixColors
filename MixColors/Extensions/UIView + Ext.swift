//
//  UIView + Ext.swift
//  MixColors
//
//  Created by Иван Семикин on 24/05/2024.
//

import UIKit

extension UIView {
    func setShadow() {
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}
