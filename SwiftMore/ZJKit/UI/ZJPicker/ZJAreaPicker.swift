//
//  ZJAreaPicker.swift
//  YXPve
//
//  Created by 精灵要跳舞 on 2020/2/12.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJAreaPicker: UIViewController {
    
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
        lab.text = "请选择省市区"
        return lab
    }()
    
    /// 显示日期picker
    lazy var picker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    //选择的省索引
    var provinceIndex : Int
    //选择的市索引
    var cityIndex : Int
    //选择的区索引
    var districtIndex : Int
    
    /// 完成回调
    @objc var resultBlock : ((String, String)->())?
    
    private var dataArr : [Dictionary<String, Any>]?
    
    @objc init(with data : Array<Dictionary<String,Any>>?) {
        if data == nil {
            let path = Bundle.main.path(forResource: "Area_Json", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            // 带throws的方法需要抛异常
                do {
                          /*
                             * try 和 try! 的区别
                             * try 发生异常会跳到catch代码中
                             * try! 发生异常程序会直接crash
                             */
                        let data = try Data(contentsOf: url)
                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let jsonArr = jsonData as! NSArray
                        dataArr = jsonArr as? [Dictionary<String, Any>]
//                        for dict in jsonArr {
//                            print(dict)
//                        }
                } catch let error as Error? {
                    print("读取本地数据出现错误!",error as Any)
                }
        }else {
          dataArr = data!
        }
        provinceIndex = 0
        cityIndex = 0
        districtIndex = 0
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

extension ZJAreaPicker {
    
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

extension ZJAreaPicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
           return dataArr!.count
        }else if component == 1 {
            let provinceData = dataArr![provinceIndex]
            let cityData = provinceData["children"] as! Array<Dictionary<String, Any>>
            return cityData.count
        }else {
            //当前选中的省
            let provinceData = dataArr![provinceIndex]
            let cityData = provinceData["children"] as! Array<Dictionary<String, Any>>
            //当前选中的市
            let currentCityData = cityData[cityIndex]
            let districtData = currentCityData["children"] as! Array<Dictionary<String, String>>
            return districtData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let currentProvinceData = dataArr![row]
            return (currentProvinceData["areaName"] as! String)
        }else if component == 1 {
            let currentProvinceData = dataArr![provinceIndex]
            let cityData = currentProvinceData["children"] as! Array<Dictionary<String, Any>>
            let currentCityData = cityData[row]
            return (currentCityData["areaName"] as! String)
        }else {
            //当前选中的省
            let currentProvinceData = dataArr![provinceIndex]
            let cityData = currentProvinceData["children"] as! Array<Dictionary<String, Any>>
            //当前选中的市
            let currentCityData = cityData[cityIndex]
            let districtData = currentCityData["children"] as! Array<Dictionary<String, String>>
            let currentDistrictData = districtData[row]
            return (currentDistrictData["areaName"]!)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            provinceIndex = row
            cityIndex = 0
            districtIndex = 0
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        }else if component == 1 {
            cityIndex = row
            districtIndex = 0
            pickerView.selectRow(0, inComponent: 2, animated: true)
            pickerView.reloadComponent(2)
        }else {
            districtIndex = row
        }
    }
}

extension ZJAreaPicker {
    @objc func clickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSure() {
        if resultBlock != nil {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}
