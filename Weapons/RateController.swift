//
//  RateController.swift
//  Weapons
//
//  Created by wox on 2018/9/11.
//  Copyright © 2018年 wox. All rights reserved.
//

import UIKit

class RateController: UIViewController {


    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBAction func tapBackground(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dragStackView(_ sender: UIPanGestureRecognizer) {
        switch sender.state{
        case .changed:
            let translation = sender.translation(in: view)//将坐标转换为父视图中的坐标
            let position = CGAffineTransform(translationX: translation.x, y: translation.y)//stack view起始位置的坐标
            let angle = sin(translation.x / stackView.frame.width)//计算转动的角度
            stackView.transform = position.rotated(by: angle)//位置和角度的组合变形
            
            
            
        case .ended:
            UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5, animations:{
                self.stackView.transform = .identity}).startAnimation()//在0.5s之内自动回到原来的位置
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startPosition = CGAffineTransform(translationX: 500, y: 0)
        let startScale = CGAffineTransform(scaleX: 10, y: 10)//放大缩小的变换
        
        for button in rateButtons{
            button.alpha = 0 //透明度
            button.transform = startPosition.concatenating(startScale)
        }
        
//        stackView.transform = .init(translationX: 800, y: 0)//把它平移到800之外
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5){//弹性动画效果
            self.rateButtons[0].alpha = 1//透明变为不透明
            self.rateButtons[0].transform = .identity
        }.startAnimation(afterDelay: 0.1)
        
        UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5){//弹性动画效果
            self.rateButtons[1].alpha = 1
            self.rateButtons[1].transform = .identity
            }.startAnimation(afterDelay: 0.2)
        
        UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5){//弹性动画效果
            self.rateButtons[2].alpha = 1
            self.rateButtons[2].transform = .identity
            }.startAnimation(afterDelay: 0.3)
        
        UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5){//弹性动画效果
            self.rateButtons[3].alpha = 1
            self.rateButtons[3].transform = .identity
            }.startAnimation(afterDelay: 0.4)
        
        UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5){//弹性动画效果
            self.rateButtons[4].alpha = 1
            self.rateButtons[4].transform = .identity
            }.startAnimation(afterDelay: 0.5)
        
//        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeIn){//curve：入场效果淡入
//            self.stackView.transform = .identity//让stack view从屏幕外返回原来的位置
//        }
//        animator.startAnimation()//动画开始
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
