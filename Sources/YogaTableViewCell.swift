//
//  YogaTableViewCell.swift
//  TVGuor
//
//  Created by Deng Jinlong on 17/04/2018.
//  Copyright © 2018 xiaoguo. All rights reserved.
//

import YogaKit

extension UIView {
    public static func growView() -> UIView {
        let view = UIView()
        view.yoga.isEnabled = true
        view.yoga.flexGrow = 1
        return view
    }
}

//// NOTE: create subview in buildContentBlock, or yoga will crash
//public class YogaStaticCellModel: StaticCellModel {
//}
//public class YogaStaticCell: TableViewCell {
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.yoga.isEnabled = true
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override public func renderCell(with cellModel: TableViewCellViewModel, animated: Bool) {
//        super.renderCell(with: cellModel, animated: animated)
//        if let model = cellModel as? YogaStaticCellModel {
//            let container = UIView()
//            container.configureLayout { (yg) in
//                yg.isEnabled = true
//                yg.flexGrow = 1
//            }
//            model.buildContentBlock?(container)
//            contentView.addSubview(container)
//        }
//    }
//
//    override public func prepareForReuse() {
//        super.prepareForReuse()
//        contentView.removeAllSubviews()
//    }
//
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.yoga.applyLayout(preservingOrigin: false)
//    }
//}

/*
 .flex = YGUndefined,
 .flexGrow = YGUndefined,
 .flexShrink = YGUndefined,
 .flexBasis = YG_AUTO_VALUES,
 .justifyContent = YGJustifyFlexStart,
 .alignItems = YGAlignStretch,
 .alignContent = YGAlignFlexStart,
 .direction = YGDirectionInherit,
 .flexDirection = YGFlexDirectionColumn,
 .overflow = YGOverflowVisible,
 .display = YGDisplayFlex,
 .dimensions = YG_DEFAULT_DIMENSION_VALUES_AUTO_UNIT,
 .minDimensions = YG_DEFAULT_DIMENSION_VALUES_UNIT,
 .maxDimensions = YG_DEFAULT_DIMENSION_VALUES_UNIT,
 .position = YG_DEFAULT_EDGE_VALUES_UNIT,
 .margin = YG_DEFAULT_EDGE_VALUES_UNIT,
 .padding = YG_DEFAULT_EDGE_VALUES_UNIT,
 .border = YG_DEFAULT_EDGE_VALUES_UNIT,
 .aspectRatio = YGUndefined,
 */
