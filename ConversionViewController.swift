//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Ceasar Barbosa on 2/8/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
        
    }
    
    
    // Silver Challenge Dark Mode based on time of day
    override func viewWillAppear(animated: Bool) {
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        
        if hour < 18 || hour > 6 {
            view.backgroundColor = UIColor.lightGrayColor()
            let placeholder = NSAttributedString(string: "value", attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
            textField.attributedPlaceholder = placeholder
        
        } else {
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 100/255.0, alpha: 1)
            isReallyLabel.textColor = UIColor.whiteColor()
            let placeholder = NSAttributedString(string: "value", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
            textField.attributedPlaceholder = placeholder
        }
    }
    
    
    // Outlets for Celsius Labe and text field
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var isReallyLabel: UILabel!
    
    
    // number formatting closure that displays no more than one fractional digit
    let numberFormatter: NSNumberFormatter =
    {
        let currentLocale = NSLocale.currentLocale()
        let isMetric = currentLocale.objectForKey(NSLocaleUsesMetricSystem)?.boolValue
        let currencySymbol = currentLocale.objectForKey(NSLocaleCurrencySymbol)
        
        let numFormatter = NSNumberFormatter()
            numFormatter.numberStyle = .DecimalStyle
            numFormatter.minimumFractionDigits = 0
            numFormatter.maximumFractionDigits = 1
            return numFormatter
        
    }()
    
    
    // property observer: chunk of code that gets called whenever a property changes
    var fahrenheitValue: Double?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    // determing celsius value
    var celsiusValue: Double?
    {
        if let value = fahrenheitValue
        {
            return (value - 32) * (5/9)
        }
        else
        {
            return nil
        }
        
    }
    
    
    
    // func that dectects if text field has text AND if its a double assign that value to fahrenheitValue var
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField)
    {
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        } else {
            fahrenheitValue = nil
        }
    }
    
    
    // function that updates the celsius label as text is entered in text field
    func updateCelsiusLabel()
    {
        if let value = celsiusValue
        {
            //celsiusLabel.text = "\(value)"
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else
        {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        // Bronze Challenge
        //let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
        
        
         if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil{
            return false
        } else {
            return true
        }
    }
    
    // Uses tap gesture recognizer to dismiss keyboard
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    

}





