//
//  SyncViewController.swift
//  EA_Schedule
//
//  Created by Saxena, Sameer on 2/9/17.
//  Copyright © 2017 Praneeth Alla. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var statusLabel: UILabel!
    
    var classes: [String] = []
    var enrollments = [[String: String]]()
    var timings: [String] = ["08:10:00", "08:55:00", "10:15:00", "11:05:00", "11:55:00", "13:20:00", "14:05:00"]
    let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
    
    var mLDone = false
    
    var upperSchool = true
    
    var count: Float = 0.0
    
    var daysArray: [String] = []
    var datesArray: [String] = []
    var dayCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.activityIndicator.isHidden = true
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 320 && screenHeight == 480 {
            self.titleText.isHidden = true
            self.detailText.isHidden = true
            self.okButton.isHidden = true
            self.cancelButton.isHidden = true
        }
        if screenWidth == 320 && screenHeight == 568 {
            self.titleText.isHidden = true
            self.detailText.isHidden = true
            self.okButton.isHidden = true
            self.cancelButton.isHidden = true
        }
        if screenWidth == 414 && screenHeight == 736 {
            self.titleText.isHidden = true
            self.detailText.isHidden = true
            self.okButton.isHidden = true
            self.cancelButton.isHidden = true
        }
        
        if !upperSchool {
            timings = ["08:10:00", "08:55:00", "10:25:00", "11:10:00", "12:35:00", "13:20:00", "14:05:00"]
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 320 && screenHeight == 480 {
            self.titleText.isHidden = false
            self.detailText.isHidden = false
            self.okButton.isHidden = false
            self.cancelButton.isHidden = false
            self.titleText.frame = CGRect(x: 231, y: 165, width: 376, height: 148)
            self.detailText.frame = CGRect(x: 273, y: 305, width: 293, height: 148)
            self.detailText.font = detailText.font.withSize(16)
            self.okButton.frame = CGRect(x: 360, y: 476, width: 118, height: 62)
            self.cancelButton.frame = CGRect(x: 375, y: 568, width: 89, height: 31)
            self.activityIndicator.frame = CGRect(x: 403, y: 354, width: 37, height: 37)
            self.progressSlider.frame = CGRect(x: 300, y: 401, width: 232, height: 31)
            self.statusLabel.frame = CGRect(x: 355, y: 453, width: 152, height: 23)
        }
        if screenWidth == 320 && screenHeight == 568 {
            self.titleText.isHidden = false
            self.detailText.isHidden = false
            self.okButton.isHidden = false
            self.cancelButton.isHidden = false
            self.titleText.frame = CGRect(x: 234, y: 185, width: 375, height: 148)
            self.detailText.frame = CGRect(x: 284, y: 334, width: 275, height: 148)
            self.detailText.font = detailText.font.withSize(15)
            self.okButton.frame = CGRect(x: 368, y: 513, width: 107, height: 71)
            self.cancelButton.frame = CGRect(x: 377, y: 625, width: 89, height: 31)
            self.activityIndicator.frame = CGRect(x: 404, y: 384, width: 37, height: 37)
            self.progressSlider.frame = CGRect(x: 290, y: 443, width: 264, height: 31)
            self.statusLabel.frame = CGRect(x: 346, y: 495, width: 152, height: 23)
        }
        if screenWidth == 414 && screenHeight == 736 {
            self.titleText.isHidden = false
            self.detailText.isHidden = false
            self.okButton.isHidden = false
            self.cancelButton.isHidden = false
            self.titleText.frame = CGRect(x: 275, y: 206, width: 375, height: 148)
            self.detailText.frame = CGRect(x: 298, y: 400, width: 328, height: 148)
            self.okButton.frame = CGRect(x: 403, y: 635, width: 118, height: 79)
            self.cancelButton.frame = CGRect(x: 418, y: 770, width: 89, height: 31)
            self.activityIndicator.frame = CGRect(x: 444, y: 441, width: 37, height: 37)
            self.progressSlider.frame = CGRect(x: 296, y: 506, width: 332, height: 31)
            self.statusLabel.frame = CGRect(x: 386, y: 553, width: 152, height: 23)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancel(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let keys = UDKeys()
        let cameFromLearnt = defaults.bool(forKey: keys.cameFromKey)
        if cameFromLearnt {
            defaults.set(false, forKey: keys.cameFromKey)
            self.performSegue(withIdentifier: "backToHome", sender: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func startButton(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        
        self.titleText.isHidden = true
        self.detailText.isHidden = true
        self.okButton.isHidden = true
        self.activityIndicator.isHidden = false
        self.progressSlider.isHidden = false
        self.statusLabel.isHidden = false
        self.cancelButton.isHidden = true
        
        delay(1.0) {
            defaults.set(self.findClasses("03-07-2017"), forKey: "DAY1")
            //IN FINAL: print("done day 1")
            //IN FINAL: print(defaults.dictionaryForKey("DAY1"))
            self.delay(1.0) {
                defaults.set(self.findClasses("03-08-2017"), forKey: "DAY2")
                //IN FINAL: print("done day 2")
                //IN FINAL: print(defaults.dictionaryForKey("DAY2"))
                self.delay(1.0) {
                    defaults.set(self.findClasses("03-09-2017"), forKey: "DAY3")
                    //IN FINAL: print("done day 3")
                    //IN FINAL: print(defaults.dictionaryForKey("DAY3"))
                    self.delay(1.0) {
                        defaults.set(self.findClasses("03-10-2017"), forKey: "DAY4")
                        //IN FINAL: print("done day 4")
                        //IN FINAL: print(defaults.dictionaryForKey("DAY4"))
                        self.delay(1.0) {
                            defaults.set(self.findClasses("03-13-2017"), forKey: "DAY5")
                            //IN FINAL: print("done day 5")
                            //IN FINAL: print(defaults.dictionaryForKey("DAY5"))
                            self.delay(1.0) {
                                defaults.set(self.findClasses("03-14-2017"), forKey: "DAY6")
                                //IN FINAL: print("done day 6")
                                //IN FINAL: print(defaults.dictionaryForKey("DAY6"))
                                self.delay(1.0) {
                                    defaults.set(self.findClasses("03-15-2017"), forKey: "DAY7")
                                    //IN FINAL: print("done day 7")
                                    //IN FINAL: print(defaults.dictionaryForKey("DAY7"))
                                    self.delay(1.0) {
                                        defaults.set(self.findClasses("03-16-2017"), forKey: "DAY8")
                                        //IN FINAL: print("done day 8")
                                        //IN FINAL: print(defaults.dictionaryForKey("DAY8"))
                                        self.delay(1.0) {
                                            defaults.set(self.findClasses("03-17-2017"), forKey: "DAY9")
                                            //IN FINAL: print("done day 9")
                                            //IN FINAL: print(defaults.dictionaryForKey("DAY9"))
                                            self.delay(1.0) {
                                                defaults.set(self.findClasses("03-20-2017"), forKey: "DAY10")
                                                //IN FINAL: print("done day 10")
                                                //IN FINAL: print(defaults.dictionaryForKey("DAY10"))
                                                self.delay(1.0) {
                                                    defaults.set(self.findClasses("03-21-2017"), forKey: "DAY11")
                                                    //IN FINAL: print("done day 11")
                                                    //IN FINAL: print(defaults.dictionaryForKey("DAY11"))
                                                    self.delay(1.0) {
                                                        defaults.set(self.findClasses("03-22-2017"), forKey: "DAY12")
                                                        //IN FINAL: print("done day 12")
                                                        //IN FINAL: print(defaults.dictionaryForKey("DAY12"))
                                                        self.popUpAlert("Done!", message: "EA Companion App now knows your schedule. Press OK to return to your schedule. Your app may now run offline and therefore much faster. Enjoy!")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
         
        }//END HUGE DELAY STATEMENT
        
        
        
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
        
        count += 1.0
        DispatchQueue.main.async{
            self.progressSlider.value = self.count
            let percentage = Int((self.count/12) * 100)
            self.statusLabel.text = "Analyzing...  \(percentage)%"
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
    
    //Alert
    func popUpAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction: UIAlertAction!) in
            let defaults = UserDefaults.standard
            let keys = UDKeys()
            let id = defaults.string(forKey: keys.loginKey) as String!
            defaults.set([true, id], forKey: keys.useSchedKey)
            let cameFromLearnt = defaults.bool(forKey: keys.cameFromKey)
            if cameFromLearnt {
                defaults.set(false, forKey: keys.cameFromKey)
                self.performSegue(withIdentifier: "backToHome", sender: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
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
