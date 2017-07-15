//
//  DaySchedule.swift
//  EA_Schedule
//
//  Created by Saxena, Sameer on 1/11/17.
//  Copyright © 2017 Praneeth Alla. All rights reserved.
//

import Foundation

enum Day {
    case day1
    case day2
    case day3
    case day4
    case day5
    case day6
    case day7
    case day8
    case day9
    case day10
    case day11
    case day12
}

struct DaySchedule {
    
    var day : Day
    var schedule : [String]
    var times: [String]
    var nameOfDay : String
    var upperSchool : Bool
    
    init(day: Day, upperSchool: Bool) {
        
        self.day = day
        self.upperSchool = upperSchool
        var tempschedule: [String] = []
        var tempSchedUS: [String] = []
        
        switch day {
            case .day1:
                tempschedule = ["A", "F", "Office Hours", "E", "Z", "Lunch", "B", "D", "C"]
                tempSchedUS = ["A", "F", "Chapel", "E", "Z", "B", "Lunch", "D", "C"]
                nameOfDay = "Day 1"
            case .day2:
                tempschedule = ["B", "A", "Chapel", "F", "Z", "Lunch", "C", "E", "D"]
                tempSchedUS = ["B", "A", "Advisory", "F", "Z", "C", "Lunch", "E", "D"]
                nameOfDay = "Day 2"
            case .day3:
                tempschedule = ["C", "B", "Advisory", "A", "Z", "Lunch", "D", "F", "E"]
                tempSchedUS = ["C", "B", "Chapel", "A", "Z", "D", "Lunch", "F", "E"]
                nameOfDay = "Day 3"
            case .day4:
                tempschedule = ["D", "C", "Chapel", "B", "Z", "Lunch", "E", "A", "F"]
                tempSchedUS = ["D", "C", "Activity", "B", "Z", "E", "Lunch", "A", "F"]
                nameOfDay = "Day 4"
            case .day5:
                tempschedule = ["E", "D", "Office Hours", "C", "Z", "Lunch", "F", "B", "A"]
                tempSchedUS = ["E", "D", "Chapel", "C", "Z", "F", "Lunch", "B", "A"]
                nameOfDay = "Day 5"
            case .day6:
                tempschedule = ["F", "E", "Chapel", "A", "Z", "Lunch", "D", "C", "B"]
                tempSchedUS = ["F", "E", "SCI Labs Break", "A", "Z", "D", "Lunch", "C", "B"]
                nameOfDay = "Day 4"
            case .day7:
                tempschedule = ["A", "F", "Office Hours", "E", "Z", "Lunch", "B", "D", "C"]
                tempSchedUS = ["A", "F", "Chapel", "E", "Z", "B", "Lunch", "D", "C"]
                nameOfDay = "Day 7"
            case .day8:
                tempschedule = ["B", "A", "Chapel", "F", "Z", "Lunch", "C", "E", "D"]
                tempSchedUS = ["B", "A", "Activity", "F", "Z", "C", "Lunch", "E", "D"]
                nameOfDay = "Day 8"
            case .day9:
                tempschedule = ["C", "B", "Advisory", "A", "Z", "Lunch", "D", "F", "E"]
                tempSchedUS = ["C", "B", "Chapel", "A", "Z", "D", "Lunch", "F", "E"]
                nameOfDay = "Day 9"
            case .day10:
                tempschedule = ["D", "C", "Chapel", "B", "Z", "Lunch", "E", "A", "F"]
                tempSchedUS = ["D", "C", "Activity", "B", "Z", "E", "Lunch", "A", "F"]
                nameOfDay = "Day 10"
            case .day11:
                tempschedule = ["E", "D", "Office Hours", "C", "Z", "Lunch", "F", "B", "A"]
                tempSchedUS = ["E", "D", "Chapel", "C", "Z", "F", "Lunch", "B", "A"]
                nameOfDay = "Day 11"
            case .day12:
                tempschedule = ["A", "F", "Chapel", "B", "Z", "Lunch", "D", "C", "E"]
                tempSchedUS = ["A", "F", "SCI Labs Break", "B", "Z", "D", "Lunch", "C", "E"]
                nameOfDay = "Day 12"
        }
        
        if upperSchool {
            times = ["8:10", "8:55", "9:40", "10:15", "11:05", "11:55", "12:45", "1:15", "2:05"]
            schedule = tempSchedUS
        } else {
            times = ["8:10", "8:55", "9:50", "10:25", "11:10", "11:55", "12:35", "1:20", "2:00"]
            schedule = tempschedule
        }
        
    }
    
}














