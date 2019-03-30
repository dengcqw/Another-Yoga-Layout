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
// Created by Deng Jinlong on 2018-01-19.

import YogaKit

// Make UILabel easy to use in Yoga or In row direction label need set shrink property to control length.
// so this class is used for fixed width view or in width grow view
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

    // On the main direction, the value(height or width) is determined by `sizeThatFits`, if value is given, `sizeThatFits` not invoked
    // Eg. Column direction,  if height is given, `sizeThatFits` not invoked
    // else `sizeThatFits` invoked, only height is accepted
    // but impossible to know the direction inside this class, so return 0 width always.
    // Again, remain that YogaLabelContainer 's job is apart UILabel from Yoga layout.
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelSize = label.sizeThatFits(size)
        return CGSize(width: 0, height: min(labelSize.height, size.height))
    }
}

