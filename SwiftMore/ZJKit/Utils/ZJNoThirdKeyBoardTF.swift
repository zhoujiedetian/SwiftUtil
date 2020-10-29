//
//  ZJNoThirdKeyBoardTF.swift
//  SwiftMore
//
//  Created by zhoujie on 2020/10/29.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJNoThirdKeyBoardTF: UIView, UITextFieldDelegate {
    private var textfield : UITextField

    var text : String? {
        set {
            textfield.text = newValue
        }
        
        get {
            return textfield.text
        }
    }
    
    var font : UIFont? {
        willSet {
            textfield.font = font
        }
    }

    override init(frame: CGRect) {
        textfield = UITextField.init()
        super.init(frame: frame)
        textfield.delegate = self
        addSubview(textfield)
        addNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textfield.frame = bounds
        print(textfield.frame)
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyBoardWillShow() {
        textfield.isSecureTextEntry = false
    }
}

extension ZJNoThirdKeyBoardTF : UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textfield.isSecureTextEntry = true
    }
}
