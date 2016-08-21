//
//  QiitaAuthorizeViewController.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import UIKit
import WebKit
import MisterFusion

public final class QiitaAuthorizeViewController: UIViewController {
    private let webView: WKWebView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    private let navigationView: UIView = UIView(frame: .zero)
    
    var didFinishClose: (() -> ())?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationView()
        setupWebView()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }

    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let info = QiitaApplicationInfo.sharedInfo
        guard let request = NSMutableURLRequest(method: .Get(.QauthAuthorize(clientId: info.clientId, scope: info.scope, state: nil))) else {
            return
        }
        webView.loadRequest(request)
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func didTapCloseButton(sender: UIButton) {
        close()
    }
    
    private func close() {
        dismissViewControllerAnimated(true) { [weak self] in
            self?.didFinishClose?()
        }
    }
}

extension QiitaAuthorizeViewController {
    private func setupNavigationView() {
        view.addLayoutSubview(navigationView, andConstraints:
            navigationView.Top,
            navigationView.Right,
            navigationView.Left,
            navigationView.Height |==| 64
        )
        
        navigationView.backgroundColor = UIColor(red: 89.0 / 255.0, green: 187.0 / 255.0, blue: 12.0 / 255.0, alpha: 1)
        
        let closeButton = UIButton(type: .System)
        closeButton.addTarget(self, action: #selector(QiitaAuthorizeViewController.didTapCloseButton(_:)), forControlEvents: .TouchUpInside)
        closeButton.setTitle("✕", forState: .Normal)
        closeButton.setTitleColor(.whiteColor(), forState: .Normal)
        closeButton.setTitleColor(.grayColor(), forState: .Highlighted)
        closeButton.titleLabel?.font = UIFont.systemFontOfSize(22)
        navigationView.addLayoutSubview(closeButton, andConstraints:
            closeButton.Left,
            closeButton.Bottom,
            closeButton.Width |==| 44,
            closeButton.Height |==| 44
        )
    }
    
    private func setupWebView() {
        view.addLayoutSubview(webView, andConstraints:
            webView.Top |==| navigationView.Bottom,
            webView.Right,
            webView.Left,
            webView.Bottom
        )
        webView.navigationDelegate = self
    }
}

extension QiitaAuthorizeViewController: WKNavigationDelegate {
    public func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        guard let URL = navigationAction.request.URL else {
            decisionHandler(.Cancel)
            return
        }
        if URL.absoluteString.hasPrefix(QiitaApplicationInfo.sharedInfo.redirectURL) {
            guard
                let URLComponents = NSURLComponents(string: URL.absoluteString),
                let items = URLComponents.queryItems,
                let codeItem = items.filter({ $0.name == "code"}).first,
                let code = codeItem.value
            else {
                fatalError("can not find \"code\" from URL query")
            }
            QiitaApplicationInfo.sharedInfo.code = code
            decisionHandler(.Cancel)
            close()
            return
        }
        decisionHandler(.Allow)
    }
}