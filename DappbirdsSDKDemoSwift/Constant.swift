//
//  Constant.swift
//  DappbirdsSDKDemoSwift
//
//  Created by 区块链 on 2019/5/8.
//  Copyright © 2019 com.blockchain.dappbirdssdk. All rights reserved.
//

import UIKit

// 设备的宽高
public let SCREENHEIGHT = UIScreen.main.bounds.size.height
public let SCREENWIDTH = UIScreen.main.bounds.size.width

public let IS_IPHONE_X = UIScreen.main.bounds.height >= 812

public let STATUS_HEIGHT: CGFloat = IS_IPHONE_X ? 44 : 20

public let NAVIGATION_HEIGHT: CGFloat = IS_IPHONE_X ? 88 : 64

public let TABBAR_HEIGHT: CGFloat = IS_IPHONE_X ? 83 : 49

public let TABBAR_HEIGHT_INCREASE: CGFloat = IS_IPHONE_X ? 34 : 0

public let K_CHART_COLOR_RED: String = "FB283C"
public let K_CHART_COLOR_GREEN: String = "1aa454"

public let scale: CGFloat =  SCREENWIDTH / 375
public let IS_WIDE_PHONE: Bool = SCREENWIDTH > 375


func Tprint<T>(messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName):第\(lineNum)行: \(messsage)")
    #endif
}
