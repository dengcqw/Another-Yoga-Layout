//
//  YogaValueConvertable.swift
//  TVGuor
//
//  Created by Steven on 2018/10/30.
//  Copyright © 2018 xiaoguo. All rights reserved.
//

import YogaKit

public protocol YogaValueConvertable {
    var ygValue: YGValue { get }
    func ygValue(unit: YGUnit) -> YGValue
}

public extension YogaValueConvertable {
    var ygValue: YGValue {
        return ygValue(unit: .point)
    }
}

// MARK: -
extension Int: YogaValueConvertable {
    public func ygValue(unit: YGUnit) -> YGValue {
        return YGValue(value: Float(self), unit: unit)
    }
}

extension Float: YogaValueConvertable {
    public func ygValue(unit: YGUnit) -> YGValue {
        return YGValue(value: Float(self), unit: unit)
    }
}

extension Double: YogaValueConvertable {
    public func ygValue(unit: YGUnit) -> YGValue {
        return YGValue(value: Float(self), unit: unit)
    }
}

extension CGFloat: YogaValueConvertable {
    public func ygValue(unit: YGUnit) -> YGValue {
        return YGValue(value: Float(self), unit: unit)
    }
}

