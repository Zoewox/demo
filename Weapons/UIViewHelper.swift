//
//  UIViewHelper.swift
//  Weapons
//
//  Created by wox on 2018/8/13.
//  Copyright © 2018年 wox. All rights reserved.
//

import  UIKit

extension UIView{
    //修饰符 使其可见
    @IBInspectable
    //计算属性
    //圆角半径 浮点型cgfloat,cg是跟图形有关
    var cornerRadius: CGFloat {
        get {
            //图层默认属性
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    //默认可能没有阴影颜色 加?
    var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil //判断有没有颜色 有就构造器转换成UIcolor
        }
        set {
            layer.shadowColor   = newValue?.cgColor //图层中的是cgcolor 所以要做一个强制转换
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
}
