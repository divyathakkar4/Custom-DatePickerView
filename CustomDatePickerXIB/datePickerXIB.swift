//
//  datePickerXIB.swift
//  CustomDatePickerXIB
//
//  Created by Admin on 11/04/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class datePickerXIB: UIView,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet var datePickerView: UIView!
    @IBOutlet weak var datePickerCustom: UIDatePicker!
    @IBOutlet weak var pickerBGColor: UIPickerView!
    @IBOutlet weak var pickerTextColor: UIPickerView!
    @IBOutlet weak var pickerLocaleFormatter: UIPickerView!
    
    @IBOutlet weak var lblBackgroundColor: UILabel!
    @IBOutlet weak var lblSelectedColor: UILabel!
    @IBOutlet weak var lblDateView: UILabel!
    @IBOutlet weak var txtDateFormat: UITextField!
    @IBOutlet weak var lblDateFormat: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    
    // Arrays to Show Data on PickerView
    var pickerColorCode: [UIColor] = [UIColor]()
    var pickerColorName : [String] = [String]()
    var pickerLocale : [String] = [String]()
    var pickerLocaleIdentifier : [Locale] = [Locale]()
    
    // Value Selected From PickerView
    var bgColor : UIColor? = nil
    var textColor : UIColor? = nil
    var localeFormat : Locale? = nil
    
    var dateFormatter = DateFormatter()
    
    // For using Custom View in Code
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.superview?.endEditing(true);
        commonInit()
        
        pickerBGColor.delegate = self
        pickerBGColor.dataSource = self
        pickerTextColor.delegate = self
        pickerTextColor.dataSource = self
        pickerLocaleFormatter.delegate = self
        pickerLocaleFormatter.dataSource = self
        txtDateFormat.delegate = self

    }

    
    private func commonInit()
    {
        Bundle.main.loadNibNamed("datePIckerXIB", owner: self, options: nil)
        addSubview(datePickerView)
        
        datePickerView.frame = self.bounds
        datePickerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        datePickerCustom.isHidden = true
        datePickerCustom.reloadInputViews()
        self.btnReset.isHidden = true
        self.txtDateFormat.isHidden = true
        self.lblDateView.isHidden = true
        
        pickerColorCode = [UIColor.white,UIColor.black,UIColor.red,UIColor.blue,UIColor.green,UIColor.yellow,UIColor.cyan,UIColor.darkGray,UIColor.orange,UIColor.brown,UIColor.clear,UIColor.magenta,UIColor.purple]
        pickerColorName = ["White","Black","Red","Blue","Green","Yellow","Cyan","Dark Gray","Orange","Brown","Clear","Magenta","Purple"]
        pickerLocale = ["Default","English (Botswana)","English (American Samoa)","English (Singapore)","English (Australia)","English (India)","English - New Zealand"]
        pickerLocaleIdentifier = [NSLocale(localeIdentifier: "en") as Locale,NSLocale(localeIdentifier: "en_BW") as Locale,NSLocale(localeIdentifier: "en_AS") as Locale,NSLocale(localeIdentifier: "en_SG") as Locale,NSLocale(localeIdentifier: "en_AU") as Locale,NSLocale(localeIdentifier: "en_IN") as Locale,NSLocale(localeIdentifier: "en-NZ") as Locale]
        lblDateView.text = dateFormatter.string(from: datePickerCustom.date)
        
        
    }
    
    //MARK : Pickerview Delegate Method..
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2
        {
            return pickerLocaleIdentifier.count
        }
        else{
            return pickerColorCode.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textAlignment = .center
        label.font.withSize(16.0)
        if pickerView.tag == 2
        {
            label.text = pickerLocale[row]
        }
        else
        {
            label.text = pickerColorName[row]
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(component)
        if pickerView.tag == 0
        {
            bgColor = pickerColorCode[row]
        }else if pickerView.tag == 1{
            textColor = pickerColorCode[row]
        }else if pickerView.tag == 2{
            localeFormat = pickerLocaleIdentifier[row]
        }
        pickerView.reloadAllComponents()
        
    }
    
    // MARK : TextField Delegate Method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateFormatter.dateFormat = textField.text  //"dd-MM-YYYY"
        let strDate = dateFormatter.string(from: datePickerCustom.date)
        lblDateView.text = strDate
        return true
    }
    
    // button action to reset backgroundColor,textColor and Locale for DatePicker
    
    @IBAction func btnResetColor(_ sender: UIButton) {
        self.pickerBGColor.isHidden = false
        self.lblSelectedColor.isHidden = false
        self.lblBackgroundColor.isHidden = false
        self.pickerTextColor.isHidden = false
        self.pickerLocaleFormatter.isHidden = false
        self.lblDateFormat.isHidden = false
        datePickerCustom.isHidden = true
        self.txtDateFormat.isHidden = true
        self.lblDateView.isHidden = true
        pickerBGColor.delegate = self
        pickerBGColor.dataSource = self
        pickerTextColor.delegate = self
        pickerTextColor.dataSource = self
        pickerLocaleFormatter.delegate = self
        pickerLocaleFormatter.dataSource = self
    }
    
    // action to show DatePicker of date and time format with custom colors
    
    @IBAction func btnDefaultdatePicker(_ sender: UIButton) {
        self.pickerBGColor.isHidden = true
        self.lblSelectedColor.isHidden = true
        self.lblBackgroundColor.isHidden = true
        self.pickerTextColor.isHidden = true
        self.pickerLocaleFormatter.isHidden = true
        self.lblDateFormat.isHidden = true
        self.btnReset.isHidden = false
        self.txtDateFormat.isHidden = false
        self.lblDateView.isHidden = false
        datePickerCustom.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerCustom.isHidden = false
        datePickerCustom.reloadInputViews()
        datePickerCustom.locale = localeFormat
        datePickerCustom.backgroundColor = bgColor
        datePickerCustom.setValue(textColor, forKeyPath: "textColor")
    }
    // action to show DatePicker of date format with custom colors
    
    @IBAction func datePickerSelcted(_ sender: Any) {
        self.pickerBGColor.isHidden = true
        self.lblSelectedColor.isHidden = true
        self.lblBackgroundColor.isHidden = true
        self.pickerTextColor.isHidden = true
        self.pickerLocaleFormatter.isHidden = true
        self.lblDateFormat.isHidden = true
        self.btnReset.isHidden = false
        self.txtDateFormat.isHidden = false
        self.lblDateView.isHidden = false
        datePickerCustom.datePickerMode = UIDatePickerMode.date
        datePickerCustom.isHidden = false
        datePickerCustom.reloadInputViews()
        datePickerCustom.locale = localeFormat
        datePickerCustom.backgroundColor = bgColor
        datePickerCustom.setValue(textColor, forKeyPath: "textColor")
    }
    
    // action to show DatePicker of time format with custom colors
    
    @IBAction func timePickerSelected(_ sender: Any) {
        self.pickerBGColor.isHidden = true
        self.lblSelectedColor.isHidden = true
        self.lblBackgroundColor.isHidden = true
        self.pickerTextColor.isHidden = true
        self.pickerLocaleFormatter.isHidden = true
        self.lblDateFormat.isHidden = true
        self.btnReset.isHidden = false
        self.txtDateFormat.isHidden = false
        self.lblDateView.isHidden = false
        datePickerCustom.reloadInputViews()
        datePickerCustom.locale = localeFormat
        datePickerCustom.datePickerMode = UIDatePickerMode.time
        datePickerCustom.isHidden = false
        datePickerCustom.backgroundColor = bgColor
        datePickerCustom.setValue(textColor, forKeyPath: "textColor")
    }
    
    // Show date of given Format while Value Changed from DatePicker
    
    @IBAction func pickerValueChanged(_ sender: Any) {
        dateFormatter.dateFormat = txtDateFormat.text  //"dd-MM-YYYY"
        let strDate = dateFormatter.string(from: datePickerCustom.date)
        lblDateView.text = strDate
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
