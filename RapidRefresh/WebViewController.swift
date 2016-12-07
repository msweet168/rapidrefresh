//
//  WebViewController.swift
//  RapidRefresh
//
//  Created by Mitchell Sweet on 12/6/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet var theView:UIWebView!
    @IBOutlet var startButton:UIButton!
    @IBOutlet var manualButton:UIButton!
    @IBOutlet var backButton:UIButton!
    @IBOutlet var forwardButton:UIButton!
    @IBOutlet var loading:UIActivityIndicatorView!
    
    var link = String()
    var rate = Int()
    var autoRefreshing = false
    var refreshTimer = Timer()
    var counterTimer = Timer()
    var refreshCounter = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewSetup()
        webViewSetup()
    }
    
    func viewSetup() {
        if let bar = navigationController?.navigationBar {
            self.title = "Auto-Refresh Off"
            bar.barTintColor = #colorLiteral(red: 0.9565907121, green: 0.5978777409, blue: 0.1917127073, alpha: 1)
            bar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
        }
        
        loading.layer.cornerRadius = 5
    }
    
    func webViewSetup() {
        let request = URLRequest(url: URL(string: link)!)
        theView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
    }
    
    @IBAction func back(sender:AnyObject) {
        theView.goBack()
    }
    
    @IBAction func forward(sender:AnyObject) {
        theView.goForward()
    }
    
    @IBAction func manualRefresh(sender:AnyObject) {
        refresh()
    }
    
    @IBAction func autoRefresh(sender:AnyObject) {
        
        if autoRefreshing {
            print("auto-refresh stopped.")
            autoRefreshing = false
            startButton.setTitle("Start Auto", for: UIControlState.normal)
            manualButton.isEnabled = true
            backButton.isEnabled = true
            forwardButton.isEnabled = true
            navigationItem.hidesBackButton = false
            self.title = "Auto-Refresh Off"
            
            refreshTimer.invalidate()
            counterTimer.invalidate()
            
        }
        else {
            print("auto-refresh started.")
            autoRefreshing = true
            startButton.setTitle("Stop Auto", for: UIControlState.normal)
            manualButton.isEnabled = false
            backButton.isEnabled = false
            forwardButton.isEnabled = false
            navigationItem.hidesBackButton = true
            
            
            refreshCounter = rate+1
            refreshTimer = Timer.scheduledTimer(timeInterval: TimeInterval(rate), target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
            counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(titleSet), userInfo: nil, repeats: true)
            
            
        }
        
    }
    
    func refresh() {
        theView.reload()
        
        if autoRefreshing {
            refreshCounter = rate+1
        }
    }
    
    func titleSet() {
        refreshCounter -= 1
        self.title = "Auto Refreshing: \(refreshCounter)"
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
