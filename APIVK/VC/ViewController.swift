//
//  ViewController.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import UIKit
import WebKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myWebVIew: WKWebView! {
        didSet{
            myWebVIew.navigationDelegate = self
        }
    }
    
    @IBOutlet weak var barItemBack: UIBarButtonItem!
    
    @IBAction func actionBarItem(_ sender: Any) {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    lazy var service = APIWork()
    var items: [Friends] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlLoad()
    }
    
    func urlLoad() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: "51572389"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "response_type", value: "token"),
        ]
        let request = URLRequest(url: urlComponents.url!)
        myWebVIew.load(request)

        
    }
    
    
}
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else{
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        if let token = params["access_token"] {
            Session.shared.token = token
            service.componentsFrendsGet() { [weak self] items in
                self?.items = items
            }
        }
        else {
            print("No access token")
        }
        print("Token: \(Session.shared.token)")
        
        decisionHandler(.cancel)
    }
}
