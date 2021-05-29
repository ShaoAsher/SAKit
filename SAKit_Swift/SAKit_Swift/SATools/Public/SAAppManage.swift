//
//  SAAppManage.swift
//  MySwiftProject
//
//  Created by Ashao on 2021/3/28.
//

import UIKit

class SAAppManage: NSObject {
    
}

/// 获取当前活动的控制器
/// - Returns: 返回当前前活动的控制器
func GetRootTopVc() -> UIViewController {
    
    let window = UIApplication.shared.keyWindow
    
    var navVC = UINavigationController();
    
    var topVc = UIViewController()
    
    
    if window?.rootViewController is UINavigationController {
        
        navVC = window?.rootViewController as! UINavigationController
        
        
    }else if window?.rootViewController is UITabBarController {
        
        let tabBarVc = window?.rootViewController as! UITabBarController
        let selectVc = tabBarVc.selectedViewController
        if selectVc is UINavigationController {
            navVC = selectVc as! UINavigationController
        }
    }
    topVc = navVC.topViewController!
    return topVc
}






// MARK: - ======== UI相关

/// 屏幕的宽
public let Screen_Width = UIScreen.main.bounds.width

/// 屏幕的高
public let Screen_Height = UIScreen.main.bounds.height

/// 是否刘海屏
public let kDevice_iPhoneX_Series = UIScreen.main.bounds.size.height >= 812.0


public let kDevic_iphonex = (UIScreen.main.bounds.size.height == 812) || (UIScreen.main.bounds.size.height == 896)

/// 状态栏高度
public let KStatusBar_Height = (kDevice_iPhoneX_Series ? CGFloat(44) : CGFloat(20))

/// 导航栏高度
public let KNavBar_Height = (kDevice_iPhoneX_Series ? CGFloat(88) : CGFloat(64))

/// 底部高度
public let KBottom_Height = (kDevice_iPhoneX_Series ? CGFloat(33) : CGFloat(0))

/// 底部导航高度
public let KTabBar_Height = CGFloat(50)


public func AD(_ x:CGFloat) -> CGFloat {
    return x*UIScreen.main.bounds.size.width/375.0
}

/// RGB颜色
/// - Parameters:
///   - red: 红
///   - green: 绿
///   - blue: 蓝
///   - alpha: 不透明度
/// - Returns: 颜色对象
public func KColorRGB(red:CGFloat , green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red:red/255 , green: green/255, blue: blue/255, alpha: alpha)
}

/// RGB颜色 - 16进制
/// - Parameters:
///   - rgbHex: 16进制颜色
///   - alpha: 不透明度
/// - Returns: 颜色对象
public func KColorRGB(rgbHex:UInt ,alpha: CGFloat) -> UIColor {
    
    let red = CGFloat((rgbHex & 0xFF0000) >> 16)
    let green = CGFloat((rgbHex & 0x00FF00) >> 8)
    let blue = CGFloat(rgbHex & 0x0000FF)
    return UIColor(red:red/255 , green: green/255, blue: blue/255, alpha: alpha)
}



/// 获取字体对象
/// - Parameter size: 字体大小
/// - Returns: 字体对象
public func Kfont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

/// 获取粗文本字体对象
/// - Parameter size: 字体大小
/// - Returns: 字体对象
public func KBoldfont(size:CGFloat) -> UIFont{
    
    return UIFont.boldSystemFont(ofSize: size)
}

/// 获取图片对象
/// - Parameter name: 图片名字
/// - Returns: 字体对象
public func Kimage(name:String) -> UIImage{
    
    return UIImage(named: name) ?? UIImage();
}

extension Int{
    ///扩展缩放屏幕属性
    public var AD:CGFloat{
        return UIScreen.main.bounds.size.width/375.0 * CGFloat(self)
    }
}
