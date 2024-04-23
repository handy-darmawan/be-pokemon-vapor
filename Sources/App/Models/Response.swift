//
//  Response.swift
//
//
//  Created by ndyyy on 23/04/24.
//

import Vapor

struct BooleanResponse: Content {
    var message: Bool
}

struct IntegerResponse: Content {
    var message: Int
}

struct StringResponse: Content {
    var message: String
}
