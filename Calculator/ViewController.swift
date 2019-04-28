//
//  ViewController.swift
//  Calculator
//
//  Created by Luke  on 4/26/19.
//  MIT license
//

import UIKit

class ViewController: UIViewController {
    
    //Create varaibles to hold the expression and answer
    var expressionString = "";
    var expn = NSExpression();
    var answer: NSNumber? = nil;
    

    @IBOutlet weak var labelCurrent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func operatorPressed(_ sender: UIButton){
        //if this is a new operation, clear the expression string
        if(answer != nil){
            clearExpressionString();
        }
        
       addCurrentToExpression()
        
        //if the user entered nothing return
        if(expressionString == ""){
            return;
        }
        
        //add operator based on what button they pressed
        if(sender.tag == 0){
            expressionString += "+";
        } else if (sender.tag == 1){
            expressionString += "-";
        } else if (sender.tag == 2){
            expressionString += "*";
        } else if (sender.tag == 3) {
            expressionString += "/";
        }
        
        clearCurrent();
        
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        //clear eveyrthing
        clearCurrent();
        clearExpressionString();
        answer = nil;
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        //if this is a new operation, clear the label
        if(answer != nil){
            clearCurrent();
        }
        //unwrap the label and add the number or decimal to it
        if let unwrapped = labelCurrent.text{
            if(sender.tag == 10){
                labelCurrent.text = unwrapped + ".";
            } else {
                labelCurrent.text = unwrapped + String(sender.tag);
            }
        }
        
    }
    
    
    @IBAction func evalPressed(_ sender: Any) {
        //if the expression is nothing or just a decimal return
        if(expressionString == "" || Array(expressionString)[0] == "."){
            clearExpressionString();
            return;
        }
        
        //add newest number to expression
        addCurrentToExpression();
        
        //create a new expression with the new expression string
        expn = NSExpression(format: expressionString);

        //evaluate the expression
       guard let result = expn.expressionValue(with: nil, context: nil) as? Double else
       {return}
        
        //create a formatter to turn the result to a string
        let formatter = NumberFormatter();
        formatter.minimumFractionDigits = 0;
        formatter.minimumFractionDigits = 2;
        
        //create a string version fo the result to display
        guard let value = formatter.string(from: NSNumber(value: result)) else {return};
        
        //set answer to the result of the expression
        answer = NSNumber(value: result);
        
        //show the user the result
        labelCurrent.text = value;
    }

    @IBAction func negativePressed(_ sender: UIButton) {
        //unwrap the label and check if it has a -
        if let unwrapped = labelCurrent.text{
            if(Array(unwrapped)[0] == "-"){
                //if it does replace it with nothing
                labelCurrent.text = unwrapped.replacingOccurrences(of: "-", with: "");
            } else {
                //if it doesn't, add one
            labelCurrent.text = "-" + unwrapped;
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        //unwrap the label and set it to itself without the last character
        if let unwrapped = labelCurrent.text{
            labelCurrent.text = String(unwrapped.dropLast());
        }
    }
    
    
    func addCurrentToExpression(){
        //unwrap the label and add it to the expression string
        if let unwrapped = labelCurrent.text{
            expressionString += unwrapped;
        }
    }
    
    func clearCurrent(){
        //set the label to an empty string
        labelCurrent.text = "";
    }
    
    func clearExpressionString(){
        //clear the expression string so it can start a new expression later
        expressionString = "";
    }
}
