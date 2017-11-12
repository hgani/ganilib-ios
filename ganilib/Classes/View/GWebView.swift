import UIKit
import WebKit

open class GWebView: WKWebView {
    private var helper : ViewHelper!

    lazy fileprivate var refresher: GRefreshControl = {
        return GRefreshControl().onValueChanged {
            self.reload()
        }
    }()
    
    public init() {
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
        self.navigationDelegate = self
        
        self.scrollView.addSubview(refresher)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func color(bg : UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
        return self
    }
    
    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }
    
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }
    
    public func load(url: URL) -> Self {
        Log.i("Loading \(url) ...")
        self.refresher.show()
        load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30))
        return self
    }
    
    public func load(url: String) -> Self {
        return load(url: URL(string: url)!)
    }
    
    public func end() {
        // Ends chaining
    }
}

extension GWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Log.t("Finished")
        self.refresher.hide()
    }
}

