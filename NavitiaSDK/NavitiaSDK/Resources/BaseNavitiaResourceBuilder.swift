//
// Created by Chakkra CHAK on 01/03/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

public class BaseNavitiaResourceBuilder {
    public var coverage:String
    public var token:String

    public init(token:String, coverage: String) {
        self.token = token
        self.coverage = coverage
    }
}
