//
//  AdminController.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 12/11/2016.
//
//

import Vapor
import HTTP
import VaporPostgreSQL

final class BasicController {

  func addRoutes(drop: Droplet) {

  }

}


//
// MARK: - Temporary Routing configuration
//

//// Displaying a simple string => No real-use cases
//drop.get { req in
//    log.info("Root is accessed")
//    return "hello 4"
//}
//
//// Displaying a JSON => API requests
//drop.get("json") { req in
//    return try JSON(node: ["message":"mon message"])
//}
//
//// Displaying a templated page => website
//drop.get("welcome") { req in
//        return try drop.view.make("welcome", [
//        	"message": drop.localization[req.lang, "welcome", "title"]
//        ])
//}
//
//// Displaying depending on a GET parameter
//drop.get("parameters", Int.self) { request, parameter in
//    return try JSON(node: ["Parameter received: ": String(parameter)])
//}
//
//// Displaying depending on a POST parameter
//drop.post("post") { request in
//    guard let name = request.data["name"]?.string else {throw Abort.badRequest}
//    return try JSON(node: ["Post parameter received: ":"This one > \(name)"])
//}
