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

open class YogaScrollViewControler: UIViewController {
    public let scrollView = UIScrollView()
    public let contentView = UIView()

    // insert empty grow view in where you want to expand, then show all views in one screen
    // and avoid big empty on the bottom screen
    public let emptyGrowView = UIView.growView()

    public func updateYGLayout(on contentView: UIView) {
        assertionFailure("updateLayout need override")
    }

    open override func loadView() {
        super.loadView()
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    open override func viewWillLayoutSubviews() {
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
