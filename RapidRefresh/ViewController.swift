//
//  ViewController.swift
//  RapidRefresh
//
//  Created by Mitchell Sweet on 12/6/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var rateControl:UISegmentedControl!
    @IBOutlet var customRate:UITextField!
    @IBOutlet var webpage:UITextField!
    @IBOutlet var setButton:UIButton!
    @IBOutlet var statusLabel:UILabel!
    @IBOutlet var goButton:UIButton!
    
    var refreshRate = 0
    var targetWebpage = "..."
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewSetup()
        
    }
    
    func viewSetup() {
        
        if let bar = navigationController?.navigationBar {
            self.title = "Rapid Refresh"
            bar.barTintColor = #colorLiteral(red: 0.9565907121, green: 0.5978777409, blue: 0.1917127073, alpha: 1)
            bar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
        }
        
    }
    
    @IBAction func presetRefresh(sender:UISegmentedControl) {
        
        var output = 0;
        
        switch sender.selectedSegmentIndex {
        case 0:
            output = 3
        case 1:
            output = 5
        case 2:
            output = 10
        case 3:
            output = 30
        case 4:
            output = 60
        case 5:
            output = 300
        default:
            output = 60
            print("Error: bad value from UISegmentedControl")
        }
        
        setRefreshRate(rate: output)
    }
    
    @IBAction func customRefresh(sender:AnyObject) {
        
        if let input = Int(customRate.text!) {
            if (input >= 0) && (input < 1800) {
                let alert = UIAlertController(title: "Please enter a valid rate", message: "Enter a rate between 0 and 1,800 seconds.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
            }
            else {
                setRefreshRate(rate: input)
                customRate.resignFirstResponder()
            }
        }
        
    }
    
    @IBAction func setWebpage(sender:UITextField) {
        if let link = sender.text {
            targetWebpage = link
            setStatus()
        }
    }
    
    func setRefreshRate(rate: Int) {
        refreshRate = rate
        setStatus()
    }
    
    func setStatus() {
        var rateInsert = "..."
        if refreshRate != 0 {
            rateInsert = "\(refreshRate)"
        }
        
        statusLabel.text = "You will be refreshing \(targetWebpage) every \(rateInsert) seconds."
        
    }
    
    @IBAction func go(sender:AnyObject) {
        
        if (refreshRate != 0) && (targetWebpage != "...") {
            self.performSegue(withIdentifier: "toWeb", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Cannot Continue", message: "Please fill in all fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! WebViewController
        destinationVC.link = targetWebpage
        destinationVC.rate = refreshRate
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

