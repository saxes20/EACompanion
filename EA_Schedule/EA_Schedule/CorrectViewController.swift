//
//  CorrectViewController.swift
//  EACompanion
//
//  Created by Sameer on 3/4/17.
//  Copyright © 2017 Praneeth Alla. All rights reserved.
//

import UIKit

class CorrectViewController: UIViewController {
    
    @IBOutlet var dayButtons: [UIButton]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var classes: [String] = []
    var enrollments = [[String: String]]()
    var timings: [String] = ["08:10:00", "08:55:00", "10:15:00", "11:05:00", "11:55:00", "13:20:00", "14:05:00"]
    let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for button in dayButtons {
            button.addTarget(self, action: #selector(pressedDay), for: .touchUpInside)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func pressedDay(sender: UIButton!) {
        print(sender.titleLabel?.text! ?? "No Text")
        let day = sender.titleLabel?.text!
        for button in dayButtons {
            button.isHidden = true
        }
        self.cancelButton.isHidden = true
        self.detailLabel.isHidden = true
        self.titleLabel.isHidden = true
        
        self.progressSlider.isHidden = false
        self.statusLabel.isHidden = false
        self.activityIndicator.isHidden = false
        
        let key = day?.replacingOccurrences(of: " ", with: "")
        let defaults = UserDefaults.standard
        let date = findDate(dayKey: day!)
        self.delay(0.1) {
            let classes = self.findClasses(date)
            print(classes)
            defaults.set(classes, forKey: key!)
            self.popUpAlert("Done", message: "Press OK to return to the main screen. Your synced schedule should be corrected now.")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func findDate(dayKey: String) -> String {
        let datesArray = ["03-07-2017", "03-08-2017", "03-09-2017", "03-10-2017", "03-13-2017", "03-14-2017", "03-15-2017", "03-16-2017", "03-17-2017", "03-20-2017", "03-21-2017", "03-22-2017"]
        let number = String(describing: dayKey.components(separatedBy: " ")[1])
        let index = Int(number)! - 1
        return datesArray[index]
    }
    
    func findClasses(_ date: String) -> [String: String] {
        var blockDict: [String: String] = [:]
        var foundBlocks: [String] = []
        classes = []
        enrollments = []
        
        let defaults = UserDefaults.standard
        let keys = UDKeys()
        
        let id = defaults.string(forKey: keys.loginKey) as String!
        let username = defaults.string(forKey: keys.userKey) as String!
        
        let urlString = "https://api.veracross.com/ea/v2/enrollments.json?student=\(id!)"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url, options: []) {
                let json = JSON(data: data)
                parseStudentJSON(json)
            }
        }
        
        if classes.count > 0 {
            for i in 0...(classes.count - 1) {
                let urlString = "https://api.veracross.com/ea/v2/class_schedules.json?classes=\(classes[i])&date_from=\(date)&date_to=\(date)"
                
                //let urlString = "https://api.veracross.com/ea/v1/class_schedules.json?classes=\       (classes[i])&date_from=2015-10-06&date_to=2015-10-06"
                
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url, options: []) {
                        let json = JSON(data: data)
                        parseEnrollmentJSON(json)
                    }
                }
            }
        }
        
        if timings.count > 0 {
            for j in 0...(timings.count - 1) {
                var added = false
                if enrollments.count > 0 {
                    for i in 0...(enrollments.count - 1) {
                        if (enrollments[i]["time"]! == timings[j]) {
                            let item = String(enrollments[i]["courseName"]!)!
                            let last = item.characters.last
                            let block = String(describing: item.components(separatedBy: ",")[0])
                            blockDict["\(last!)"] = "\(block)"
                            foundBlocks.append("\(last!)")
                        }
                    }
                }
            }
        }
        
        for block in blocks {
            if foundBlocks.contains(block) == false {
                blockDict[block] = "FREE"
            }
        }
        
        DispatchQueue.main.async{
            self.progressSlider.value = 100
            self.statusLabel.text = "Analyzing...  100%"
        }
        
        return blockDict
        
        
        //print(enrollments)
    }
    
    func parseStudentJSON(_ json: JSON) {
        for result in json[].arrayValue{
            let class_fk = result["class_fk"].stringValue
            classes.append(class_fk)
        }
    }
    func parseEnrollmentJSON(_ json: JSON) {
        for result in json[].arrayValue{
            let courseName = result["categories"].stringValue
            let courseVersion = result["description"].stringValue
            let courseZipFile = result["location"].stringValue
            
            let startTime = result["start_time"].stringValue
            let formattedStartTime = (startTime as NSString).substring(with: NSRange(location: 11, length: 8))
            //print(formattedStartTime)
            
            let obj = ["courseName": courseName, "courseVersion": courseVersion, "location": courseZipFile, "time": formattedStartTime]
            enrollments.append(obj)
        }
    }
    
    func popUpAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        //http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift/24318861#24318861
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }



}
