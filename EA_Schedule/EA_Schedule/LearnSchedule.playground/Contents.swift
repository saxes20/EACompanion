//: Playground - noun: a place where people can play

/* import UIKit

var confidence : [String: Int] = ["A":0,"B":0,"C":0,"D":0,"E":0,"F":0,"Z":0]
var preBlocks = []
var learnt : [String: String] = [:]

func checkBlocks(dict: [String: String]) -> [String: String] {
    let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
    var schedule = dict
    for h in blocks {
        if schedule[h] == nil {
            schedule[h] = "FREE"
        }
    }
    return schedule
}

func compare(dict: [String: String]) {
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

func isDone(conf: [String: Int]) -> Bool {
    let blocks = ["A", "B", "C", "D", "E", "F", "Z"]
    var count = 0
    for b in blocks {
        if conf[b] >= 5 {
            count++
        }
    }
    if count == 7 {
        print(learnt)
        for b in blocks {
            print(b)
            print(learnt[b]!)
        }
        return true
    }
    return false
}

//items
let Sameer1 = ["D - Pre-Modern History", "C - oncert Band", "B - Honors Algebra 2", "Z - Introduction to Literature", "E - Honors Spanish 2", "A - AP Computer Sci Princ", "F - Honors Biology"]
let Sameer2 = ["E - Honors Spanish 2", "D - Pre-Modern History", "C - CJazz Ensemble", "Z - Introduction to Literature", "F - Honors Biology", "B - Honors Algebra 2", "A - AP Computer Sci Princ"]

let Praneeth1 = ["FREE", "C - Honors Pre-Calculus BC", "B - AP World History", "Z - World Literature", "E - Honors Spanish 3", "A - AP Computer Sci Princ", "F - Honors Chemistry"]
let Praneeth2 = ["E - Honors Spanish 3", "FREE", "C - Honors Pre-Calculus BC", "Z - World Literature", "F - Honors Chemistry", "B - AP World History", "A - AP Computer Sci Princ"]

let Raunaq1 = ["D - Introduction to Literature", "C - Concert Choir", "B - Honors Biology", "Z - Honors Biology", "E - Honors Spanish 2", "A - Scenic Painting", "A - World Religions", "F - Honors Pre-Calculus BC"]
let Raunaq2 = ["E - Honors Spanish 2", "D - Introduction to Literature", "FREE", "Z - Pre-Modern History", "F - Honors Pre-Calculus BC", "B - Honors Biology", "A - Scenic Painting", "A - World Religions"]

//blockDict
var sBlocks = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "Concert Band", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
var sBlocks2 = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "CJazz Ensemble", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
//checkBlocks(sBlocks2)

//var pBlocks = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
//var pBlocks2 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
//checkBlocks(pBlocks)

var rBlocks1 = ["A": "World Religions", "D": "Introduction to Literature", "C": "Concert Choir", "B": "Honors Biology", "F": "Honors Pre-Calculus BC", "Z": "Honors Biology", "E": "Honors Spanish 2"]
var rBlocks2 = ["A": "World Religions", "D": "Introduction to Literature", "C": "Concert Choir", "B": "Honors Biology", "F": "Honors Pre-Calculus BC", "Z": "Pre-Modern History", "E": "Honors Spanish 2"]
checkBlocks(rBlocks2)

//learntSchedule
//TO LEARN AND COMPARE: Check for 5 days whether blockDict stays the same, build confidence up to 5 for each block, ask if schedule is correct, if yes analyze 12 days of users' schedule to find drop blocks and double biology, finally keep learntSchedule and drop blocks saved in NSUserDefaults to make app instantaneous. Add codes in login screen to forget schedule

let pBlocks = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
let pBlocks2 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
let pBlocks3 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
let pBlocks4 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
let pBlocks5 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "Honors Chemistry", "E": "Honors Spanish 3"]
let pBlocks6 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]
let pBlocks7 = ["B": "AP World History", "A": "AP Computer Sci Princ", "F": "Honors Chemistry", "C": "Honors Pre-Calculus BC", "Z": "World Literature", "E": "Honors Spanish 3"]

//FIRST TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks)
} else {
    compare(checkBlocks(pBlocks))
}
learnt
confidence
isDone(confidence)

//SECOND TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks2)
} else {
    compare(checkBlocks(pBlocks2))
}
learnt
confidence
isDone(confidence)

//THIRD TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks3)
} else {
    compare(checkBlocks(pBlocks3))
}
learnt
confidence
isDone(confidence)

//FOURTH TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks4)
} else {
    compare(checkBlocks(pBlocks4))
}
learnt
confidence
isDone(confidence)

//FIFTH TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks5)
} else {
    compare(checkBlocks(pBlocks5))
}
learnt
confidence
isDone(confidence)

//SIXTH TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks6)
} else {
    compare(checkBlocks(pBlocks6))
}
learnt
confidence
isDone(confidence)

//SEVENTH TIME
if learnt == [:] {
    learnt = checkBlocks(pBlocks7)
} else {
    compare(checkBlocks(pBlocks7))
}
learnt
confidence
isDone(confidence) */


