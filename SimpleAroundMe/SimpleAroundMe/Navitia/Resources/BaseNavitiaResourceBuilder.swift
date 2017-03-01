//
// Created by Chakkra CHAK on 01/03/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

class BaseNavitiaResourceBuilder {
    var coverage:String
    var token:String

    init(token:String, coverage: String) {
        self.token = token
        self.coverage = coverage
    }
}
