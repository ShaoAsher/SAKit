//
//  ASExtension.swift
//  MySwiftProject
//
//  Created by Ashao on 2021/3/28.
//

import UIKit
@_exported import SnapKit

class SAUIViewExtension: UIView {
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
// MARK: - === 视图扩展
extension UIView{
    
    /// 添加圆角
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - masksToBounds: 是否切割
    public func saAddCornerRadius(cornerRadius:CGFloat,masksToBounds:Bool){
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
    }
    
    
    /// 添加边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    public func saAddBorder(borderWidth:CGFloat,borderColor:UIColor){
        
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
        
        
    }
    
    /// 线条位置 - 枚举
    public enum SALineLocationType:NSInteger {
        case top = 0
        case left = 1
        case right = 2
        case bottom = 3
        case center = 4
    }
    
    /// 添加线条
    /// - Parameters:
    ///   - location: 线条位置
    ///   - startDistance: 线条开始位置
    ///   - lineColor: 线条颜色
    ///   - lineWidth: 线条宽度
    ///   - lineLengthMultipliedBy: 线条长度比(相对于父视图)
    public func saAddLine(location:SALineLocationType,
                          startDistance:CGFloat,
                          lineColor:UIColor,
                          lineWidth:CGFloat,
                          lineLengthMultipliedBy:CGFloat){
        
        let line = UIView()
        line.backgroundColor = lineColor
        addSubview(line)
        
        switch location {
        case .top: //在上面
            line.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(startDistance)
                make.width.equalToSuperview().multipliedBy(lineLengthMultipliedBy)
                make.height.equalTo(lineWidth)
            }
        case .left: //在左边
            line.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(startDistance)
                make.left.equalToSuperview()
                make.width.equalTo(lineWidth)
                make.height.equalToSuperview().multipliedBy(lineLengthMultipliedBy)
            }
        case .right: //在右边
            line.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(startDistance)
                make.right.equalToSuperview()
                make.width.equalTo(lineWidth)
                make.height.equalToSuperview().multipliedBy(lineLengthMultipliedBy)
            }
        case .bottom://在下面
            line.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(startDistance)
                make.width.equalToSuperview().multipliedBy(lineLengthMultipliedBy)
                make.height.equalTo(lineWidth)
            }
        case .center: //在中间
            line.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(startDistance)
                make.width.equalToSuperview().multipliedBy(lineLengthMultipliedBy)
                make.height.equalTo(lineWidth)
            }
            
        }
        
        
    }
    

    

    

    
    /// 添加渐变颜色
    /// - Parameters:
    ///   - colors:  颜色色组
    ///   - startPoint: 开始坐标(0 -1)
    ///   - endPoint: 结束坐标(0 - 1)
    func setLayerColors(_ colors:[CGColor],
                        startPoint:CGPoint,
                        endPoint:CGPoint)  {
        
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(layer)
        
    }
    
    
}


// MARK: - === 按钮扩展
typealias BtnAction = (UIButton)->()

extension UIButton{
    private struct AssociatedKeys{
        static var actionKey = "actionKey"
    }
    
    @objc dynamic var action: BtnAction? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let action = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? BtnAction{
                return action
            }
            return nil
        }
    }
    
    func saAddAction(action:@escaping  BtnAction ){
        self.action = action
        self.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
    }
    
    @objc func touchUpInSideBtnAction(btn: UIButton) {
        if let action = self.action {
            action(self)
        }
    }
    
}



// MARK: - ===== 输入框扩展
extension UITextField{
    
    private struct placeholderColorKey{
        static var identifier:String = "placeholderColorKey"
    }
    
    var placeholderColor : UIColor{
        get{
            return objc_getAssociatedObject(self, &placeholderColorKey.identifier) as!UIColor
        }
        set(newColor){
            
            objc_setAssociatedObject(self, &placeholderColorKey.identifier, newColor, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            let attrString = NSMutableAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:newColor,NSAttributedString.Key.font:self.font ?? UIFont.systemFont(ofSize: 15)] )
            self.attributedPlaceholder = attrString
        }
    }
    
    
}
