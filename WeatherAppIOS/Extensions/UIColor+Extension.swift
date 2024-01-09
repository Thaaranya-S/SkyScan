//
//  Color+Extension.swift
//  SkyScan
//
//  Created by Thaaranya Subramani on 31/12/23.
//

import Foundation
import UIKit


//MARK: - UIColor - Hex Code
extension UIColor {
    
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#")
        ? String(string.dropFirst())
        : string
        guard hex.count == 3 || hex.count == 6
        else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
    convenience init(hex string: String,opacity:CGFloat) {
        var hex = string.hasPrefix("#")
        ? String(string.dropFirst())
        : string
        guard hex.count == 3 || hex.count == 6
        else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: opacity)
    }
    
}

extension UIColor {
    static var shadowColor: UIColor =  UIColor(hex: "#D9DDE8").withAlphaComponent(0.25)
}
