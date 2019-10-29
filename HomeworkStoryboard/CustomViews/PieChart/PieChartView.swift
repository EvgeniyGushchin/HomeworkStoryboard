//
//  PileChartView.swift
//  SectorAnimation
//
//  Created by Evgeniy Gushchin on 23/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

struct Segment {
    let color: UIColor
    let value: CGFloat
    let title: String
}

class PieChartView: UIView {
    
    let kAnimationCompletionBlock = "animationCompletionBlock"
    
    var animated = true
    var animationDuration = 2.0
    
    var segments: [Segment] = [] {
        didSet {
            addSegments()
        }
    }
    
    var totalSegmentsValue: CGFloat {
        segments.reduce(0, { $0 + $1.value })
    }
    
    var segmentLayers: [SegmentLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.sublayers?.forEach {
            $0.frame = layer.bounds
        }
    }
    
    private func setup() {
        isOpaque = false
    }
    
    private func addSegments() {
        
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        segmentLayers = []
        prepareSegments()
        if animated {
            animate()
        } else {
            segmentLayers.forEach { appendSegmentLayer($0) }
        }
    }
    
    private  func prepareSegments() {
        var startAngle = -CGFloat.pi * 0.5
        for segment in segments {
            let segmentLayer = SegmentLayer(animated: animated)
            let endAngle = getEndAngle(startAngle: startAngle,
                                       segmentValue: segment.value,
                                       totalValue: totalSegmentsValue)
            segmentLayer.strokeColor = segment.color.cgColor
            segmentLayer.angles = (startAngle, endAngle)
            segmentLayer.title = segment.title
            startAngle = endAngle
            segmentLayers.append(segmentLayer)
        }
    }
    
    private func getEndAngle(startAngle: CGFloat,
                             segmentValue: CGFloat,
                             totalValue: CGFloat) -> CGFloat {
        
        return startAngle + 2 * .pi * (segmentValue / totalValue)
    }
    
    private func appendSegmentLayer(_ segmentLayer: SegmentLayer) {
        layer.addSublayer(segmentLayer)
        segmentLayer.refreshLayers()
        segmentLayer.strokeEnd = 1.0
    }
    
    // MARK: - Animation
    
    func animate() {
        guard animated else {
            return
        }
        
        layer.sublayers?.forEach {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        }
        
        if segments.count > 0 {
            animateSegment(0)
        }
    }
    
    private func addAnimation(segmentLayer: SegmentLayer, segment: Segment) {
        let anim = segmentLayer.segmentAnimation()
        anim.duration = animationDuration * Double(segment.value / totalSegmentsValue)
        anim.delegate = self
        
        let completionBlock = { [weak self] in
            guard let self = self else {
                return
            }
            if let index = self.segmentLayers.firstIndex(of: segmentLayer) {
                let next = index.advanced(by: 1)
                if next < self.segmentLayers.count {
                    self.animateSegment(next)
                }
            }
        }
        anim.setValue(completionBlock, forKey: kAnimationCompletionBlock)
        segmentLayer.add(anim, forKey: nil)
    }
    
    private func animateSegment(_ index: Int) {
        let segmentLayer = segmentLayers[index]
        appendSegmentLayer(segmentLayer)
        addAnimation(segmentLayer: segmentLayer, segment: segments[index])
    }
}


extension PieChartView: CAAnimationDelegate {
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let completion = anim.value(forKey: kAnimationCompletionBlock) as? ()->() {
            if flag {
                completion()
            }
        }
    }
    
}
