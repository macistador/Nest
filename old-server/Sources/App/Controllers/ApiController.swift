//
//  ApiController.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 04/12/2016.
//
//

import Foundation

import Vapor
import HTTP
import VaporPostgreSQL

final class ApiController {
    
    func addRoutes(drop: Droplet) {
        let basic = drop.grouped("api")
        basic.get("version", handler: version)
        basic.get("model", handler: model)
        basic.get("test", handler: test)
        basic.post("new", handler: new)
        basic.get("all", handler: all)
        basic.get("first", handler: first)
        basic.get("afks", handler: afks)
        basic.get("not-afks", handler: notAfks)
        basic.get("update", handler: update)
        basic.get("delete-afks", handler: deleteAfks)
    }
    
    func version(request: Request) throws -> ResponseRepresentable {
    if let db = drop.database?.driver as? PostgreSQLDriver {
      let version = try db.raw("SELECT version()")
      return try JSON(node: version)
    } else {
      return "No db connection"
    }
  }
  
  func model(request: Request) throws -> ResponseRepresentable {
    let cocktail = Cocktail(name: "AFK", description: "Away From Keyboard")
    return try cocktail.makeJSON()
  }
  
  func test(request: Request) throws -> ResponseRepresentable {
    var cocktail = Cocktail(name: "AFK", description: "Away From Keyboard")
    try cocktail.save()
    return try JSON(node: Cocktail.all().makeNode())
  }

  func new(request: Request) throws -> ResponseRepresentable {
    var cocktail = try Cocktail(node: request.json)
    try cocktail.save()
    return cocktail
  }

  func all(request: Request) throws -> ResponseRepresentable {
    return try JSON(node: Cocktail.all().makeNode())
  }

  func first(request: Request) throws -> ResponseRepresentable {
    return try JSON(node: Cocktail.query().first()?.makeNode())
  }

  func afks(request: Request) throws -> ResponseRepresentable {
    return try JSON(node: Cocktail.query().filter("name", "AFK").all().makeNode())
  }

  func notAfks(request: Request) throws -> ResponseRepresentable {
    return try JSON(node: Cocktail.query().filter("name", .notEquals, "AFK").all().makeNode())
  }

  func update(request: Request) throws -> ResponseRepresentable {
    guard var first = try Cocktail.query().first(),
      let description = request.data["description"]?.string else { throw Abort.badRequest }
    first.description = description
    try first.save()
    return first

  }

  func deleteAfks(request: Request) throws -> ResponseRepresentable {
    let query = try Cocktail.query().filter("name", "AFK")
    try query.delete()
    return try JSON(node: Cocktail.all().makeNode())
  }

}
