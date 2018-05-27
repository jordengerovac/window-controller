//
//  ViewController.swift
//  WindowOpener
//
//  Created by Jorden Gerovac on 2018-05-26.
//  Copyright © 2018 Jorden Gerovac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var schedButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humLabel: UILabel!
    
    func buttonFormat(){
        // Button formatting for open window button
        openButton.layer.cornerRadius = 10
        openButton.layer.borderWidth = 2
        openButton.layer.borderColor = UIColor.black.cgColor
        
        // Button formatting for close window button
        closeButton.layer.cornerRadius = 10
        closeButton.layer.borderWidth = 2
        closeButton.layer.borderColor = UIColor.black.cgColor
        
        // Button formatting for set schedule button
        schedButton.layer.cornerRadius = 10
        schedButton.layer.borderWidth = 2
        schedButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttonFormat()
        getHum()
        getTemp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Operations for set schedule button
    @IBAction func setSchedule(_ sender: UIButton) {
        showInputDialog()
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Set temperature schedule", message: "Enter your temperature range", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            if self.isStringAnInt(string: (alertController.textFields?[0].text)!) && self.isStringAnInt(string: (alertController.textFields?[1].text)!){
                let high: Int = Int((alertController.textFields?[0].text)!)!
                let low: Int = Int((alertController.textFields?[1].text)!)!
                //self.labelMessage.text = "High: \(high) Low: \(low)"
            }
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "High"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Low"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Checks if String is an integer value
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    // Read temperature from server
    func getTemp() {
        if let url1 = URL(string: "https://awtcapi2018.azurewebsites.net/api/Tempature"){
            do {
                var currentTemp: String = try String(contentsOf: url1)
                currentTemp = currentTemp.replacingOccurrences(of: "\"", with:"")
                tempLabel.text = "Current Temperature: \(currentTemp)ºC"
            } catch {
                print("contents could not be loaded")
            }
        }
        else {
            print("bad url")
        }
    }
    
    // Read humidity from server
    func getHum() {
        if let url2 = URL(string: "https://awtcapi2018.azurewebsites.net/api/Humidity"){
            do {
                var currentHum: String = try String(contentsOf: url2)
                currentHum = currentHum.replacingOccurrences(of: "\"", with:"")
                humLabel.text = "Current Humidity: \(currentHum)%"
            } catch {
                print("contents could not be loaded")
            }
        }
        else {
            print("bad url")
        }
    }
    
    @IBAction func openAction(_ sender: Any) {
        print("openning window")
        let urlOpen = URL(string: "https://awtcapi2018.azurewebsites.net/api/Manual/Open")
        
        let task = URLSession.shared.dataTask(with: urlOpen!) {(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        
        task.resume()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        print("closing window")
        let urlClose = URL(string: "https://awtcapi2018.azurewebsites.net/api/Manual/Close")
        
        let task = URLSession.shared.dataTask(with: urlClose!) {(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        
        task.resume()
    }
    
}

