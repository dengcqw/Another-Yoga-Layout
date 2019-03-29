//
//  YogaView.swift
//  TVGuor
//
//  Created by Deng Jinlong on 2018/10/30.
//  Copyright © 2018 xiaoguo. All rights reserved.
//

public class YogaView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    convenience init() {
        self.init(frame: .zero)
        initialize()
    }

    func initialize() {
        assertionFailure("initialize method need override")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if let superview = self.superview, !superview.isYogaEnabled {
            yoga.applyLayout(preservingOrigin: true)
        }
    }
}
