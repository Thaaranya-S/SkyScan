//
//  CustomView.swift
//  SkyScan
//
//  Created by Thaaranya Subramani on 31/12/23.
//

import Foundation
import UIKit

//MARK: - Corner Viewmm
class PrimaryCornerdView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.backgroundView()
        self.roundedView()
    }
    func backgroundView() {
        self.backgroundColor = UIColor.clear
    }
    func roundedView() {
        let layer = CALayer()
        layer.bounds = self.bounds
        layer.position = self.center
        self.layer.addSublayer(layer)
    }
}

class PrimaryView_Circle : PrimaryCornerdView {
    override func backgroundView() {
        self.backgroundColor = UIColor.systemCyan
    }
    override func roundedView() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}

class PrimaryView_Circle_White : PrimaryCornerdView {
    override func backgroundView() {
        self.backgroundColor = UIColor.white
    }
    override func roundedView() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}

class PrimaryView_CornerRadius_BorderWidth_Gray : PrimaryCornerdView {
    override func backgroundView() {
        self.backgroundColor = UIColor.white
    }
    override func roundedView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.gray.cgColor

    }
}
