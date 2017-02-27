//
// Created by Chakkra CHAK on 27/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

struct DateTime {
    var dateTime:Date

    init(dateTime:String) {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"

        self.dateTime = dateFormatter.date(from: dateTime)!
    }
}