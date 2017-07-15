//: Playground - noun: a place where people can play
/*
import UIKit

var confidence : [String: Int] = ["A":0,"B":0,"C":0,"D":0,"E":0,"F":0,"Z":0]
var preBlocks = []
var learnt : [String: String] = [:]
var switchBlock: String?
var altBlocks: [String] = []
var filtered = []
var dayCounter = 0

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
            count += 1
        }
        if conf[b] == 0 {
            switchBlock = b
            altBlocks.append(learnt[switchBlock!]!)
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

func filter(fullArray: [String]) -> [String] {
    let filtered = Array(Set(fullArray))
    return filtered
}

let sBlocks = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "Concert Band", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
let sBlocks2 = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "CJazz Ensemble", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
let sBlocks3 = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "Concert Band", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
let sBlocks4 = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "CJazz Ensemble", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
let sBlocks5 = ["B": "Honors Algebra 2", "A": "AP Computer Sci Princ", "F": "Honors Biology", "C": "Concert Band", "Z": "Honors Biology", "D": "Pre-Modern History"]
let sBlocks6 = ["A": "AP Computer Sci Princ", "C": "CJazz Ensemble", "D": "Pre-Modern History", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]
let sBlocks7 = ["A": "AP Computer Sci Princ", "D": "Pre-Modern History", "C": "Concert Band", "B": "Honors Algebra 2", "F": "Honors Biology", "Z": "Introduction to Literature", "E": "Honors Spanish 2"]

func learn(blocks: [String: String]) {
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
            learnt[switchBlock!] = String(filtered)
        }
        
        isDone(confidence)
    }
}

//ONLY RUN ISDONE ON OR AFTER FOURTH TIME 

//FIRST TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks)
} else {
    compare(checkBlocks(sBlocks))
}
learnt
confidence


//SECOND TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks2)
} else {
    compare(checkBlocks(sBlocks2))
}
learnt
confidence

//THIRD TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks3)
} else {
    compare(checkBlocks(sBlocks3))
}
learnt
confidence

//FOURTH TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks4)
} else {
    compare(checkBlocks(sBlocks4))
}
learnt
confidence

altBlocks
filtered = filter(altBlocks)

if filtered.count == 2 {
    confidence[switchBlock!] = 5
    learnt[switchBlock!] = String(filtered)
}

isDone(confidence)

//FIFTH TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks5)
} else {
    compare(checkBlocks(sBlocks5))
}
learnt
confidence

altBlocks
filtered = filter(altBlocks)

if filtered.count == 2 {
    confidence[switchBlock!] = 5
    learnt[switchBlock!] = String(filtered)
}

isDone(confidence)

//SIXTH TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks6)
} else {
    compare(checkBlocks(sBlocks6))
}
learnt
confidence

altBlocks
filtered = filter(altBlocks)

if filtered.count == 2 {
    confidence[switchBlock!] = 5
    learnt[switchBlock!] = String(filtered)
}

isDone(confidence)

//SEVENTH TIME
if learnt == [:] {
    learnt = checkBlocks(sBlocks7)
} else {
    compare(checkBlocks(sBlocks7))
}
learnt
confidence

altBlocks
filtered = filter(altBlocks)

if filtered.count == 2 {
    confidence[switchBlock!] = 5
    learnt[switchBlock!] = String(filtered)
}

isDone(confidence) */
