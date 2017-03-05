//
// Created by Chakkra CHAK on 27/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

extension String {
    func dateFromNativiaFormat() -> Date? {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"

        return dateFormatter.date(from: self)!
    }
}

public struct DateTime {
    public var dateTime:Date
}
