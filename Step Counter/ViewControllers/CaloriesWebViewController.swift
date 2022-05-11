//
//  CaloriesWebViewController.swift
//  Step Counter
//  The calories tab. It loads a website for calculating calories using step count.
//
//  Created by Mark Zarak on 2022-03-25.
//

import UIKit
import WebKit

class CaloriesWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webPage : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
    // A method to show the web activity animation
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    // A method to hide the web activity animation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let urlAddress = URL(string: "https://www.omnicalculator.com/sports/steps-to-calories")
        let url = URLRequest(url: urlAddress!)
        webPage?.load(url)
        webPage.navigationDelegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
