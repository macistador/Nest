//
//  Configuration.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 04/02/2017.
//
//

import Foundation

struct Configuration {
    var databaseType : DatabaseType = .none
    var apiType : ApiType = .none
    var adminInterface : Bool = false
    var logger : Logger = .none
}

enum Logger {
    case none
    case swifty
}

enum DatabaseType {
    case none
    case postgreSql
    case mongoDB
}

enum ApiType {
    case none
    case json
    case xml
    case protobuf
    case graphQL
}
