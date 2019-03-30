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

