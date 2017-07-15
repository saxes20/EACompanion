//: Playground - noun: a place where people can play
/*
import UIKit

var confidence : [String: Int] = ["A":0,"B":0,"C":0,"D":0,"E":0,"F":0,"Z":0]
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

let rBlocks1 = ["A": "World Religions", "D": "Introduction to Literature", "C": "Concert Choir", "B": "Honors Biology", "F": "Honors Pre-Calculus BC", "Z": "Honors Biology", "E": "Honors Spanish 2"]
let rBlocks2 = ["B": "Honors Biology", "A": "World Religions", "F": "Honors Pre-Calculus BC", "D": "Introduction to Literature", "Z": "Pre-Modern History", "E": "Honors Spanish 2"]
let rBlocks3 = ["A": "World Religions", "D": "Introduction to Literature", "C": "Concert Choir", "B": "Honors Biology", "F": "Honors Pre-Calculus BC", "Z": "Pre-Modern History", "E": "Honors Spanish 2"]
let rBlocks4 = ["B": "Honors Biology", "A": "World Religions", "F": "Honors Pre-Calculus BC", "D": "Introduction to Literature", "Z": "Pre-Modern History", "E": "Honors Spanish 2"]
let rBlocks5 = ["B": "Honors Biology", "A": "World Religions", "F": "Honors Pre-Calculus BC", "C": "Concert Choir", "Z": "Pre-Modern History", "D": "Introduction to Literature"]
let rBlocks6 = ["B": "Honors Biology", "A": "World Religions", "D": "Introduction to Literature", "Z": "Pre-Modern History", "E": "Honors Spanish 2"]
let rBlocks7 = ["B": "Honors Biology", "F": "Honors Pre-Calculus BC", "D": "Introduction to Literature", "C": "Concert Choir", "Z": "Honors Biology", "E": "Honors Spanish 2"]
let rBlocks8 = ["B": "Honors Biology", "A": "World Religions", "F": "Honors Pre-Calculus BC", "D": "Introduction to Literature", "Z": "Pre-Modern History", "E": "Honors Spanish 2"]

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

//ONLY RUN IF ONLINE AND HAS SCHOOL
//FIRST TIME
learn(rBlocks1)
learnt
confidence
altBlocks

//SECOND TIME
learn(rBlocks2)
learnt
confidence
altBlocks

//THIRD TIME
learn(rBlocks3)
learnt
confidence
altBlocks

//FOURTH TIME
learn(rBlocks4)
learnt
confidence
altBlocks

//FIFTH TIME
learn(rBlocks5)
learnt
confidence
altBlocks

//SIXTH TIME
learn(rBlocks6)
learnt
confidence
altBlocks

//SEVENTH TIME
learn(rBlocks7)
learnt
confidence
altBlocks

//EIGTH TIME
learn(rBlocks8)
learnt
confidence
altBlocks
*/






