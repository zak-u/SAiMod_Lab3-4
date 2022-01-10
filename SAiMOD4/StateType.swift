//
//  StateType.swift
//  SAiMOD4
//
//  Created by Zakhary on 10/26/21.
//

import Foundation

enum StateType  {
    case state2000 
    case state1000
    case state2100
    case state1100
    case state0100
    case state1001
    case state2101
    case state1101
    case state1011
    case state2111
    case state1111
    case state0111
    case state0101
}


class Request {
    var time : Int = 0
    var tactIn : Int = 0
    var tactOut : Int = 0
}
protocol StateAction {
    
    func performAction(statistics: Statistics, pi1Current : Double, pi2Current : Double) -> StateType?
}

class State2000Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP2000()
        return StateType.state1000
    }
    
}

class State1000Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP1000()
        statistics.incSgenericSignal()
        
        statistics.array[1] = Request()
        
        return StateType.state2100
    }
}

class State2100Action: StateAction {

    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP2100()
        
        statistics.updateRequst()
        
        statistics.incLc()
        statistics.incKch1()
        if (pi1Current < statistics.pi1 ) {
            return StateType.state1100
        }
        if (pi1Current >= statistics.pi1) {
            
            statistics.array[3] = statistics.array[1]!
            statistics.array[1] = nil
            
            return StateType.state1001
        }
        else {
            return nil
        }
    }
    
}

class State1100Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP1100()
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
//        statistics.array[0] = Request()
        
        statistics.incLc()
        statistics.incKch1()
        if (pi1Current < statistics.pi1 ) {
            
            statistics.array[0] = Request()
            
            return StateType.state0100
        }
        if (pi1Current >= statistics.pi1) {
            
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = Request()
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
    
}

class State0100Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP0100()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 2)
        statistics.incKch1()
        statistics.incPbl()
        if (pi1Current < statistics.pi1 ) {
            return StateType.state0100
        }
        if (pi1Current >= statistics.pi1) {
            
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = statistics.array[0]
            statistics.array[0] = nil
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
}

class State1001Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP1001()
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incLc()
        statistics.incKch2()
        if (pi2Current < statistics.pi2 ) {
            
            statistics.array[1] = Request()
            return StateType.state2101
        }
        if (pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.array[1] = Request()
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state2100
        }
        else {
            return nil
        }
    }
    
}

class State2101Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP2101()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 2)
        statistics.incKch1()
        statistics.incKch2()
        if (pi1Current < statistics.pi1 && pi2Current < statistics.pi2) {
            return StateType.state1101
        }
        if (pi1Current < statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state1100
        }
        if (pi1Current >= statistics.pi1 && pi2Current < statistics.pi2) {
            
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = nil
            
            return StateType.state1011
        }
        if (pi1Current >= statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllOut +=  1

            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = nil
            
            return StateType.state1001
        }
        else {
            return nil
        }
    }
    
}
//this blok
class State1101Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incP1101()
        statistics.incLc(count: 2)
        statistics.incKch1()
        statistics.incKch2()
        if (pi1Current < statistics.pi1 && pi2Current < statistics.pi2) {
            statistics.array[0] = Request()
            return StateType.state0101
        }
        if (pi1Current < statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            statistics.array[0] = Request()
            
            statistics.AllOut +=  1
            
            return StateType.state0100
        }
        if (pi1Current >= statistics.pi1 && pi2Current < statistics.pi2) {
            
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = Request()
            
            return StateType.state2111
        }
        if (pi1Current >= statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = Request()
            
            statistics.AllOut +=  1
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
}

class State1011Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incP1011()
        statistics.incLc(count: 2)
        statistics.incLoch()
        statistics.incKch2()
        if (pi2Current < statistics.pi2 ) {
            
            statistics.array[1] = Request()
            
            return StateType.state2111
        }
        if (pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = nil
            statistics.array[1] = Request()
            
            statistics.AllOut +=  1
            
            return StateType.state2101
        }
        else {
            return nil
        }
        
        
    }
    
}

class State2111Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP2111()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 3)
        statistics.incKch1()
        statistics.incKch2()
        statistics.incLoch()
        if (pi1Current < statistics.pi1 && pi2Current < statistics.pi2) {
            return StateType.state1111
        }
        if (pi1Current < statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state1101
        }
        if (pi1Current >= statistics.pi1 && pi2Current < statistics.pi2) {
            statistics.incPotk()
            statistics.timeOut  += statistics.array[1]!.time
            statistics.array[1] = nil
            
            return StateType.state1011
        }
        if (pi1Current >= statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state1011
        }
        else {
            return nil
        }
    }
    
}

class State1111Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP1111()
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 3)
        statistics.incKch1()
        statistics.incKch2()
        statistics.incLoch()
        if (pi1Current < statistics.pi1 && pi2Current < statistics.pi2) {
            
            statistics.array[0] = Request()
            return StateType.state0111
        }
        if (pi1Current < statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = nil
            statistics.array[0] = Request()
            statistics.AllOut +=  1
            
            return StateType.state0101
        }
        if (pi1Current >= statistics.pi1 && pi2Current < statistics.pi2) {
            statistics.incPotk()
            statistics.timeOut  += statistics.array[1]!.time
            statistics.array[1] = Request()
            
            return StateType.state2111
        }
        if (pi1Current >= statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = statistics.array[1]
            statistics.array[1] =  Request()
            
            statistics.AllOut +=  1
            
            return StateType.state2111
        }
        else {
            return nil
        }
    }
}

class State0111Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP0111()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 4)
        statistics.incKch1()
        statistics.incKch2()
        statistics.incLoch()
        statistics.incPbl()
        if (pi1Current < statistics.pi1 && pi2Current < statistics.pi2) {
            return StateType.state0111
        }
        if (pi1Current < statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state0101
        }
        if (pi1Current >= statistics.pi1 && pi2Current < statistics.pi2) {
            statistics.incPotk()
            statistics.timeOut  += statistics.array[1]!.time
            
            statistics.array[1] = statistics.array[0]
            statistics.array[0] = nil
            
            return StateType.state2111
        }
        if (pi1Current >= statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = statistics.array[0]
            statistics.array[0] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state2111
        }
        else {
            return nil
        }
    }
    
}

class State0101Action: StateAction {
    func performAction(statistics: Statistics, pi1Current: Double, pi2Current: Double) -> StateType? {
        statistics.incP0101()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 3)
        statistics.incKch1()
        statistics.incKch2()
        statistics.incPbl()
        if (pi1Current < statistics.pi1 && pi2Current < statistics.pi2) {
            return StateType.state0101
        }
        if (pi1Current < statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state0100
        }
        if (pi1Current >= statistics.pi1 && pi2Current < statistics.pi2) {
            
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = statistics.array[0]
            statistics.array[0] = nil
            
            return StateType.state2111
        }
        if (pi1Current >= statistics.pi1 && pi2Current >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = statistics.array[0]
            statistics.array[0] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
    
}
