// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Created by Deng Jinlong on 2019-01-19.

import YogaKit

public extension UIView {
    var ygContainerLayout: YogaContainerLayout {
        return YogaContainerLayout(self)
    }
    var ygRelativeLayout: YogaRelativeLayout {
        return YogaRelativeLayout(self)
    }
    var ygWrapLayout: YogaWrapLayout {
        return YogaWrapLayout(self)
    }
    var ygAbsoluteLayout: YogaAbsoluteLayout {
        return YogaAbsoluteLayout(self)
    }
    fileprivate var ygIndex: Int? {
        return superview?.subviews.firstIndex(of: self)
    }
}

private extension YGValue {
    init(_ value: CGFloat?) {
        if let value = value {
            self = YGValue(value: Float(value), unit: .point)
        } else {
            self = YGValueUndefined
        }
    }
}

fileprivate func yg_assert(condition: Bool, message: String) {
    #if DEBUG
    assert(condition, message)
    #endif
}

// https://yogalayout.com/docs
public class YogaLayoutBase {
    fileprivate let view: UIView!
    public init(_ view: UIView) {
        if let label = view as? UILabel {
            self.view = YogaLabelContainer(label)
        } else {
            self.view = view
        }
        self.view.yoga.markDirty()
        self.view.yoga.isEnabled = true
    }

    public func build() -> UIView {
        return view
    }

    /*  https://yogalayout.com/docs/aspect-ratio
     1. Defined as the ratio between the width and the height of a node
     e.g. if a node has an aspect ratio of 2 then its width is twice the size of its height.
     2. Respects the min and max dimensions of an item.
     3. Has higher priority than flex grow
     4. If aspect ratio, width, and height are set then the cross axis dimension is overridden.
     */
    @discardableResult
    public func aspectRatio(_ ratio: CGFloat) -> Self {
        view.yoga.aspectRatio = ratio
        return self
    }

    public func applyLayout(animated: Bool = false) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self._applyLayout()
            }
        } else {
            self._applyLayout()
        }
    }

    fileprivate func _applyLayout() {
    }
}

public class YogaRelativeLayout: YogaLayoutBase {
    @discardableResult
    public func width(_ width: CGFloat) -> Self {
        view.yoga.width = YGValue(width)
        return self
    }
    
    @discardableResult
    public func width(min: CGFloat? = nil, max: CGFloat? = nil) -> Self {
        view.yoga.minWidth = YGValue(min)
        view.yoga.maxWidth = YGValue(max)
        return self
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> Self {
        view.yoga.height = YGValue(height)
        return self
    }
    
    @discardableResult
    public func height(_ height: CGFloat, min: CGFloat? = nil, max: CGFloat? = nil) -> Self {
        view.yoga.minHeight = YGValue(min)
        view.yoga.maxHeight = YGValue(max)
        return self
    }
    
    @discardableResult
    public func margin(top: CGFloat? = nil, left: CGFloat? = nil , bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        view.yoga.marginTop = YGValue(top)
        view.yoga.marginLeft = YGValue(left)
        view.yoga.marginBottom = YGValue(bottom)
        view.yoga.marginRight = YGValue(right)
        return self
    }
    
    @discardableResult
    public func margin(horizontal: CGFloat? = nil, vertical: CGFloat? = nil) -> Self {
        view.yoga.marginHorizontal = YGValue(horizontal)
        view.yoga.marginVertical = YGValue(vertical)
        return self
    }
    
    @discardableResult
    public func margin(_ edge: UIEdgeInsets) -> Self {
        margin(top: edge.top, left: edge.left, bottom: edge.bottom, right: edge.right)
        return self
    }
    
    @discardableResult
    public func margin(_ value: CGFloat) -> Self {
        view.yoga.margin = YGValue(value)
        return self
    }
    
    @discardableResult
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil , bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        view.yoga.paddingTop = YGValue(top)
        view.yoga.paddingLeft = YGValue(left)
        view.yoga.paddingBottom = YGValue(bottom)
        view.yoga.paddingRight = YGValue(right)
        return self
    }
    
    @discardableResult
    public func padding(horizontal: CGFloat? = nil, vertical: CGFloat? = nil) -> Self {
        view.yoga.paddingHorizontal = YGValue(horizontal)
        view.yoga.paddingVertical = YGValue(vertical)
        return self
    }
    
    @discardableResult
    public func padding(_ value: CGFloat) -> Self {
        view.yoga.padding = YGValue(value)
        return self
    }

    override func _applyLayout() {
        view.superview?.yoga.applyLayout(preservingOrigin: true)
    }
}

