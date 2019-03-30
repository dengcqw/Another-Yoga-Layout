//
//  NSAttributedString+Extension.swift
//  TVGuor
//
//  Created by Deng Jinlong on 2/8/18.
//  Copyright © 2018 tvguo. All rights reserved.
//

import UIKit

extension NSAttributedString {

    public static func instance(stringsAndAttributes: [(String, [NSAttributedString.Key: Any])]) -> NSAttributedString {
        let strings = stringsAndAttributes.map { (string, attributes) -> NSAttributedString in
            return NSAttributedString(string: string, attributes: attributes)
        }
        let res = strings.reduce(into: NSMutableAttributedString()) { $0.append($1) }
        return res
    }

    func getRange() -> NSRange {
        return NSRange.init(location: 0, length: self.length)
    }

    public func addColor(_ color: UIColor?, range: NSRange? = nil, for text: String? = nil) -> NSAttributedString {
        var _range = getRange()
        if let text = text {
            _range = NSString(string: self.string).range(of: text)
        } else if let range = range {
            _range = range
        }
        var _color:UIColor = .clear
        if let color = color {
            _color = color
        }
        let attr = NSMutableAttributedString.init(attributedString: self)
        attr.addAttribute(NSAttributedString.Key.foregroundColor, value: _color, range: _range)
        return attr.copy() as! NSAttributedString
    }

//    public func addColor(_ hexStr: String, range: NSRange? = nil, for text: String? = nil) -> NSAttributedString {
//        let color = UIColor.init(hexString: hexStr)
//        return addColor(color, range: range, for: text)
//    }
    public func addColor(_ hex: UInt32, range: NSRange? = nil, for text: String? = nil) -> NSAttributedString {
        let color = UIColor.init(hex: hex)
        return addColor(color, range: range, for: text)
    }

    public func addFont(_ font: UIFont, range: NSRange? = nil) -> NSAttributedString {
        let attr = NSMutableAttributedString.init(attributedString: self)
        attr.addAttribute(NSAttributedString.Key.font, value: font, range: range ?? getRange())
        return attr.copy() as! NSAttributedString
    }
    public func addFont(_ fontSize: CGFloat, range: NSRange? = nil) -> NSAttributedString {
        let attr = NSMutableAttributedString.init(attributedString: self)
        attr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize), range: range ?? getRange())
        return attr.copy() as! NSAttributedString
    }
    public func addParagraphStyle(_ style: NSParagraphStyle, range: NSRange? = nil) -> NSAttributedString {
        let attr = NSMutableAttributedString.init(attributedString: self)
        attr.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range ?? getRange())
        return attr.copy() as! NSAttributedString
    }
    public func addLink(_ urlString: String, range: NSRange? = nil, for text: String? = nil) -> NSAttributedString {
        if let url = URL.init(string: urlString) {
            var _range = range
            if let text = text {
                _range = NSString(string: self.string).range(of: text)
            }

            let attr = NSMutableAttributedString.init(attributedString: self)
            attr.addAttributes([NSAttributedString.Key.link: url], range: _range ?? getRange())
            return attr.copy() as! NSAttributedString
        }
        return self
    }

    public func addAttribute(_ key: NSAttributedString.Key, value: Any, range: NSRange? = nil) -> NSAttributedString {
        let attr = NSMutableAttributedString.init(attributedString: self)
        attr.addAttributes([key: value], range: range ?? getRange())
        return attr.copy() as! NSAttributedString
    }
}

extension String {
    public func attrString(align:NSTextAlignment = .left) -> NSAttributedString {
        let para = NSMutableParagraphStyle.init()
        para.alignment = align
        return NSAttributedString.init(string: self, attributes: [NSAttributedString.Key.paragraphStyle: para])
    }
}

extension NSAttributedString {
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    public func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}



