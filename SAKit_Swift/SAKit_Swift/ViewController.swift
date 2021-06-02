//
//  ViewController.swift
//  SAKit_Swift
//
//  Created by KerrDev on 29/05/2021.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let scrView = SABannerScrollView(frame: CGRect(x: 0, y: 100, width: Screen_Width, height: 200))
        scrView.backgroundColor = .blue
        self.view.addSubview(scrView)
        scrView.imageArray = ["https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0109f2578883a70000018c1b5aaea8.JPG%401280w_1l_2o_100sh.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624950401&t=9e6209edbc3c14b32a3eba33a2faa447","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01004c58f8524aa8012049ef5d4b03.jpg%401280w_1l_2o_100sh.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624950401&t=9c32ce93afdfa837ecfe6e6b0406d8de","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01abed58f07648a8012049eff62f7e.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624950401&t=5b2cb4207e5c054d8ef1aa8ad57fbbd3"]
        
    }


}

