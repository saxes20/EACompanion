//
//  ViewController.swift
//  EA_Schedule
//
//  Created by Praneeth Alla on 12/14/15.
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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var onlineSwitch: UISwitch!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var syncOfflineButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var returnTodayButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var lastButton: UIButton!
    
    var objects = [[String: String]]()
    var enrollments = [[String: String]]()
    var classes: [String] = []
    var items: [String] = []
    var timings: [String] = ["08:10:00", "08:55:00", "10:15:00", "11:05:00", "11:55:00", "13:20:00", "14:05:00"]
    var dateShowing = 0;
    
    var blockDict: [String: String] = [:]
    
    var online: Bool = true
    
    var upperSchool: Bool = true
    var student: Bool = false
    
    var confidence : [String: Int] = ["A":0,"B":0,"C":0,"D":0,"E":0,"F":0,"Z":0]
    var learnt : [String: String] = [:]
    var switchBlock: String?
    var altBlocks: [String] = []
    var filtered: [String] = []
    var dayCounter = 0
    
    let udKeys = UDKeys()
    
    var loading = false
    
    @IBAction func previousClicked(_ sender: UIButton) {
        if !loading {
            dateShowing = dateShowing - 1;
            if online {
                self.activityIndicator.isHidden = false
                self.returnTodayButton.isHidden = true
                loading = true
            }
            self.delay(0.1) {
                self.fillTable()
            }
        }
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if !loading {
            dateShowing = dateShowing + 1;
            if online {
                self.activityIndicator.isHidden = false
                self.returnTodayButton.isHidden = true
                loading = true
            }
            self.delay(0.1) {
                self.fillTable()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 414 && screenHeight == 736 {
            if online {
                cell.textLabel?.font = cell.textLabel?.font.withSize(17)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row] != " FREE" && online == true && student == true {
            self.detailsView.isHidden = false
            self.detailsView.alpha = 1
            for course in enrollments {
                if course["time"] == timings[indexPath.row] {
                    if let time = course["time"] {
                        let parts = time.components(separatedBy: ":")
                        var hours = Int(parts[0])
                        if hours > 12 {
                            hours = hours! - 12
                        }
                        self.timeLabel.text = "\(hours!):\(parts[1])"
                    } else {
                        self.timeLabel.text = "N/A"
                    }
                    if let item = course["courseName"] {
                        let block = String(item.components(separatedBy: ",")[0])
                        self.classLabel.text = block
                    } else {
                        self.classLabel.text = "N/A"
                    }
                    if let item2 = course["location"] {
                        let roomArray = item2.components(separatedBy: ":")
                        if roomArray.count > 1 {
                            let room = String(roomArray[1])
                            self.roomLabel.text = room
                        } else {
                            self.roomLabel.text = "N/A"
                        }
                    } else {
                        self.roomLabel.text = "N/A"
                    }
                    if let courseVersion = course["courseVersion"] {
                        let seperate0 = courseVersion.components(separatedBy: ";")[0]
                        let seperate = seperate0.components(separatedBy: " - ")
                        self.teacherLabel.text = seperate.last
                    } else {
                        self.teacherLabel.text = "N/A"
                    }
                }
            }
        }
    }

    @IBAction func exitDetails(_ sender: AnyObject) {
        hideDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //IN FINAL: print("Upper School at Load \(upperSchool)")
        if !upperSchool {
            timings = ["08:10:00", "08:55:00", "10:25:00", "11:10:00", "12:35:00", "13:20:00", "14:05:00"]
        }
        self.detailsView.isHidden = true
        self.teacherLabel.adjustsFontSizeToFitWidth = true
        self.classLabel.adjustsFontSizeToFitWidth = true
        self.roomLabel.adjustsFontSizeToFitWidth = true
        self.timeLabel.adjustsFontSizeToFitWidth = true
        self.returnTodayButton.isHidden = true
        self.onlineSwitch.isOn = online
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: udKeys.studentKey) as Bool! == false {
            self.syncOfflineButton.isHidden = true
        }
        
        let id = defaults.string(forKey: udKeys.loginKey) as String!
        if let useArray = defaults.array(forKey: udKeys.useSchedKey) {
            if useArray[0] as! Bool && useArray[1] as! String == id {
                self.syncOfflineButton.setTitle("Correct Synced Schedule", for: .normal)
            }
        }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 320 && screenHeight == 480 {
            if !online {
                self.tableView.rowHeight = 27
            } else {
                self.tableView.rowHeight = 30
            }
            
            //x: 24, y:217
        }
        if screenWidth == 320 && screenHeight == 568 {
            if !online {
                self.tableView.rowHeight = 33
            } else {
                self.tableView.rowHeight = 40
            }
        }
        if screenWidth == 414 && screenHeight == 736 {
            if !online {
                self.tableView.rowHeight = 46
            } else {
                self.tableView.rowHeight = 56
            }
        }
        
        fillTable();
    
    }
    
    override func viewDidLayoutSubviews() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 320 && screenHeight == 480 {
            self.detailsView.center = CGPoint(x: 158, y: 296)
            //x: 24, y:217
        }
        if screenWidth == 320 && screenHeight == 568 {
            self.detailsView.center = CGPoint(x: 159, y: 329)
        }
        if screenWidth == 414 && screenHeight == 736 {
            self.detailsView.center = CGPoint(x: 204, y: 393)
            //self.tableView.center = CGPoint(x: 207, y: 388)
        }
    }
    
    func fillTable() {
        blockDict = [:]
        
        let calendar = Calendar.current
        
        let tommorrow = (calendar as NSCalendar).date(byAdding: .day, value: dateShowing + 1, to: Date(), options: [])
        
        let date = (calendar as NSCalendar).date(byAdding: .day, value: dateShowing, to: Date(), options: [])
        
        let formatter = DateFormatter();
        formatter.dateFormat = "MM-dd-yyyy";
        let dateFormatted = formatter.string(from: date!)
        let tommorrowFormatted = formatter.string(from: tommorrow!)
        
        let defaults = UserDefaults.standard
        let id = defaults.string(forKey: udKeys.loginKey) as String!
        let username = defaults.string(forKey: udKeys.userKey) as String!
        
        items = []
        classes = []
        enrollments = []
        objects = []
        
        var noschool = false
        var shouldUseSched = false
        
        self.usernameLabel.text = username
        self.dateLabel.text = dateFormatted
        //self.dayLabel.text = pa(dateFormatted)
        
        if let plistPath = Bundle.main.path(forResource: "DaySchedule", ofType: "plist") {
            let dayScheduleDict = NSDictionary(contentsOfFile: plistPath)
            
            var dateAsString = "\(dateFormatted)"
            let first = String(dateAsString[dateAsString.characters.index(dateAsString.startIndex, offsetBy: 0)])
            let fourth = String(dateAsString[dateAsString.characters.index(dateAsString.startIndex, offsetBy: 3)])
            if first == "0" {
                dateAsString = String(dateAsString.characters.dropFirst())
            }
            if fourth == "0" {
                dateAsString.remove(at: dateAsString.characters.index(dateAsString.startIndex, offsetBy: 2))
            }
            //IN FINAL: print(dateAsString)
            
            if let daySt = dayScheduleDict![dateAsString] as? String {
                self.dayLabel.text = "\(daySt)"
                //IN FINAL: print(daySt)
                
                if let useArray = defaults.array(forKey: udKeys.useSchedKey) {
                    if useArray[0] as! Bool && useArray[1] as! String == id {
                        shouldUseSched = true
                    }
                }
                
                if !online {
                    
                    var applyLearn = false
                    var schedule: [String: String] = [:]
                    
                    if defaults.bool(forKey: udKeys.learntKey) == true && !shouldUseSched {
                        if let theSchedule = defaults.dictionary(forKey: udKeys.scheduleKey) {
                            if username == defaults.string(forKey: udKeys.learntUserKey) {
                                applyLearn = true
                                schedule = theSchedule as! [String: String]
                            }
                        }
                    }
                    
                    let day = convertDay(daySt)
                    let daySchedule = DaySchedule(day: day, upperSchool: upperSchool)
                    //print(daySchedule.schedule)
                    for o in 0...(daySchedule.schedule.count - 1) {
                        if !applyLearn && !shouldUseSched {
                            if daySchedule.schedule[o].characters.count == 1 {
                                items.append(" \(daySchedule.times[o]): \(daySchedule.schedule[o]) Block")
                            } else {
                                items.append(" \(daySchedule.times[o]): \(daySchedule.schedule[o])")
                            }
                        }
                        else if applyLearn && !shouldUseSched {
                            if daySchedule.schedule[o].characters.count == 1 {
                                items.append(" \(daySchedule.times[o]): \(daySchedule.schedule[o]) Block (\(schedule[daySchedule.schedule[o]]!))")
                            } else {
                                items.append(" \(daySchedule.times[o]): \(daySchedule.schedule[o])")
                            }
                        }
                        else if (!applyLearn && shouldUseSched) || (applyLearn && shouldUseSched) {
                            let dayKey = convertDayToKey(day)
                            if let mySchedule = defaults.dictionary(forKey: dayKey) {
                                if daySchedule.schedule[o].characters.count == 1 {
                                    items.append(" \(daySchedule.schedule[o]) - \(mySchedule[daySchedule.schedule[o]]!)")
                                } else {
                                    items.append(" \(daySchedule.schedule[o])")
                                }
                            }
                        }
                    }
                    
                }
                
            } else {
                self.dayLabel.text = "No School"
                noschool = true
            }
        }
        
        if defaults.bool(forKey: udKeys.studentKey) as Bool! == false && noschool == false && online == true {
            let urlString = "https://api.ea:jqy2Pvg7hs@api.veracross.com/ea/v2/class_schedules.json?teachers=\(id!)&date_from=\(dateFormatted)&date_to=\(dateFormatted)"
            
            //print(urlString)
            
            //let urlString = "https://api.ea:jqy2Pvg7hs@api.veracross.com/ea/v1/class_schedules.json?teachers=\(id)&date_from=2015-11-06&date_to=2015-11-06"
            student = false
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let json = JSON(data: data)
                    parseJSON(json)
                    //print(json);
                }
            }
            
            for j in 0...(timings.count - 1) {
                var added = false
                for i in 0...(objects.count - 1) {
                    if (objects[i]["time"]! == timings[j]) {
                        let item = String(objects[i]["courseName"]!)!
                        let last = item.characters.last
                        let block = String(item.components(separatedBy: ",")[0])
                        let finalItem = " \(last!) - \(block!)"
                        blockDict["\(last!)"] = "\(block)"
                        items.append(finalItem)
                        added = true
                    }
                }
                if !added {
                    items.append(" FREE")
                }
            }
        }
        
        if defaults.bool(forKey: udKeys.studentKey) as Bool! == true && noschool == false && online == true {
            let urlString = "https://api.veracross.com/ea/v2/enrollments.json?student=\(id!)"
            print(urlString)
            student = true
            
            if let url = URL(string: urlString) {
                //print("hi 1")
                if let data = try? Data(contentsOf: url) {
                    //print("hi 2")
                    let json = JSON(data: data)
                    parseStudentJSON(json)
                }
            }
            
            print("Classes - \(classes)")
            for i in 0 ... (classes.count - 1){
                let urlString = "https://api.veracross.com/ea/v2/class_schedules.json?classes=\(classes[i])&date_from=\(dateFormatted)&date_to=\(dateFormatted)"
                
                //let urlString = "https://api.veracross.com/ea/v1/class_schedules.json?classes=\(classes[i])&date_from=2015-10-06&date_to=2015-10-06"
                
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url, options: []) {
                        let json = JSON(data: data)
                        parseEnrollmentJSON(json)
                    }
                }
            }
            
            for j in 0...(timings.count - 1) {
                var added = false
                for i in 0...(enrollments.count - 1) {
                    if (enrollments[i]["time"]! == timings[j]) {
                        let item = String(enrollments[i]["courseName"]!)!
                        let last = item.characters.last
                        let block = String(describing: item.components(separatedBy: ",")[0])
                        let finalItem = " \(last!) - \(block)"
                        blockDict["\(last!)"] = "\(block)"
                        items.append(finalItem)
                        added = true
                    }
                }
                if !added {
                    items.append(" FREE")
                }
            }
            //print(enrollments)
            
        }
        
        if noschool {
            for i in 1...7 {
                items.append(" FREE")
            }
        }
        
        if student {
            //IN FINAL: print("---- Original Schedule ---- ")
            //IN FINAL: print(items)
            //IN FINAL: print("---- Block Dictionary ----")
            //IN FINAL: print(blockDict)
            //print(defaults.dictionaryForKey(udKeys.scheduleKey))
            //print(defaults.stringForKey(udKeys.learntUserKey))
            //print(defaults.boolForKey(udKeys.learntKey))
            var shouldRun = false
            if let useArray = defaults.array(forKey: udKeys.useSchedKey) {
                if useArray[0] as! Bool && useArray[1] as! String == id {
                    shouldRun = true
                }
            }
            if online && !noschool && defaults.bool(forKey: udKeys.learntKey) == false && !shouldRun {
                if defaults.bool(forKey: udKeys.pressedCancel) == true {
                    confidence = ["A":0,"B":0,"C":0,"D":0,"E":0,"F":0,"Z":0]
                    learnt = [:]
                    switchBlock = ""
                    altBlocks = []
                    filtered = []
                    dayCounter = 0
                    defaults.set(false, forKey: udKeys.pressedCancel)
                }
                
                learn(blockDict)
                print("---- Learnt Schedule ----")
                print(learnt)
                print("---- Confidence ----")
                print(confidence)
                print("---- Switch Blocks ----")
                print(altBlocks)
            }
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
        self.activityIndicator.isHidden = true
        loading = false
        
        if dateShowing == 0 {
            self.returnTodayButton.isHidden = true
        } else {
            self.returnTodayButton.isHidden = false
        }
        
        if shouldUseSched {
            self.syncOfflineButton.setTitle("Correct Synced Schedule", for: .normal)
        }
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        if !online || screenHeight < 600 {
            self.tableView.tableFooterView = UIView()
        }
        
    }
    
    func parseJSON(_ json: JSON) {
        for result in json[].arrayValue{
            let courseName = result["categories"].stringValue
            let courseVersion = result["description"].stringValue
            let courseZipFile = result["location"].stringValue
            
            let startTime = result["start_time"].stringValue
            let formattedStartTime = (startTime as NSString).substring(with: NSRange(location: 11, length: 8))
            //IN FINAL: print(formattedStartTime)
            
            let obj = ["courseName": courseName, "courseVersion": courseVersion, "location": courseZipFile, "time": formattedStartTime]
            objects.append(obj)
        }
    }
    func parseStudentJSON(_ json: JSON) {
        //print(json[].arrayValue)
        for result in json[].arrayValue {
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
            //IN FINAL: print(formattedStartTime)
            
            let obj = ["courseName": courseName, "courseVersion": courseVersion, "location": courseZipFile, "time": formattedStartTime]
            enrollments.append(obj)
        }
    }
    
    @IBAction func syncOffline(_ sender: AnyObject) {
        if syncOfflineButton.titleLabel?.text == "Sync Schedule Offline" {
            self.performSegue(withIdentifier: "syncSegue", sender: nil)
        }
        else if syncOfflineButton.titleLabel?.text == "Correct Synced Schedule" {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            if screenWidth == 320 && screenHeight == 480 {
                self.performSegue(withIdentifier: "correctSegue4", sender: nil)
            }
            else if screenWidth == 320 && screenHeight == 568 {
                self.performSegue(withIdentifier: "correctSegue5", sender: nil)
            }
            else if screenWidth == 375 && screenHeight == 667 {
                self.performSegue(withIdentifier: "correctSegue6", sender: nil)
            }
            else if screenWidth == 414 && screenHeight == 736 {
                self.performSegue(withIdentifier: "correctSegue6Plus", sender: nil)
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchPressed(_ sender: AnyObject) {
        online = sender.isOn
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        if screenWidth == 320 && screenHeight == 480 {
            if !online {
                self.tableView.rowHeight = 27
            } else {
                self.tableView.rowHeight = 30
            }
        }
        //print(online)
        if screenWidth == 320 && screenHeight == 568 {
            if !online {
                self.tableView.rowHeight = 33
            } else {
                self.tableView.rowHeight = 40
            }
        }
        if screenWidth == 414 && screenHeight == 736 {
            if !online {
                self.tableView.rowHeight = 46
            } else {
                self.tableView.rowHeight = 56
            }
        }
    }
    
    func convertDay(_ dayStr: String) -> Day {
        switch dayStr {
            case "Day 1":
                return Day.day1
            case "Day 2":
                return Day.day2
            case "Day 3":
                return Day.day3
            case "Day 4":
                return Day.day4
            case "Day 5":
                return Day.day5
            case "Day 6":
                return Day.day6
            case "Day 7":
                return Day.day7
            case "Day 8":
                return Day.day8
            case "Day 9":
                return Day.day9
            case "Day 10":
                return Day.day10
            case "Day 11":
                return Day.day11
            case "Day 12":
                return Day.day12
            default:
                //IN FINAL: print("Could not convert day")
                return Day.day1
        }
    }
    
    func convertDayToKey(_ day: Day) -> String {
        switch day {
            case Day.day1:
                return "DAY1"
            case Day.day2:
                return "DAY2"
            case Day.day3:
                return "DAY3"
            case Day.day4:
                return "DAY4"
            case Day.day5:
                return "DAY5"
            case Day.day6:
                return "DAY6"
            case Day.day7:
                return "DAY7"
            case Day.day8:
                return "DAY8"
            case Day.day9:
                return "DAY9"
            case Day.day10:
                return "DAY10"
            case Day.day11:
                return "DAY11"
            case Day.day12:
                return "DAY12"
        }
    }
    
    //Learn functions
    func checkBlocks(_ dict: [String: String]) -> [String: String] {
        let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
        var schedule = dict
        for h in blocks {
            if schedule[h] == nil {
                schedule[h] = "FREE"
            }
        }
        return schedule
    }
    
    func compare(_ dict: [String: String]) {
        let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
        for b in blocks {
            if learnt[b] == dict[b] {
                confidence[b] = confidence[b]! + 1
            } else {
                if confidence[b] == 0 {
                    learnt[b] = dict[b]
                }
            }
        }
    }
    
    func isDone(_ conf: [String: Int]) -> Bool {
        let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
        var count = 0
        for b in blocks {
            if conf[b] >= 5 {
                count += 1
            }
            if conf[b] == 0 {
                switchBlock = b
                altBlocks.append(learnt[switchBlock!]!)
            }
        }
        if count == 7 {
            //IN FINAL: print(learnt)
            for b in blocks {
                //IN FINAL: print(b)
                //IN FINAL: print(learnt[b]!)
            }
            popUpAlert("Learning Completed", message: "EA Companion has learnt your schedule.")
            return true
        }
        return false
    }
    
    func filter(_ fullArray: [String]) -> [String] {
        let filtered = Array(Set(fullArray))
        return filtered
    }
    
    func learn(_ blocks: [String: String]) {
        dayCounter += 1
        
        if learnt == [:] {
            learnt = checkBlocks(blocks)
        } else {
            compare(checkBlocks(blocks))
        }
        
        if dayCounter >= 4 {
            filtered = filter(altBlocks)
            
            if filtered.count == 2 {
                confidence[switchBlock!] = 5
                learnt[switchBlock!] = String(describing: filtered)
            }
            
            isDone(confidence)
        }
    }
    
    //Alert
    func popUpAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction: UIAlertAction!) in
            self.performSegue(withIdentifier: "learntSegue", sender: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hideDetails() {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                self.detailsView.alpha = 0
            }) { (finished) in
                self.detailsView.isHidden = true
                
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "learntSegue" {
            let defaults = UserDefaults.standard
            defaults.set(learnt, forKey: udKeys.scheduleKey)
            defaults.setValue(switchBlock, forKey: udKeys.switchKey)
            defaults.set(altBlocks, forKey: udKeys.altBlocksKey)
        }
        if segue.identifier == "syncSegue" {
            let destVC = segue.destination as! SyncViewController
            destVC.upperSchool = upperSchool
        }
    }
    
    @IBAction func returnToday(_ sender: Any) {
        dateShowing = 0
        self.returnTodayButton.isHidden = true
        self.activityIndicator.isHidden = false
        loading = true
        self.delay(0.1) { 
            self.fillTable()
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        //http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift/24318861#24318861
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    

}

