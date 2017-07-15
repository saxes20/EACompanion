//
//  ScheduleViewController.swift
//  EA_Schedule
//
//  Created by Saxena, Sameer on 1/28/17.
//  Copyright © 2017 Praneeth Alla. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var aBlock: UILabel!
    @IBOutlet weak var bBlock: UILabel!
    @IBOutlet weak var cBlock: UILabel!
    @IBOutlet weak var dBlock: UILabel!
    @IBOutlet weak var eBlock: UILabel!
    @IBOutlet weak var fBlock: UILabel!
    @IBOutlet weak var zBlock: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.width = 375
        scrollView.contentSize.height = 667
        scrollView.delegate = self
        
        descripLabel.adjustsFontSizeToFitWidth = true
        
        let defaults = UserDefaults.standard
        let udkeys = UDKeys()
        var revisedLearntSchedule: [String: String] = [:]
        // Do any additional setup after loading the view.
        if let dictionary = defaults.dictionary(forKey: udkeys.scheduleKey) {
            let schedule = dictionary as! [String: String]
            revisedLearntSchedule = schedule
            aBlock.text = schedule["A"]
            bBlock.text = schedule["B"]
            cBlock.text = schedule["C"]
            dBlock.text = schedule["D"]
            eBlock.text = schedule["E"]
            fBlock.text = schedule["F"]
            zBlock.text = schedule["Z"]
        } else {
            //IN FINAL: print("Error")
        }
        
        if let switchBlock = defaults.string(forKey: udkeys.switchKey) {
            if let switchBlocks = defaults.array(forKey: udkeys.altBlocksKey) {
                if switchBlocks.count > 0 {
                    let switchClass = "\(switchBlocks[0]) or \(switchBlocks[1])"
                    switch switchBlock {
                        case "A":
                            aBlock.text = switchClass
                            break
                        case "B":
                            bBlock.text = switchClass
                            break
                        case "C":
                            cBlock.text = switchClass
                            break
                        case "D":
                            dBlock.text = switchClass
                            break
                        case "E":
                            eBlock.text = switchClass
                            break
                        case "F":
                            fBlock.text = switchClass
                            break
                        case "Z":
                            zBlock.text = switchClass
                            break
                        default: break
                    }
                    revisedLearntSchedule[switchBlock] = switchClass
                }
            } else {
                //IN FINAL: print("No switch blocks array")
            }
        } else {
            //IN FINAL: print("No switch block")
        }
        
        defaults.set(true, forKey: udkeys.learntKey)
        defaults.set(revisedLearntSchedule, forKey: udkeys.scheduleKey)
        let user = defaults.string(forKey: udkeys.userKey)
        defaults.set(user, forKey: udkeys.learntUserKey)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = background.bounds
        background.addSubview(visualEffectView)
        
        aBlock.adjustsFontSizeToFitWidth = true
        bBlock.adjustsFontSizeToFitWidth = true
        cBlock.adjustsFontSizeToFitWidth = true
        dBlock.adjustsFontSizeToFitWidth = true
        eBlock.adjustsFontSizeToFitWidth = true
        fBlock.adjustsFontSizeToFitWidth = true
        zBlock.adjustsFontSizeToFitWidth = true
        
    }

    @IBAction func pressedOK(_ sender: AnyObject) {
        popUpAlert("Syncing your Schedule", message: "In order to fully teach EA Companion App your schedule, press OK to be taken to the syncing schedule screen. The process will take around 5 minutes. If you would like to complete this process at a later time, you may press Cancel on the NEXT screen.")
    }
    
    
    @IBAction func pressedCancel(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let udkeys = UDKeys()
        defaults.set([:], forKey: udkeys.scheduleKey)
        defaults.setValue("", forKey: udkeys.switchKey)
        defaults.set([], forKey: udkeys.altBlocksKey)
        defaults.set(false, forKey: udkeys.learntKey)
        defaults.setValue("", forKey: udkeys.learntUserKey)
        defaults.set(true, forKey: udkeys.pressedCancel)
        self.dismiss(animated: true, completion: nil)
    }
    
    func popUpAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction: UIAlertAction!) in
            let defaults = UserDefaults.standard
            let keys = UDKeys()
            defaults.set(true, forKey: keys.cameFromKey)
            self.performSegue(withIdentifier: "learnToSync", sender: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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

}
