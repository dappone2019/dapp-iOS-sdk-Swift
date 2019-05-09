//
//  UIColor+Extension.swift
//  DappbirdsSDKDemoSwift
//
//  Created by 区块链 on 2019/5/8.
//  Copyright © 2019 com.blockchain.dappbirdssdk. All rights reserved.
//

import UIKit

extension UIColor {
    
    //通过16位颜色码设置颜色
    static func hexStringToColor(_ hexString: String, alpha: Double = 1) -> UIColor{
        var cString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if cString.count < 6 {return UIColor.black}
        if cString.hasPrefix("0X") {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 2)..<cString.endIndex])
        }
        if cString.hasPrefix("#") {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)..<cString.endIndex])
        }
        if cString.count != 6 {return UIColor.black}
        
        var range: NSRange = NSMakeRange(0, 2)
        
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor.colorWithRGBA(Double(r), g: Double(g), b: Double(b), a: alpha)
    }
    
    func getRGB() -> (CGFloat,CGFloat,CGFloat) {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: nil){
            return (r * 255,g * 255,b * 255)
        }
        
        guard let cmps = cgColor.components else {
            fatalError("请使用RGB创建UIColor")
        }
        return(cmps[0] * 255,cmps[1] * 255,cmps[2] * 255)
    }
    
    //颜色
    static func colorWithRGBA(_ r: Double, g: Double, b: Double, a: Double) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a / 1.0))
    }
    
    static func grayStyleColor() -> UIColor {
        return UIColor.hexStringToColor("1")
    }
    
    static func darkgGrayStyleColor() -> UIColor {
        return UIColor.hexStringToColor("787878") // 蜂鸟自选的cell使用
    }
    
    static func lightGrayStyleColor() -> UIColor {
        return UIColor.hexStringToColor("cccccc")
    }
    
    static func menuItemStyleColor() -> UIColor {
        return UIColor.hexStringToColor("F5F5F5")
    }
    
    static func blackStyleColor() -> UIColor {
        return UIColor.hexStringToColor("333333")
    }
    
    static func linghtBlackStyleColor() -> UIColor {
        return UIColor.hexStringToColor("666666")
    }
    
    static func mainColor () -> UIColor {
        return UIColor.hexStringToColor("4C50FF") // 428af9
    }
    
    static func mainRedColor () -> UIColor {
        return UIColor.hexStringToColor("fb283c")
    }
    
    static func lightMainBgColor () -> UIColor {
        return UIColor.hexStringToColor("fff2f4")
    }
    
    static func backgroundColor () -> UIColor {
        return UIColor.hexStringToColor("f6f7f8")
    }
    
    static func borderColor () -> UIColor {
        return UIColor.hexStringToColor("f0f0f0")
    }
    
    static func navigationTopColor () -> UIColor {
        return UIColor.hexStringToColor("0698fd")
    }
    
    static func navigationBottomColor () -> UIColor {
        return UIColor.hexStringToColor("0691fd")
    }
    
    static func redStyleColor () -> UIColor {
        return UIColor.hexStringToColor(K_CHART_COLOR_RED)
    }
    
    static func greenStyleColor () -> UIColor {
        return UIColor.hexStringToColor(K_CHART_COLOR_GREEN)
    }
    
    static func blueStyleColor () -> UIColor {
        return UIColor.hexStringToColor("1c99f6")
    }
    
    static func picBackgroundColor () -> UIColor {
        return UIColor.hexStringToColor("f2f2f2")
    }
    
    static func borderGrayStyleColor() -> UIColor {
        return UIColor.hexStringToColor("eeeeee")
    }
    
    static func articleReadStyleColor() -> UIColor {
        return UIColor.hexStringToColor("aaaaaa")
    }
    
    static func circlePointStyleColor () -> UIColor {
        return UIColor.hexStringToColor("0698FD")
    }
    
    static func nightThemeBarImageColor () -> UIColor {
        return UIColor.hexStringToColor("0A0B13")
    }
    
    static func nightThemeViewBackgroundColor () -> UIColor {
        return UIColor.hexStringToColor("3D434E")
    }
}
