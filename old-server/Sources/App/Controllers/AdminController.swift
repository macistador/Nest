//
//  AdminController.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 04/12/2016.
//
//

import Foundation

import Vapor
import HTTP
import VaporPostgreSQL

final class AdminController {
    
    func addRoutes(drop: Droplet) {
        let admin = drop.grouped("admin")
        admin.get("", handler: login)
//        admin.get("", handler: home)
        admin.get("list", handler: list)
    }
    
    func login(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("login", [
            "message": drop.localization[request.lang, "welcome", "title"]
            ])
    }
    
    func home(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("home", [
            "message": drop.localization[request.lang, "welcome", "title"]
            ])
    }
    
    func list(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("welcome", [
            "message": drop.localization[request.lang, "welcome", "title"]
            ])
    }
}
