//
//  AudioEffectListController+Ext.swift
//  LayoutDemo
//
//  Created by Deng Jinlong on 2019/3/30.
//  Copyright © 2019 tvguo. All rights reserved.
//

import UIKit

let AudioEffectData: [[String: String]] = [[
    "icon": "Player_AudioEffect_3",
    "title": TVGTitle.AudioEffectType3,
    "subtitle": TVGTitle.AudioEffectSubTitle3,
], [
    "icon": "Player_AudioEffect_1",
    "title": TVGTitle.AudioEffectType1,
    "subtitle": "\(TVGTitle.AudioEffectSubTitle1);\(TVGTitle.AudioEffectSubTitle1)",
], [
    "icon": "Player_AudioEffect_2",
    "title": TVGTitle.AudioEffectType2,
    "subtitle": TVGTitle.AudioEffectSubTitle2,
], [
    "icon": "Player_AudioEffect_4",
    "title": TVGTitle.AudioEffectType4,
    "subtitle": TVGTitle.AudioEffectSubTitle4,
], [
    "icon": "Player_AudioEffect_5",
    "title": TVGTitle.AudioEffectType5,
    "subtitle": TVGTitle.AudioEffectSubTitle5,
], [
    "icon": "Player_AudioEffect_6",
    "title": TVGTitle.AudioEffectType6,
    "subtitle": TVGTitle.AudioEffectSubTitle6,
]]

class TVGTitle: NSObject {
    static var AudioEffect: String {
        return NSLocalizedString("音效", comment:"")
    }
    static var AudioEffectType1: String {
        return NSLocalizedString("影院模式", comment:"")
    }
    static var AudioEffectType2: String {
        return NSLocalizedString("清澈人声", comment:"")
    }
    static var AudioEffectType3: String {
        return NSLocalizedString("初始原声", comment:"")
    }
    static var AudioEffectType4: String {
        return NSLocalizedString("空谷回声", comment:"")
    }
    static var AudioEffectType5: String {
        return NSLocalizedString("超级混响", comment:"")
    }
    static var AudioEffectType6: String {
        return NSLocalizedString("超重低音", comment:"")
    }
    static var AudioEffectSubTitle1: String {
        return NSLocalizedString("增强背景，制造大片效果", comment:"")
    }
    static var AudioEffectSubTitle2: String {
        return NSLocalizedString("还原最纯净的人声", comment:"")
    }
    static var AudioEffectSubTitle3: String {
        return NSLocalizedString("使用剧集原声播放", comment:"")
    }
    static var AudioEffectSubTitle4: String {
        return NSLocalizedString("感受远处山谷回响", comment:"")
    }
    static var AudioEffectSubTitle5: String {
        return NSLocalizedString("进入声学空间混响", comment:"")
    }
    static var AudioEffectSubTitle6: String {
        return NSLocalizedString("带来深邃浑厚的低音", comment:"")
    }
}

extension UIColor {
    @objc
    public convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let dividend: CGFloat = 255.0
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / dividend, green: CGFloat((hex & 0xFF00) >> 8) / dividend, blue: CGFloat(hex & 0xFF) / dividend, alpha: alpha)
    }
}

extension CGRect {
    public func update(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> CGRect {
        return CGRect.init(x: origin.x + left, y: origin.y + top, width: size.width - left - right, height: size.height - top - bottom)
    }
    public func update(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
        return CGRect.init(x: x ?? origin.x, y: y ?? origin.y, width: width ?? size.width, height: height ?? size.height)
    }
}
