//
//  AudioEffectListController.swift
//  LayoutDemo
//
//  Created by Deng Jinlong on 2019/3/29.
//  Copyright © 2019 tvguo. All rights reserved.
//

import UIKit
import TableViewAdaptor
import AnotherYogaWrapper

final class AudioEffectListController: UIViewController {
    private let tableView = UITableView()
    private let adaptor = TableViewAdaptor()
    public var selectedIndex = 0

    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: 0xEEF2F9)
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. use original -register method to bind cell and cellmodel
        tableView.register(Cell.self, forCellReuseIdentifier: CellModel.reuseIdentifier)
        // 2. set weak reference and tableview delegate & datasource
        adaptor.tableView = tableView
        // 3. build cellmodels
        adaptor.cellModels = AudioEffectData.enumerated().compactMap { (index, data) in
            let _model = CellModel(data)
            _model.selected = (index == self.selectedIndex)
            _model.buttonAction = { [weak self] selectedModel in
                guard let ss = self else { return }
                guard let cellModels = ss.adaptor.cellModels else { return }
                cellModels.forEach { $0.selected = false }
                selectedModel.selected = true
                ss.tableView.reloadData()
                
                if let index = cellModels.firstIndex(of: selectedModel) {
                    print("selected index is \(index)")
                }
            }
            return _model
        }
        
        self.title = TVGTitle.AudioEffect
        tableView.tableFooterView = FooterView(frame: CGRect.zero.update(height: 40))
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }

    final private class CellModel: TableViewCellViewModel {
        var data: [String: String]
        init(_ data: [String: String]) {
            self.data = data
            super.init()
        }

        var buttonAction: ((CellModel)->Void)?

        override func preferedCellHeight() -> CGFloat {
            return 100 + 10
        }
    }

    final private class Cell: TableViewCell {
        static let buttonSize: CGSize = CGSize(width: 70.0, height: 27.0)
        var buttonSize: CGSize {
            return Cell.buttonSize
        }

        let icon = UIImageView(image: UIImage(named: "Player_AudioEffect_1"))
        let labelContainer = UIView()
        let titleLabel = UILabel().mapSelf {
            $0.textColor = UIColor.init(hex: 0x333333)
            $0.font = UIFont.boldSystemFont(ofSize: 15)
        }
        let subTitleLabel = UILabel().mapSelf {
            $0.textColor = UIColor.init(hex: 0x666666)
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.numberOfLines = 1
        }
        let button = UseButton().mapSelf {
            $0.setAttributedTitle("未使用".attrString().addFont(13).addColor(0x333333), for: .normal)
            $0.setAttributedTitle("已使用".attrString().addFont(13).addColor(0x45B045), for: .selected)
            $0.layer.borderWidth = UIView.onePixel
            $0.layer.cornerRadius = buttonSize.height / 2.0
        }

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            contentView.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.cornerRadius = 4.0
            contentView.layer.shadowOpacity = 0.02
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }

        @objc func buttonAction() {
            if let model = cellModel as? CellModel {
                model.buttonAction?(model)
            }
        }

        override func renderCell(with cellModel: TableViewCellViewModel, animated: Bool) {
            super.renderCell(with: cellModel, animated: animated)
            backgroundColor = .clear
            guard let model = cellModel as? CellModel else { return }
            let data = model.data
            update(imgName: data["icon"]!, title: data["title"]!, subTitle: data["subtitle"]!, selected: model.selected)
        }

        func update(imgName: String, title: String, subTitle: String, selected: Bool) {
            icon.image = UIImage(named: imgName)
            titleLabel.text = title
            subTitleLabel.text = subTitle
            button.isSelected = selected
            
            updateYoga()
        }

        // rebuild view hierarchy
        // and mark view dirty
        // and change yoga property if need
        // final layout, or invoke `setNeedLayout`
        func updateYoga() {
            self.contentView.clipsToBounds = true
            
            YogaContainerLayout(labelContainer)
                .add(titleLabel.ygRelativeLayout.height(21).margin(bottom: 5))
                .add(subTitleLabel.ygRelativeLayout)
                .column()
                .mainAxis(.center)
                .crossAxis(.stretch)

            YogaContainerLayout(contentView)
                .add(icon.ygRelativeLayout.margin(left: 20, right: 15))
                .add(labelContainer.ygRelativeLayout)
                .add(UIView.growView().ygRelativeLayout.height(20))
                .add(button.ygRelativeLayout.margin(left: 10, right: 15).width(buttonSize.width).height(buttonSize.height))
                .row()
                .mainAxis(.spaceBetween)
                .crossAxis(.center)
                .crossAxisChild(labelContainer, align: .stretch)
                .shrinkChild(labelContainer)
            
            // if use `setNeedLayout`, place below `-applyLayout` in `-layoutSubviews`
            contentView.yoga.applyLayout(preservingOrigin: true)
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = bounds.update(top: 5, left: 15, bottom: 5, right: 15)
            // if use `setNeedLayout` in updateYoga, remove `updateYoga` below, use `applyLayout` directly
            updateYoga()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    final private class UseButton: UIButton {
        override var isSelected: Bool {
            didSet {
                if isSelected {
                    layer.borderColor = UIColor(hex: 0xA0D79E).cgColor
                } else {
                    layer.borderColor = UIColor(hex: 0xCCCCCC).cgColor
                }
            }
        }
    }

    final private class FooterView: YogaView {
        let label = UILabel(frame: .zero)
        let imageView = UIImageView(image: UIImage(named: "tips"))

        override func initialize() {
            label.numberOfLines = 0
            label.textColor = UIColor(hex: 0x999999)
            label.text = "更多音效即将上线更多音效即将上线更多"
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.font = UIFont.systemFont(ofSize: 12)
            self.ygContainerLayout
                .add(imageView.ygRelativeLayout)
                .add(label.ygRelativeLayout.margin(left: 10))
                .row()
                .mainAxis(.center)
                .crossAxis(.center)
        }
    }
}
