//
//  ZJDatePicker.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/6/19.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJDatePicker: UIViewController {
    
    @objc enum ZJDatePickerDateFormater : Int {
        case YEAR
        case YEARMONTH
        case YEARMONTHDAY
    }
    
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
    
    /// picker类型
    var pickerType : ZJDatePickerDateFormater
    
    /// 标题
    var titleString : String?
    
    /// 年份数组
    var yearArr : Array<Int>
    
    /// 月份数组
    var monthArr : Array<Int> {
       return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    }
    
    /// 当前选择年份
    var currentYear : Int
    
    /// 当前选择月份
    var currentMonth : Int
    
    /// 当前选择日期
    var currentDay : Int
    
    /// 日期数组
    var dayArr : Array<Int> {
        var temp = [Int]()
        var dayNum = 0 ;
        if currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12 {
            dayNum = 31
        }
        if currentMonth == 4 || currentMonth == 6 || currentMonth == 9 || currentMonth == 11 {
            dayNum = 30
        }
        if currentYear % 4 == 0 && currentMonth == 2{
            dayNum = 29
        }
        if currentYear % 4 != 0 && currentMonth == 2{
            dayNum = 28
        }
        for i in 1 ... dayNum {
            temp.append(i)
        }
        return temp
    }
    
    /// 完成回调
    @objc var resultBlock : ((Int, Int, Int)->())?
    
    /// 根据类型来初始化datePicker显示的样式
    ///
    /// - Parameter type: ZJDatePickerDateFormater
    @objc init(type: ZJDatePickerDateFormater, title: String?) {
        pickerType = type
        titleString = title
        yearArr = [Int]()
        currentYear = 0
        currentMonth = 0
        currentDay = 0
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

extension ZJDatePicker {
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
        switch pickerType {
        case .YEAR:
            titleLab.text = (titleString != nil) ? titleString : "请选择年份"
        case .YEARMONTH:
            titleLab.text = (titleString != nil) ? titleString : "请选择年月"
        case .YEARMONTHDAY:
            titleLab.text = (titleString != nil) ? titleString : "请选择年月日"
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
        
        let currentDate = Date()
        let calendar = Calendar.current
        currentYear = calendar.component(.year, from: currentDate)
        currentMonth = calendar.component(.month, from: currentDate)
        currentDay = calendar.component(.day, from: currentDate)
        
        for i in 1970 ..< currentYear + 10 {
            yearArr.append(i)
        }
        let yearIndex = yearArr.firstIndex(of: currentYear)
        picker.selectRow(yearIndex!, inComponent: 0, animated: true)
        
        if pickerType == .YEARMONTH || pickerType == .YEARMONTHDAY{
            let monthIndex = monthArr.firstIndex(of: currentMonth)
            picker.selectRow(monthIndex!, inComponent: 1, animated: true)
        }
        if pickerType == .YEARMONTHDAY {
            let dayIndex = dayArr.firstIndex(of: currentDay)
            picker.selectRow(dayIndex!, inComponent: 2, animated: true)
        }
    }
}

extension ZJDatePicker : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerType {
        case .YEAR:
            return 1
        case .YEARMONTH:
            return 2
        case .YEARMONTHDAY:
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .YEAR:
            return yearArr.count
        case .YEARMONTH:
            if component == 0 {
                return yearArr.count
            }
            return monthArr.count
        case .YEARMONTHDAY:
            if component == 0 {
                return yearArr.count
            }else if component == 1 {
                return monthArr.count
            }
            return dayArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        case .YEAR:
            return String(yearArr[row]) + "年"
        case .YEARMONTH:
            if component == 0 {
                return String(yearArr[row]) + "年"
            }
            return String(monthArr[row]) + "月"
        case .YEARMONTHDAY:
            if component == 0 {
                return String(yearArr[row]) + "年"
            }else if component == 1 {
                return String(monthArr[row]) + "月"
            }
            return String(dayArr[row]) + "日"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentYear = yearArr[row]
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        }else if component == 1 {
            currentMonth = monthArr[row]
            pickerView.reloadComponent(2)
        }else {
            currentDay = dayArr[row]
        }
    }
}

extension ZJDatePicker {
    @objc func clickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSure() {
        if let newBlock = resultBlock {
            switch pickerType {
            case .YEAR:
                newBlock(currentYear,0,0)
            case .YEARMONTH:
                newBlock(currentYear,currentMonth,0)
            case .YEARMONTHDAY:
                newBlock(currentYear,currentMonth,currentDay)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
