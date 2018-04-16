//
//  ViewController.swift
//  CustomDatePickerXIB
//
//  Created by Admin on 11/04/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerXIBView: datePickerXIB!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerXIBView.bgColor = .red;
        pickerXIBView.textColor = .blue
        pickerXIBView.localeFormat = NSLocale(localeIdentifier: "en") as Locale
        pickerXIBView.dateFormatter.dateFormat = "dd/MM/yyyy"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

