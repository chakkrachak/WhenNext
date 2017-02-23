//
// Created by Chakkra CHAK on 23/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

class StopSchedulesBuilder {
    var coverage:String
    var token:String
    var coords:String?

    init(token:String, coverage: String) {
        self.token = token
        self.coverage = coverage
    }

    func withCoords(_ coords: String) -> StopSchedulesBuilder {
        self.coords = coords
        return self
    }

    func build() -> [StopSchedule] {
        return [
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 1")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 2")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 3")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 4")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 5"))
        ]
    }
}