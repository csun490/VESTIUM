
//  WebViewController.swift
//  SlideInTransition
//
//  Created by Cesar Barrera on 4/3/21.
//  Copyright © 2021 CSUN-Vestium. All rights reserved.
//

import UIKit
import WebKit
 
class WebViewController: UIViewController,WKNavigationDelegate,UISearchBarDelegate {
    
    var search = FindViewController.searchword
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(search)
       
        var trimmed = search.replacingOccurrences(of: " ", with: "")
        print(trimmed)
        
        let url  = URL(string: "https://www.amazon.com/s?k=" + trimmed + "&ref=nb_sb_noss_2")!
        let request = URLRequest(url: url)
        
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
 