public class YogaAbsoluteLayout: YogaLayoutBase {
    @discardableResult
    public func position(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        view.yoga.position = .absolute
        view.yoga.top = YGValue(top)
        view.yoga.left = YGValue(left)
        view.yoga.bottom = YGValue(bottom)
        view.yoga.right = YGValue(right)
        return self
    }

    @discardableResult
    public func size(w: CGFloat? = nil, h: CGFloat? = nil) -> Self {
        view.yoga.width = YGValue(w)
        view.yoga.height = YGValue(h)
        return self
    }

    override func _applyLayout() {
        view.superview?.yoga.applyLayout(preservingOrigin: true)
    }
}

public class YogaContainerLayout: YogaLayoutBase {
    public override init(_ view: UIView) {
        super.init(view)
        container.subviews.forEach{ $0.removeFromSuperview() }
    }

    fileprivate var subviews: [UIView] {
        return container.subviews
    }

    fileprivate var container: UIView {
        return view
    }

    @discardableResult
    public func add(_ builder: YogaLayoutBase) -> Self {
        let subview = builder.build()
        view.addSubview(subview)
        return self
    }
    
    @discardableResult
    public func add(_ builders: [YogaLayoutBase]) -> Self {
        builders.forEach { self.add($0) }
        return self
    }
    
    override func _applyLayout() {
        container.yoga.applyLayout(preservingOrigin: true)
    }
}

extension YogaContainerLayout {
    @discardableResult
    public func row() -> Self {
        container.yoga.flexDirection = .row
        container.yoga.justifyContent = .flexStart
        container.yoga.alignItems = .center
        return self
    }
    
    @discardableResult
    public func column() -> Self {
        container.yoga.flexDirection = .column
        container.yoga.justifyContent = .flexStart
        container.yoga.alignItems = .center
        return self
    }
    
    @discardableResult
    public func mainAxis(_ justify: YGJustify) -> Self {
        container.yoga.justifyContent = justify
        return self
    }
    
    @discardableResult
    public func crossAxis(_ align: YGAlign) -> Self {
        container.yoga.alignItems = align
        return self
    }
    
    @discardableResult
    public func crossAxisChild(at index: Int, align: YGAlign) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        if index < subviews.count {
            subviews[index].yoga.alignSelf = align
        }
        return self
    }
    
    @discardableResult
    public func growChild(at index: Int, score: CGFloat = 1) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        if index < subviews.count {
            subviews[index].yoga.flexGrow = score
        }
        return self
    }
    
    @discardableResult
    public func growChild(_ child: UIView, score: CGFloat = 1) -> Self {
        return growChild(at: child.ygIndex ?? Int.max, score: score)
    }
    
    @discardableResult
    public func growChildren(scores: [CGFloat] = []) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        if scores.count == 0 {
            subviews.forEach { $0.yoga.flexGrow = 1 }
            return self
        }
        guard scores.count == subviews.count else {
            return self
        }
        for index in 0..<subviews.count {
            let score = scores[index]
            growChild(at: index, score: score)
        }
        return self
    }
    
    @discardableResult
    public func shrinkChild(at index: Int, score: CGFloat = 1) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        if index < subviews.count {
            subviews[index].yoga.flexShrink = score
        }
        return self
    }
    
    @discardableResult
    public func shrinkChild(_ child: UIView, score: CGFloat = 1) -> Self {
        shrinkChild(at: child.ygIndex ?? Int.max, score: score)
        return self
    }
    
    @discardableResult
    public func shrinkChildren(scores: [CGFloat] = []) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        if scores.count == 0 {
            subviews.forEach { $0.yoga.flexShrink = 1 }
            return self
        }
        guard scores.count == subviews.count else {
            return self
        }
        for index in 0..<subviews.count {
            let score = scores[index]
            growChild(at: index, score: score)
        }
        return self
    }
    
    @discardableResult
    public func setChildBasis(at index: Int, value: CGFloat) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        if index < subviews.count {
            subviews[index].yoga.flexBasis = YGValue(value)
        }
        return self
    }
    
    @discardableResult
    public func setChildrenBasis(value: CGFloat) -> Self {
        yg_assert(condition: subviews.count > 0, message: "no subviews")
        subviews.forEach { $0.yoga.flexBasis = YGValue(value) }
        return self
    }
    
    @discardableResult
    public func overflow(_ overflow: YGOverflow) -> Self {
        container.yoga.overflow = overflow
        return self
    }
}

public class YogaWrapLayout: YogaContainerLayout {
    override init(_ view: UIView) {
        super.init(view)
        container.yoga.flexWrap = .wrap
    }
    
    public func justityContent(_ justify: YGJustify) -> Self {
        container.yoga.justifyContent = justify
        return self
    }
}


