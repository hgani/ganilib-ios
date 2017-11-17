import UIKit
import WebKit

open class GWebView: WKWebView {
    private var helper: ViewHelper!
    private var requestUrl: URL?

    lazy fileprivate var refresher: GRefreshControl = {
        return GRefreshControl().onValueChanged { [unowned self] in
            self.refresh()
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
        self.requestUrl = url
        
        GLog.i("Loading \(url) ...")
        self.refresher.show()
        load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30))
        return self
    }
    
    public func load(url: String) -> Self {
        return load(url: URL(string: url)!)
    }
    
    public func refresh() {
        // It seems that reload() doesn't do anything when the initial load() failed.
        if let url = self.requestUrl {
            _ = self.load(url: url)
        }
    }
    
    public func end() {
        // Ends chaining
    }
}

extension GWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.refresher.hide()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handle(error: error)
    }
    
    // E.g. SSL error
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handle(error: error)
    }
    
    private func handle(error: Error) {
        self.refresher.hide()
        
        let alert = UIAlertController(title: nil,
                                      message: error.localizedDescription,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [unowned self] (result) -> Void in
            self.refresh()
        })
        
        GApp.instance.navigationController.present(alert, animated: true, completion: nil)
    }
}

