//
//  SectorLayer.swift
//  SectorAnimation
//
//  Created by Evgeniy Gushchin on 23/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit


class SegmentLayer: CAShapeLayer {
    
    let animationKey = "arcAnimation"
    let textPositionOffset: CGFloat = 0.67
    
    let textLayer = CATextLayer()
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .font               : UIFont.systemFont(ofSize: 14),
        .foregroundColor    : UIColor.black
    ]
    
    var title: String = "" {
        didSet {
            refreshLayers()
        }
    }
    
    var angles: (startAngle: CGFloat, endAngle: CGFloat) = (0.0, 0.0) {
        didSet {
            refreshLayers()
        }
    }
    
    var radius: CGFloat {
        guard  let bounds = superlayer?.bounds else {
            return 0.0
        }
        return min(bounds.width, bounds.height) * 0.5
    }
    
    var animated = false
    var animationDuration: CFTimeInterval = 2.0
    
    var endPath: UIBezierPath {
        guard  let bounds = superlayer?.bounds else {
            return UIBezierPath()
        }
        
        let center = bounds.center
        let arcPath = UIBezierPath(arcCenter: center, radius: radius/2, startAngle: angles.startAngle, endAngle: angles.endAngle, clockwise: true)
        strokeEnd = animated ? 0.0 : 1.0
        return arcPath
    }
    
    convenience override init() {
        self.init(animated: true)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        self.animated = (layer as! SegmentLayer).animated
    }
    
    init(animated: Bool) {
        super.init()
        self.animated = animated
        self.fillColor = UIColor.clear.cgColor
        self.addSublayer(textLayer)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        CATransaction.disableAnimations {
            let strokeEndCurrent = strokeEnd
            refreshLayers()
            strokeEnd = strokeEndCurrent
        }
    }
    
    // MARK: - Refresh layers
    
    func refreshLayers() {
        refreshLayerPath()
        refreshTextLayer()
    }
    
    func refreshLayerPath() {
        lineWidth = radius
        path = endPath.cgPath
    }
    
    func refreshTextLayer() {
        textLayer.string = NSAttributedString(string: title, attributes: textAttributes)
        
        let halfAngle = angles.startAngle + (angles.endAngle - angles.startAngle) * 0.5
        let segmentCenter = bounds.center.projected(by: radius * textPositionOffset, angle: halfAngle)
        let textToRender = textLayer.string as! NSAttributedString
        let renderRect = CGRect(centeredOn: segmentCenter, size: textToRender.size())
        textLayer.frame = renderRect
    }
    
    // MARK: - Animation
    
    func animate(duration: CFTimeInterval? = nil) {
        
        strokeEnd = 1
        let arcAnimation = segmentAnimation()
        arcAnimation.duration = duration ?? animationDuration
        self.add(segmentAnimation(), forKey: animationKey)
    }
    
    func segmentAnimation() -> CABasicAnimation {
        
        let arcAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        arcAnimation.fromValue = 0
        arcAnimation.toValue = 1
        arcAnimation.duration = animationDuration
        arcAnimation.delegate = self
    
        return arcAnimation
    }
    
}

extension SegmentLayer: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeAnimation(forKey: animationKey)
    }
}
