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
    fileprivate let webView: WKWebView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    fileprivate let navigationView: UIView = UIView(frame: .zero)
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let info = QiitaApplicationInfo.default
        guard let request = URLRequest(method: .get(.qauthAuthorize(clientId: info.clientId, scope: info.scope, state: nil))) else {
            return
        }
        webView.load(request)
    }
    
    public override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    func didTapCloseButton(_ sender: UIButton) {
        close()
    }
    
    fileprivate func close() {
        dismiss(animated: true) { [weak self] in
            self?.didFinishClose?()
        }
    }
}

extension QiitaAuthorizeViewController {
    fileprivate func setupNavigationView() {
        view.addLayoutSubview(navigationView, andConstraints:
            navigationView.top,
            navigationView.right,
            navigationView.left,
            navigationView.height |==| 64
        )
        
        navigationView.backgroundColor = UIColor(red: 89.0 / 255.0, green: 187.0 / 255.0, blue: 12.0 / 255.0, alpha: 1)
        
        let closeButton = UIButton(type: .system)
        closeButton.addTarget(self, action: #selector(QiitaAuthorizeViewController.didTapCloseButton(_:)), for: .touchUpInside)
        closeButton.setTitle("✕", for: UIControlState())
        closeButton.setTitleColor(.white, for: UIControlState())
        closeButton.setTitleColor(.gray, for: .highlighted)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        navigationView.addLayoutSubview(closeButton, andConstraints:
            closeButton.left,
            closeButton.bottom,
            closeButton.width |==| 44,
            closeButton.height |==| 44
        )
    }
    
    fileprivate func setupWebView() {
        view.addLayoutSubview(webView, andConstraints:
            webView.top |==| navigationView.bottom,
            webView.right,
            webView.left,
            webView.bottom
        )
        webView.navigationDelegate = self
    }
}

extension QiitaAuthorizeViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let URL = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        if URL.absoluteString.hasPrefix(QiitaApplicationInfo.default.redirectURL) {
            guard
                let URLComponents = URLComponents(string: URL.absoluteString),
                let items = URLComponents.queryItems,
                let codeItem = items.filter({ $0.name == "code"}).first,
                let code = codeItem.value
            else {
                fatalError("can not find \"code\" from URL query")
            }
            QiitaApplicationInfo.default.code = code
            decisionHandler(.cancel)
            close()
            return
        }
        decisionHandler(.allow)
    }
}
