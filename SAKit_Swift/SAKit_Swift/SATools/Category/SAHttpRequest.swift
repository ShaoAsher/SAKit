//
//  SAHttpRequest.swift
//  MySwiftProject
//
//  Created by Ashao on 2021/3/28.
//

import UIKit
@_exported import Alamofire
@_exported import SVProgressHUD




/// 数据请求： 管理类
class SAHttpRequest: NSObject {
    
    ///成功回调
    typealias ASSuccessBlock = (_ json:NSDictionary)->Void;
    ///失败回调
    typealias ASFailBlock = (_ Error:Error)->Void;
    
    var headers: HTTPHeaders = [
        HTTPHeader(name: "Accept", value: "application/json")
    ]
    
    // MARK: - === Get请求
    
    /// 数据请求
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 包体
    ///   - successBlock: 成功回调
    ///   - failBlock: 失败回调
    /// - Returns: 返回值
    open func saGetHttpRequestDate(url:String,params:Parameters, successBlock:@escaping ASSuccessBlock,failBlock:  @escaping ASFailBlock) -> Void {
        
        
        AF.request(url, method: .get, parameters: params, headers: headers).responseJSON  { response in
            
            if response.data != nil{
                
                // 判断数据是否存在
                guard response.value != nil else { return }
                
                let json = response.value as? NSDictionary ??  NSDictionary()
        
                successBlock(json)
                

            }else{
                
                if response.error != nil{
                    failBlock(response.error!)
                }
                
                SVProgressHUD.showError(withStatus: "网络错误或服务器异常")
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    SVProgressHUD.dismiss()
                }
                
            }
            
        }
        
    }
    
    
    
    // MARK: - === Post请求
    
    /// 数据请求
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 包体
    ///   - successBlock: 成功回调
    ///   - failBlock: 失败回调
    /// - Returns: 返回值
    open func saPostHttpRequestDate(url:String,params:Parameters, successBlock:@escaping ASSuccessBlock,failBlock:  @escaping ASFailBlock) -> Void {
        
        
        AF.request(url, method: .post, parameters: params, headers: headers).responseJSON  { response in
            
            if response.data != nil{
                
                // 判断数据是否存在
                guard response.value != nil else { return }
                
                let json = response.value as? NSDictionary ??  NSDictionary()

                successBlock(json)

            }else{
                
                if response.error != nil{
                    failBlock(response.error!)
                }
                SVProgressHUD.showError(withStatus: "网络错误或服务器异常")
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    SVProgressHUD.dismiss()
                }
                
            }
            
        }
        
        
    }
    
    
    
    
}

