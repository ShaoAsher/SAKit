//
//  SAAlertManageView.swift
//  MySwiftProject
//
//  Created by Ashao on 2021/4/17.
//

import UIKit
import SnapKit

/// 提示弹窗 - 管理视图
class SAAlertManageView: UIView {

    
 
    typealias indexClickBlock = (_ index:NSInteger)->Void;
    
    /// 显示一个按钮弹窗的系统弹窗
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 弹窗内容
    ///   - cancelTitle: 取消标题
    ///   - block: 回调
    public static func showOneAlert(title:String,
                             message:String,
                             cancelTitle:String,
                             block:@escaping indexClickBlock){
        
        let act = UIAlertAction(title: cancelTitle, style: .cancel) { (act) in
            
            block(0)
        }
        
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(act)
        GetRootTopVc().present(alertVc, animated: true, completion: nil)
    }
    
    /// 显示两个按钮弹窗的系统弹窗
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 弹窗内容
    ///   - cancelTitle: 取消标题
    ///   - confirmTitle: 确认标题
    ///   - block: 回调
    public static func showTwoAlert(title:String,message:String,
                             cancelTitle:String,
                             confirmTitle:String,
                             block:@escaping indexClickBlock){
        
        let act = UIAlertAction(title: cancelTitle, style: .cancel) { (act) in
            
            block(0)
        }
        
        let act2 = UIAlertAction(title: confirmTitle, style: .default) { (act) in
            
            block(1)
        }
        
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(act)
        alertVc.addAction(act2)
        GetRootTopVc().present(alertVc, animated: true, completion: nil)
    }
    
    
    
    /// 线条位置 - 枚举
    public enum ASCustomAlertLocationType:NSInteger {
        case top = 0
        case center = 1
        case bottom = 3
    }
    
    
    /// 自定义默认提示窗
    /// - Parameters:
    ///   - message: 提示内容
    ///   - duration: 显示时间
    ///   - type: 显示位置
    ///   - block: 回调
    public static func showCustomAlert(message:String,
                                duration:TimeInterval,
                                type:ASCustomAlertLocationType,
                                block: indexClickBlock? = nil){
        
        let bgView = UIView()
        bgView.backgroundColor = .clear
        UIApplication.shared.keyWindow?.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        contentView.backgroundColor = KColorRGB(red: 30, green: 30, blue: 30, alpha: 0.8)
        contentView.saAddCornerRadius(cornerRadius: 5, masksToBounds: true)
        bgView.addSubview(contentView)
 
        
        let messageLable = UILabel()
        messageLable.textColor = .white
        messageLable.font = Kfont(size: 16)
        messageLable.textAlignment = .center
        messageLable.numberOfLines = 0
        messageLable.text = message
        contentView.addSubview(messageLable)
        messageLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        //位置
        
        switch type {
        case .top:
            contentView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(40)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.7)
            }
        case .center:
            contentView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.7)
            }
        case .bottom:
            contentView.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.7)
            }
        }
        
        //延迟调用
        DispatchQueue.main.asyncAfter(deadline: .now()+duration) {
            
            //动画
            UIView.animate(withDuration: 1) {
                bgView.alpha = 0
            } completion: { (ok) in
                bgView.removeFromSuperview()
            }
            block?(0)
        }
        
   

        
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
