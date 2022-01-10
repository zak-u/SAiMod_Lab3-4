//
//  main.swift
//  SAiMOD4
//
//  Created by Zakhary on 10/21/21.
//

import Foundation

let N = 1000000
let A0 = 117
let M = 2094991
let R0 = 17
var Rn_1:Int = 0
var Rn: Int = 0
let g :Double = 10000000000
var state : StateType? = .state2000
var stateDictionary : [StateType : StateAction] = [.state2000 : State2000Action(),
                                                   .state1000 : State1000Action(),
                                                   .state2100 : State2100Action(),
                                                   .state1100 : State1100Action(),
                                                   .state0100 : State0100Action(),
                                                   .state1001 : State1001Action(),
                                                   .state2101 : State2101Action(),
                                                   .state1101 : State1101Action(),
                                                   .state1011 : State1011Action(),
                                                   .state2111 : State2111Action(),
                                                   .state1111 : State1111Action(),
                                                   .state0111 : State0111Action(),
                                                   .state0101 : State0101Action(),]

public  func getProbability() -> Double {
    Rn_1 = Rn
    Rn = (A0 * Rn_1) % M
    return Double( Rn) / Double(M)
}

print("Enter pi1:")
let pi1 : String = readLine()!
print("Enter pi2:")
let pi2 : String = readLine()!

var statistics = Statistics(pi1: Double(pi1)!, pi2: Double(pi2)!)
Rn = R0
for _ in 0...N {
    let currentPi1 = getProbability()
    let currentPi2 = getProbability()
    if state != nil {
        state = stateDictionary[state!]!.performAction(statistics: statistics, pi1Current: currentPi1, pi2Current: currentPi2 )
    }
    else{
        print("Error")
        break
    }
}
let results = statistics.getResults()

print("P2000 = \(statistics.P2000/Double(N))")
print("P1000 = \(statistics.P1000/Double(N))")
print("P2100 = \(statistics.P2100/Double(N))")
print("P1100 = \(statistics.P1100/Double(N))")
print("P0100 = \(statistics.P0100/Double(N))")
print("P1001 = \(statistics.P1001/Double(N))")
print("P2101 = \(statistics.P2101/Double(N))")
print("P1101 = \(statistics.P1101/Double(N))")
print("P1011 = \(statistics.P1011/Double(N))")
print("P2111 = \(statistics.P2111/Double(N))")
print("P1111 = \(statistics.P1111/Double(N))")
print("P0111 = \(statistics.P0111/Double(N))")
print("P0101 = \(statistics.P0101/Double(N))")

print("Potk = \(results.Potk)")
print("Q = \(1-results.Potk)")
print("Pbl = \(results.Pbl)")
print("Loch = \(results.Loch)")
print("Lc = \(results.Lc)")
print("A = \(results.A)")
print("Woch = \(results.Woch)")
print("Wc = \(Double(statistics.AllTime)/Double(statistics.AllOut))")

//print("Wc = \(results.Wc)")

let wc = 1/(1-Double(pi1)!)+results.Woch+(results.Kch2/results.A);


//print("Wc = \(wc)")
//print("Wc44 = \(statistics.A)")
//print("Wc44 = \(statistics.sgenericSignal)")
print("Kch1 = \(results.Kch1)")
print("Kch2 = \(results.Kch2)")

//print("A1 = \(statistics.A)")
//print("Out = \(statistics.AllOut)")
//print("Time = \(statistics.AllTime)")
//print("Wc1 = \(Double(statistics.AllTime)/Double(statistics.AllOut))")
//print("Wc44 = \(statistics.sgenericSignal)")
//print("Lc = \(statistics.Lc)")
//print("Wc2 = \(results.Lc/statistics.sgenericSignal)")
//print("Wc222 = \(Double(statistics.AllTime)/Double(statistics.sgenericSignal))")


