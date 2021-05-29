//
//  SANotificationCenterManage.swift
//  MySwiftProject
//
//  Created by Ashao on 2021/4/19.
//

import UIKit


let notificationCenterManage = SANotificationCenterManage()

/// 通知管理类
class SANotificationCenterManage: NSObject {

    
    
    /// 发送通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 发送者
    ///   - userInfo: 参数
    /// - Returns:
    public func addPostNotification(name:String,
                                object:AnyObject,
                                userInfo:[AnyHashable : Any]? = nil) -> Void {
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo:userInfo)
        
    }
    

    
    /// 接收通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 接收者
    ///   - noteBlock: 通知回调
    public func addRegisterObserver(name:String,
                            object : AnyObject,
                            noteBlock : @escaping(_ note: Notification)->Void){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: object, queue: OperationQueue.main) { (note) in
            
            noteBlock(note)
        }
        
    }
    
    
    
}
