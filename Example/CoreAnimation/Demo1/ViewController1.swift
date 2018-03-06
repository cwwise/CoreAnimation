//
//  ViewController1.swift
//  CoreAnimation
//
//  Created by chenwei on 2018/3/6.
//  Copyright © 2018年 chenwei. All rights reserved.
//

import UIKit
import Hue

class ViewController1: UIViewController, DefaultControllerConfiguration {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        let frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        let view = CircleProgressView(frame: frame)
        
        view.progressLayer.strokeEnd = 0.8
        self.view.addSubview(view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private class CircleProgressView: UIView {
    
    let progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSeparate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        let size = self.bounds.size
        let center = CGPoint(x: size.width/2, y: size.height/2)
        let lineWidth: CGFloat = 5
        let radius = min(size.width, size.height)/2 - lineWidth/2
        
        let startA = CGFloat(Double.pi/4*3)
        let endA = CGFloat(Double.pi/4*3+Double.pi/4*6)
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startA,
                                endAngle: endA,
                                clockwise: true)
        
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(hex: "#e5ebf6").cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = self.bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(hex: "#e5ebf6").cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.opacity = 0.75
        trackLayer.lineWidth = lineWidth
        trackLayer.path = path.cgPath
        trackLayer.strokeEnd = 1
        self.layer.addSublayer(trackLayer)
        
        let startColor = UIColor(hex: "#62ced1")
        let endColor = UIColor(hex: "#fdcc65")
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0,
                                     width: self.bounds.width, height: self.bounds.height)
        gradientLayer.locations = [0.5, 1]
        gradientLayer.colors = [startColor.cgColor,
                                endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradientLayer.mask = progressLayer
        self.layer.addSublayer(gradientLayer)
    }
    
    func setupSeparate() {
        
        let replicator = CAReplicatorLayer()
        let dot = CALayer()
        
        let dotLength: CGFloat = 6.0
        let dotHeight: CGFloat = 3.0
        let radius: CGFloat = self.bounds.width/2-6
        
        let offset: CGFloat = sqrt(2)/2 * radius + radius
        
        replicator.frame = self.bounds
        self.layer.addSublayer(replicator)
        
        dot.frame = CGRect(
            x: offset,
            y: offset,
            width: dotLength, height: dotHeight)
        dot.backgroundColor = UIColor(hex: "#e5ebf6").cgColor
        
        dot.transform = CATransform3DRotate(dot.transform,
                                            CGFloat((Double.pi)/4), 0, 0, 1)
        dot.cornerRadius = 1.5
        
        replicator.addSublayer(dot)
        replicator.instanceCount = 7
        
        let angle: CGFloat = CGFloat((Double.pi*2) / 8)
        replicator.instanceTransform = CATransform3DMakeRotation(-angle, 0, 0, 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
