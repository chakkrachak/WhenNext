//
// Created by Chakkra CHAK on 27/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

extension TimeInterval {
    func inFutureSmartDisplay() -> (length: String, unit: String) {
        var outputLength:String = "0"
        var outputUnit = "minute"

        let realLengthInMinutes:Double = (self/60).rounded()
        if (realLengthInMinutes > 0) {
            outputLength = Int(realLengthInMinutes).description
            outputUnit = "minutes"
        }
        if (realLengthInMinutes > 120) {
            let realLengthInHours:Double = (realLengthInMinutes/60).rounded()
            outputLength = Int(realLengthInHours).description
            outputUnit = "hours"
        }

        print(realLengthInMinutes, outputLength, outputUnit)
        return (outputLength, outputUnit)
    }
}