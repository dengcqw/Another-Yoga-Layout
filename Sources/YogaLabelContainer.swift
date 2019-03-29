//
//  YogaLabelContainer.swift
//  TVGuor
//
//  Created by Deng Jinlong on 2018/10/30.
//  Copyright © 2018 xiaoguo. All rights reserved.
//

import YogaKit

public class YogaLabelContainer: UIView {
    let label: UILabel!
    public var textAlign: NSTextAlignment = .left

    /// true keep label size equal to container, false keep label fit its content
    public var keepSizeEqual: Bool = false

    public init(_ label: UILabel, align: NSTextAlignment = .left) {
        label.yoga.isIncludedInLayout = false
        self.label = label
        super.init(frame: .zero)
        addSubview(label)
        clipsToBounds = true
        yoga.isEnabled = true
        textAlign = align
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        if keepSizeEqual {
            label.frame = bounds
        } else {
            let labelSize = label.sizeThatFits(bounds.size)
            let labelHeight = min(labelSize.height, bounds.height)
            let yPos = (bounds.height - labelHeight) / 2.0
            if textAlign == .center {
                label.frame = CGRect.init(x: (bounds.width - labelSize.width)/2, y: yPos, width: labelSize.width, height: labelHeight)
            } else if textAlign == .right {
                label.frame = CGRect.init(x: bounds.width - labelSize.width, y: yPos, width: labelSize.width, height: labelHeight)
            } else {
                label.frame = CGRect.init(x: 0, y: yPos, width: labelSize.width, height: labelHeight)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // if height is given, `sizeThatFits` not invoked,
    // and returned width of size not used,
    // so we can suppose `sizeThatFits` useed to calculate height
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelSize = label.sizeThatFits(size)
        return CGSize(width: min(labelSize.width, size.width), height: min(labelSize.height, size.height))
    }
}

