//
//  YogaScrollViewControler.swift
//  TVGuor
//
//  Created by Deng Jinlong on 2018/10/30.
//  Copyright © 2018 xiaoguo. All rights reserved.
//

public class YogaScrollViewControler: UIViewController {
    public let scrollView = UIScrollView()
    public let contentView = UIView()

    // insert empty grow view in where you want to expand, then show all views in one screen
    // and avoid big empty on the bottom screen
    public let emptyGrowView = UIView.growView()

    public func updateYGLayout(on contentView: UIView) {
        assertionFailure("updateLayout need override")
    }

    public override func loadView() {
        super.loadView()
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bounds = self.view.bounds
        scrollView.frame = bounds

        emptyGrowView.yoga.display = .none
        updateYGLayout(on: contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 0)
        contentView.yoga.applyLayout(preservingOrigin: true, dimensionFlexibility: .flexibleHeight)

        if contentView.frame.height > scrollView.frame.height {
            scrollView.contentSize = contentView.frame.size
        } else {
            if emptyGrowView.superview != nil {
                emptyGrowView.yoga.display = .flex
            }
            updateYGLayout(on: contentView)
            contentView.frame = bounds
            contentView.yoga.applyLayout(preservingOrigin: true)
            scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height + 1)
        }
    }
}
