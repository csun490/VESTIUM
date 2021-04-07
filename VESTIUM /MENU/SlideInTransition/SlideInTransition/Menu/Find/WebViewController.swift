//
//  WebViewController.swift
//  SlideInTransition
//
//  Created by Cesar Barrera on 4/3/21.
//  Copyright © 2021 CSUN-Vestium. All rights reserved.
//

import UIKit
import WebKit
 
class WebViewController: UIViewController,WKNavigationDelegate,UISearchBarDelegate {
    
     var search = " "
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url  = URL(string: "https://www.google.com/search?q=SKECHERS&sxsrf=ALeKk01XrqAx8Q7Qwv1MBZ5EDwNTZkVsMA%3A1617794119321&source=hp&ei=R5RtYLTBEMLh-gTwhKTgDQ&iflsig=AINFCbYAAAAAYG2iV12hQegvQaUY6acmqLYftakdceRP&oq=&gs_lcp=Cgdnd3Mtd2l6EAEYADIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJzIHCCMQ6gIQJ1AAWABg54oBaAFwAHgAgAEAiAEAkgEAmAEAqgEHZ3dzLXdperABCg&sclient=gws-wiz")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.addSubview(ActInd)
                ActInd.startAnimating()
                
                webView.navigationDelegate = self
                ActInd.hidesWhenStopped = true
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        if webView.canGoBack {
            
            webView.goBack()
            
        }
        
    }
    
    @IBAction func forward(_ sender: Any) {
        
        if webView.canGoForward {
            
            webView.goForward()
            
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        webView.reload()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        
        webView.stopLoading()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            
            ActInd.startAnimating()
            
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            ActInd.stopAnimating()
            
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            
            ActInd.stopAnimating()
            
        }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          
          searchBar.resignFirstResponder()
          
          let url  = URL(string: "http://www.\(searchBar.text!)")
          let request = URLRequest(url: url!)
          
          webView.load(request)
          
      }
    
}
 
