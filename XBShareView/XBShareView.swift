//
//  XBShareView.swift
//  XBShareView
//
//  Created by xubojoy on 2018/6/21.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
/// 全屏宽度
let kScreenWitdh = UIScreen.main.bounds.width
/// 全屏高度，不含状态栏高度
let kScreenHeight = UIScreen.main.bounds.height
let button_width: Int = 90

class XBShareView: UIView {

    let SPACE_WIDTH: Float = Float((kScreenWitdh-180)/3)
    
    var shareImage: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    /// 创建子视图
    func setupUI() {
        let label = UILabel()
        label.text = "分享到"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 60, height: 20))
        }
        
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor.lightGray
        self.addSubview(leftLine)
        leftLine.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(label.snp.left).offset(-10)
            make.centerY.equalTo(label.snp.centerY)
            make.height.equalTo(0.5)
        }
        
        let rightLine = UIView()
        rightLine.backgroundColor = UIColor.lightGray
        self.addSubview(rightLine)
        rightLine.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(10)
            make.right.equalTo(-20)
            make.centerY.equalTo(label.snp.centerY)
            make.height.equalTo(0.5)
        }
        
        let iconArray = ["wei_chat_64","time_line_64"]
        var buttonArray = Array<UIButton>()
        
        //布局按钮
        for i in 0..<2 {
            let button = UIButton(type: .custom)
            self.addSubview(button)
            button.setImage(UIImage(named: iconArray[i]), for: .normal)
            let left_space = Float(i + 1) * SPACE_WIDTH + Float((i * button_width))
            button.snp.makeConstraints { (make) in
                make.left.equalTo(left_space)
                make.top.equalTo(label.snp.bottom).offset(5)
                make.size.equalTo(CGSize(width: button_width ,height: button_width))
            }
            button.tag = i + 1
            button.layer.cornerRadius = CGFloat(button_width/2)
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
            buttonArray.append(button)
        }
        
        //按钮动画
        for button in buttonArray {
            let index = buttonArray.index(of: button)
            let fromTransform: CGAffineTransform = CGAffineTransform(translationX: 0, y: 150)
            button.transform = fromTransform
            button.alpha = 0.3
            UIView.animate(withDuration: 0.9+Double(index!)*0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                button.transform = CGAffineTransform.identity
                button.alpha = 1
            }) { (finished) in
                
            }
        }
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(#imageLiteral(resourceName: "close_48"), for: .normal)
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 60 ,height: 60))
        }
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        
    }
    
    /// 显示分享视图
    ///
    /// - Parameter shareView: <#shareView description#>
    func showShareView(shareView: UIView)  {
        shareView.frame = CGRect(x: 0, y: kScreenHeight+160, width: kScreenWitdh, height: 160)
        UIView.animate(withDuration: 0.5) {
            shareView.frame = CGRect(x: 0, y: kScreenHeight-160, width: kScreenWitdh, height: 160)
        }
    }
    
    /// 分享点击
    ///
    /// - Parameter sender: <#sender description#>
    @objc func shareBtnClick(_ sender:UIButton) {
        let shareProcessor = ShareProcessor()
        shareProcessor.showShareViewWithImage(image: self.shareImage,platForm: XBShareType(rawValue: sender.tag)!)
    }
    
    /// 关闭/隐藏
    @objc func closeButtonClick() {
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: kScreenHeight+160, width: kScreenWitdh, height: 160)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
