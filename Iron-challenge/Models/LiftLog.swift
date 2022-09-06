//
//  Log.swift
//  Iron-challenge
//
//  Created by Ludovico Veniani on 9/5/22.
//

import Foundation


struct LiftLog: Cacheable {
    var name: String
    var sets: [LoggedSet]
    var date: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.date)
        
    }
    func prepareForCache() {
        
    }
    static func == (lhs: LiftLog, rhs: LiftLog) -> Bool {
        return (lhs.date == rhs.date) && (lhs.name == rhs.name)
    }
    
}


class LoggedSet: Cacheable {
    var reps: Int?
    var lbs: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.reps)
        hasher.combine(self.lbs)
        
    }
    func prepareForCache() {
        
    }
    static func == (lhs: LoggedSet, rhs: LoggedSet) -> Bool {
        return (lhs.reps == rhs.reps) && (lhs.lbs == rhs.lbs)
    }
    init(reps: Int?, lbs: Int?) {
        self.reps = reps
        self.lbs = lbs
    }
}
