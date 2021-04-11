//
//  ViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by  on 3/18/21.
// By: Mohammed Musleh

import UIKit

class ViewController: UIViewController {
    
    var animLayer : CALayer?
    var trumpetLayer : CALayer?
    
    @IBAction func unwideToHomecontroller(sender : UIStoryboardSegue){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let animImage = UIImage(named: "drums.png")
        animLayer = CALayer.init()
        animLayer?.contents = animImage?.cgImage
        
        animLayer?.bounds = CGRect(x: 0, y: 0, width: 240, height: 134)
        animLayer?.position = CGPoint(x: 275, y: 250)
        
        self.view.layer.addSublayer(animLayer!)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        rotateAnimation.fromValue = -1*Double.pi/2
        rotateAnimation.toValue = Double.pi/2
        rotateAnimation.autoreverses = true
        
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1.0
        
        rotateAnimation.repeatCount = Float.infinity
        animLayer?.add(rotateAnimation, forKey: "spin")
        
        let trImage = UIImage(named: "trumpet.png")
        trumpetLayer = CALayer.init()
        trumpetLayer?.contents = trImage?.cgImage
        
        trumpetLayer?.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        trumpetLayer?.position = CGPoint(x: 275, y: 550)
        
        self.view.layer.addSublayer(trumpetLayer!)
        
        let flyAnimation = CABasicAnimation(keyPath: "position")
        flyAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        flyAnimation.fromValue = NSValue.init(cgPoint: CGPoint(x:275, y:550))
        flyAnimation.toValue = NSValue.init(cgPoint: CGPoint(x:275, y:750))
        
        flyAnimation.isRemovedOnCompletion = false
        flyAnimation.duration = 1
        flyAnimation.repeatCount = Float.infinity
        flyAnimation.autoreverses = true
        
        trumpetLayer?.add(flyAnimation, forKey: "fly")
        
    }


}

