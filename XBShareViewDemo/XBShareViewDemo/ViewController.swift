//
//  ViewController.swift
//  XBShareViewDemo
//
//  Created by xubojoy on 2018/6/21.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var xbShareView:XBShareView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let closeButton = UIButton(type: .custom)
        closeButton.setTitle("按钮", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeButton.backgroundColor = .brown
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view.snp.centerY)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize(width: 60 ,height: 60))
        }
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
    }
    
    @objc func closeButtonClick()  {
        if self.xbShareView == nil {
            self.xbShareView = XBShareView()
            self.xbShareView.backgroundColor = .white
            self.view.addSubview(self.xbShareView)
        }
        self.xbShareView.showShareView(shareView: self.xbShareView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

