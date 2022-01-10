//
//  Statistics.swift
//  SAiMOD4
//
//  Created by Zakhary on 10/26/21.
//

import Foundation

class Statistics {
    let N : Double = 1000000
    
    var P2000 : Double = 0
    var P1000 : Double = 0
    var P2100 : Double = 0
    var P1100 : Double = 0
    var P0100 : Double = 0
    var P1001 : Double = 0
    var P2101 : Double = 0
    var P1101 : Double = 0
    var P1011 : Double = 0
    var P2111 : Double = 0
    var P1111 : Double = 0
    var P0111 : Double = 0
    var P0101 : Double = 0
    
    var sgenericSignal : Double = 0
    let pi1 : Double
    let pi2 : Double 
    var Potk : Double = 0
    var Pbl : Double = 0
    var Loch : Double = 0
    var Lc : Double = 0
    var A : Double = 0
    var Kch1 : Double = 0
    var Kch2 : Double = 0
    var Woch : Double = 0
    var Wc : Double = 0
    var Ttaktov : Double = 0
    var AllTime : Int = 0
    var AllOut : Int = 0
    var array : [Request?] = [nil,nil,nil,nil]
    var tactOutSum : Double = 0
    var timeOut : Int = 0
    
    public func updateRequst() {
        for req in array {
            if req != nil {
                req?.time += 1
            }
        }
    }

    init(pi1: Double, pi2 : Double) {
        self.pi1 = pi1
        self.pi2 = pi2
    }
    
    
    public func incSgenericSignal(){
        sgenericSignal += 1
    }
    
    public func incPotk(){
        Potk += 1
    }
    
    public func incPbl(){
        Pbl += 1
    }
    
    public func incLoch(){
        Loch += 1
    }
    
    public func incLc(count : Int = 1){
        Lc += Double(count)
    }
    
    public func incA(){
        A += 1
    }
    
    public func incKch1(){
        Kch1 += 1
    }
    
    public func incKch2(){
        Kch2 += 1
    }
    
    //state
    
    public func incP2000(){
        P2000 += 1
    }
    
    public func incP1000(){
        P1000 += 1
    }
    
    public func incP2100(){
        P2100 += 1
    }
    
    public func incP1100(){
        P1100 += 1
    }
    
    public func incP0100(){
        P0100 += 1
    }
    
    public func incP1001(){
        P1001 += 1
    }
    
    public func incP2101(){
        P2101 += 1
    }
    
    public func incP1101(){
        P1101 += 1
    }
    
    public func incP1011(){
        P1011 += 1
    }
    
    public func incP2111(){
        P2111 += 1
    }
    
    public func incP1111(){
        P1111 += 1
    }
    
    public func incP0111(){
        P0111 += 1
    }
    
    public func incP0101(){
        P0101 += 1
    }
    
    public func getResults() -> (Potk : Double,
                                 Pbl : Double,
                                 Loch : Double,
                                 Lc : Double,
                                 A : Double,
                                 Kch1 : Double,
                                 Kch2 : Double,
                                 Woch : Double,
                                 Wc : Double){
        return ( Potk: Potk/sgenericSignal, Pbl: Pbl/N, Loch : Loch/N,Lc: Lc/N, A:A/N,Kch1 : Kch1 / N, Kch2: Kch2 / N, Woch: Loch/A, Wc : Lc / sgenericSignal )
    }
    

}
