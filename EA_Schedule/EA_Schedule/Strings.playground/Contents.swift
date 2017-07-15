//: Playground - noun: a place where people can play

import UIKit
/*
var str = "Hello, playground"
let com = ","
var hello = str.componentsSeparatedByString(",")[0]

let username = "saxes20"
let lastTwo = String(username.characters.suffix(2))

let courses = [["location": "Room: U116", "time": "11:55:00", "courseName": "Honors Algebra 2, B Hon Alg2, US Block B", "courseVersion": "B Hon Alg2 - McLauchlan; Period US - B; Room U116"], ["location": "Room: U305", "time": "10:15:00", "courseName": "Honors Spanish 2, E H Span2, US Block E", "courseVersion": "E H Span2 - Yaros; Period US - E; Room U305"], ["location": "Room: S202 Hon Bio", "time": "08:55:00", "courseName": "Honors Biology, F H Bio, US Block F", "courseVersion": "F H Bio - Shapiro; Period US - F; Room S202 Hon Bio"], ["location": "Room: U103", "time": "11:05:00", "courseName": "Introduction to Literature, Z-F IntroLit, US Block Z", "courseVersion": "Z-F IntroLit - Parsons; Period US - Z; Room U103"], ["location": "Room: U203 Playroom", "time": "08:10:00", "courseName": "AP Computer Sci Princ, A-APCompSciPrinc, US Block A", "courseVersion": "A-APCompSciPrinc - Memmo; Period US - A; Room U203 Playroom"], ["location": "Room: C120 Music Band Rm", "time": "14:05:00", "courseName": "CJazz Ensemble, CJazz Ensemble, US Block C", "courseVersion": "CJazz Ensemble - Dankanich; Period US - C; Room C120 Music Band Rm"], ["location": "Room: U319", "time": "08:00:00", "courseName": "USHomeroom, USHR37, Homeroom", "courseVersion": "USHR37 - Yaros; Period HR; Room U319"]]


let courseVersion = String(courses[6]["courseVersion"]!)
let seperate0 = courseVersion.componentsSeparatedByString(";")[0]
let seperate = seperate0.componentsSeparatedByString(" - ")
seperate.last
*/

var str = "s      ax es 20"
print(str)
let replaced = str.replacingOccurrences(of: " ", with: "")
print(replaced)


let dayKey = "DAY 10"
let datesArray = ["03-07-2017", "03-08-2017", "03-09-2017", "03-10-2017", "03-13-2017", "03-14-2017", "03-15-2017", "03-16-2017", "03-17-2017", "03-20-2017", "03-21-2017", "03-22-2017"]
let number = String(describing: dayKey.components(separatedBy: " ")[1])
let index = Int(number)! - 1
print(datesArray[index])
