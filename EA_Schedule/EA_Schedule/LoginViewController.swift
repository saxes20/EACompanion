//
//  LoginViewController.swift
//  EA_Schedule
//
//  Created by Praneeth Alla on 12/15/15.
//  Copyright © 2015 Praneeth Alla. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class LoginViewController: UIViewController, UITextFieldDelegate {

    var objects = [[String: String]]()
    var id = ""
    var student = false
    var isValid = true
    var upperSchool = true
    
    @IBOutlet weak var eaTitleLabel: UILabel!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    func mainUI() {
        self.activityIndicator.isHidden = false
    }
    
    @IBAction func LoginVerification(_ sender: AnyObject) {
        mainUI()
        
        isValid = true
        let enteredUsername = self.TextField.text!.trimmingCharacters(in: .whitespaces)
        
        delay(1.0) { 
            let defaults = UserDefaults.standard
            let keys = UDKeys()
            if enteredUsername.characters.last! == "9"  {
                self.student = true
            }
            else if enteredUsername.characters.last! == "8" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "7" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "6" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "5" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "4" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "3" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "2" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "1" {
                self.student = true
            }
            else if enteredUsername.characters.last! == "0" {
                self.student = true
            }
            else {
                self.student = false
            }
            
            let lastTwoChars = String(enteredUsername.characters.suffix(2))
            let gradYear = Int(lastTwoChars)
            if gradYear >= 17 && gradYear <= 20 {
                self.upperSchool = true
            }
            else if gradYear >= 21 && gradYear <= 29  {
                self.upperSchool = false
            } else {
                self.isValid = false
            }
            
            /* MUST HAVE TO ACTUALLY CHECK WHETHER STUDENT IS STUDENT AS SAXES20 SHOULD WORK AND DOES, ALLAPK20 SHOULDN'T WORK AND DOES, ALLAPK SHOULDN'T WORK AND DOESN'T BUT STILL SENDS TO DETAIL */
            
            //IN FINAL: print("Student is \(self.student)")
            //print(isValid)
            
            if !self.student {
                /* CHANGED */
                let urlString = "https://api.ea:jqy2Pvg7hs@api.veracross.com/ea/v2/facstaff.json?count=487"
                
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url, options: []) {
                        let json = JSON(data: data)
                        self.parseJSON(json);
                    }
                }
            }
            if self.student && self.isValid {
                var found = false
                if let page = defaults.string(forKey: "\(enteredUsername)") {
                    //IN FINAL: print("Page remembered as \(page)")
                    let urlString = "https://api.ea:jqy2Pvg7hs@api.veracross.com/ea/v2/students.json?page=\(page)"
                    
                    if let url = URL(string: urlString) {
                        if let data = try? Data(contentsOf: url, options: []) {
                            let json = JSON(data: data)
                            self.parseJSON(json);
                        }
                    }
                    
                    if self.objects.count > 0 {
                        found = true
                    }
                }
                if !found {
                    for i in 1...13 {
                        let urlString = "https://api.ea:jqy2Pvg7hs@api.veracross.com/ea/v2/students.json?page=\(i)"
                        
                        if let url = URL(string: urlString) {
                            if let data = try? Data(contentsOf: url, options: []) {
                                let json = JSON(data: data)
                                self.parseJSON(json);
                            }
                        }
                        
                        //print("page \(i)")
                        
                        if self.objects.count > 0 {
                            defaults.set("\(i)", forKey: "\(enteredUsername)")
                            break
                        }
                    }
                }
            }
            
            //print("Here 1")
            
            print(self.objects)
            if self.objects.count > 0 {
                for i in 0...(self.objects.count - 1) {
                    if self.objects[i]["username"] == enteredUsername {
                        //IN FINAL: print(self.objects[i]["person_pk"]!)
                        //print(objects[i]["household_fk"]!)
                        self.id = self.objects[i]["person_pk"]!
                    }
                }
            }
            
            //print("Here 2")
            var online = ""
            if let checkOnline = defaults.string(forKey: keys.onlineKey) {
                online = checkOnline
            }
            
            defaults.setValue(self.id, forKey: keys.loginKey)
            print(self.id)
            defaults.setValue(self.student, forKey: keys.studentKey)
            defaults.setValue(enteredUsername, forKey: keys.userKey)
            
            //print("Here 3")
            if self.objects.count > 0 {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ScheduleView") as! ViewController
                //IN FINAL: print("Upper School in Login \(self.upperSchool)")
                resultViewController.upperSchool = self.upperSchool
                if online == "online" {
                    resultViewController.online = true
                }
                else if online == "offline" {
                    resultViewController.online = false
                }
                self.present(resultViewController, animated:true, completion:nil)
            } else {
                if enteredUsername == "forgetSchedule" {
                    defaults.set([:], forKey: keys.scheduleKey)
                    defaults.setValue("", forKey: keys.switchKey)
                    defaults.set([], forKey: keys.altBlocksKey)
                    defaults.set(false, forKey: keys.learntKey)
                    defaults.set([false, ""], forKey: keys.useSchedKey)
                    defaults.setValue("", forKey: keys.learntUserKey)
                    self.statusLabel.text = "Code successful."
                    self.activityIndicator.isHidden = true
                    self.TextField.text = ""
                }
                else if enteredUsername == "goOffline" {
                    defaults.setValue("offline", forKey: keys.onlineKey)
                    self.statusLabel.text = "Code successful."
                    self.activityIndicator.isHidden = true
                    self.TextField.text = ""
                }
                else if enteredUsername == "goOnline" {
                    defaults.setValue("online", forKey: keys.onlineKey)
                    self.statusLabel.text = "Code successful."
                    self.activityIndicator.isHidden = true
                    self.TextField.text = ""
                }else {
                    self.statusLabel.text = "Please enter a valid username."
                    self.activityIndicator.isHidden = true
                    self.TextField.text = ""
                }
            }
        }
        
    }
    
    func parseJSON(_ json: JSON) {
        let enteredUsername = TextField.text!.trimmingCharacters(in: .whitespaces)
        for result in json[].arrayValue{
            if result["username"].stringValue == enteredUsername {
                let person_pk = result["person_pk"].stringValue
                let username = result["username"].stringValue
                let obj = ["person_pk": person_pk, "username": username]
                objects.append(obj)
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.activityIndicator.hidden = false
        scrollView.contentSize.width = 375
        scrollView.contentSize.height = 667
        scrollView.isDirectionalLockEnabled = true
        
        scrollView.isUserInteractionEnabled = true
        let function : Selector = #selector(LoginViewController.scrollTouched)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: function)
        gestureRecognizer.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(gestureRecognizer)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 320 {
            self.eaTitleLabel.font = eaTitleLabel.font.withSize(28)
        }
        
        TextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollTouched() {
        self.scrollView.endEditing(true)
        //self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        //http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift/24318861#24318861
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
