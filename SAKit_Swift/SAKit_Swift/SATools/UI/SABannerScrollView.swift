//
//  SABannerScrollView.swift
//  SAKit_Swift
//
//  Created by KerrDev on 30/05/2021.
//

import UIKit

/// 轮播图
class SABannerScrollView: UIView {
    
    // MARK: - UI
    
    /// 滚动视图 -
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    /// 指示器 -
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
    }()
    
    /// 左图片
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 中图片 - 展示视图
    lazy var centerImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 右图片
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    /// 当前页码 -
    private var currentPage = 0
    
    private var timer: Timer?
    /// 滚动方向
    enum RollingDirection : Int {
        case Left
        case Right
    }
    /// 指示器当前页颜色
    var currentPageIndicatorTintColor:UIColor = .white{
        willSet{
            pageControl.currentPageIndicatorTintColor = newValue
        }
    }
    /// 指示器颜色
    var pageIndicatorTintColor:UIColor = .white{
        willSet{
            pageControl.pageIndicatorTintColor = newValue
        }
    }
    /// 是否自动滚动
    var autoRoll = false {
        willSet {
            if newValue {
                startTimer()
            } else {
                stopTimer()
            }
        }
    }
    /// 滚动方向
    var direction: RollingDirection = .Right {
        willSet {
            stopTimer()
        }
        didSet {
            if autoRoll {
                startTimer()
            }
        }
    }
    /// 间隔时间
    var timeInterval: TimeInterval = 3 {
        willSet {
            stopTimer()
        }
        didSet {
            if autoRoll {
                startTimer()
            }
        }
    }
    /// 图片数组
    var imageArray: [UIImage] = [] {
        willSet {
            stopTimer()
            currentPage = 0
            pageControl.numberOfPages = newValue.count
        }
        didSet {
            updateImage()
            if autoRoll {
                startTimer()
            }
        }
    }
    
    /// 滚动完成响应事件
    var operate: ((_ page: Int)->())?
    
    //重写父类初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")

    }
    
    
}
// MARK: - ==== 逻辑处理
extension SABannerScrollView{
    
    /// 核心代码
    private func updateImage() {
        if currentPage == 0 {
            leftImageView.image   = imageArray.last
            centerImageView.image = imageArray[currentPage]
            rightImageView.image  = imageArray[currentPage + 1]
        } else if currentPage == imageArray.count - 1 {
            leftImageView.image   = imageArray[currentPage - 1]
            centerImageView.image = imageArray[currentPage]
            rightImageView.image  = imageArray.first
        } else {
            leftImageView.image   = imageArray[currentPage - 1]
            centerImageView.image = imageArray[currentPage]
            rightImageView.image  = imageArray[currentPage + 1]
        }
        if let completeOperate = operate {
            completeOperate(currentPage)
        }
        pageControl.currentPage = currentPage
        scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)
    }
    
    
    //启动定时器
    private func startTimer() {
        timer = nil
        //调用自定义对象，让timer对其进行强引用，而不对视图控制器强引用
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [self] time in
            pageRoll()
        })
        
        
    }
    
    //关闭定时器
    private func stopTimer() {
        if let _ = timer?.isValid {
            timer?.invalidate()
            timer = nil
        }
    }
    
    //定时器触发方法
    @objc private func pageRoll() {
        switch direction {
        case .Left:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case .Right:
            scrollView.setContentOffset(CGPoint(x: width * 2, y: 0), animated: true)
        }
    }
    
}

extension SABannerScrollView : UIScrollViewDelegate{
    
    //MARK:-scrollViewDelegate
    //手动滑动停止调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        judgeDirection(ratio: scrollView.contentOffset.x / self.width)
    }
    //自动滑动停止调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        judgeDirection(ratio: scrollView.contentOffset.x / self.width)
    }
    
    //判断向左滑动还是向右滑动
    private func judgeDirection(ratio: CGFloat) {
        if ratio < 1 {
            if currentPage == 0 {
                currentPage = imageArray.count - 1
            } else {
                currentPage -= 1
            }
        } else if ratio > 1 {
            if currentPage == imageArray.count - 1 {
                currentPage = 0
            } else {
                currentPage += 1
            }
        }
        updateImage()
    }
    
}
