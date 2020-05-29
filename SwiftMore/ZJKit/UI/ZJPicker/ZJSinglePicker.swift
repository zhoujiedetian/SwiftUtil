//
//  ZJSinglePickerView.swift
//  YHTerminalShop
//
//  Created by 精灵要跳舞 on 2019/7/10.
//  Copyright © 2019 WMZ. All rights reserved.
//

import UIKit

/// 底部单项选择弹窗
class ZJSinglePicker: UIViewController {
    
    lazy var topView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgbFromHex(rgb: 0xf2f2f2)
        return view
    }()
    
    /// 取消按钮
    lazy var cancelBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(kNav_ThemeColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        return btn
    }()
    
    /// 确认按钮
    lazy var sureBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(UIColor.rgbFromHex(rgb: 0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(clickSure), for: .touchUpInside)
        return btn
    }()
    
    /// 标题lab
    lazy var titleLab : UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.rgbFromHex(rgb: 0x666666)
        return lab
    }()
    
    /// 显示日期picker
    lazy var picker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    /// 完成回调
    @objc var resultBlock : ((String, String)->())?
    
    private var dataArr : [Dictionary<String, String>]
    
    private var currentItem : (Dictionary<String, String>)?
    
    @objc init(with data : Array<Dictionary<String,String>>) {
        dataArr = data
        if dataArr.count > 0 {
            currentItem = dataArr.first
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
}

extension ZJSinglePicker {
    
    func setUpView() {
        view.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(40)
        }
        topView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        topView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        
        topView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.centerX.equalTo(self.topView.snp.centerX)
        }
        self.view.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.top.equalTo(cancelBtn.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
    }
}

extension ZJSinglePicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = dataArr[row]
        return item["name"]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentItem = dataArr[row]
    }
}

extension ZJSinglePicker {
    @objc func clickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSure() {
        if resultBlock != nil && currentItem != nil{
            resultBlock!(currentItem!["name"]!, currentItem!["id"]!)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
