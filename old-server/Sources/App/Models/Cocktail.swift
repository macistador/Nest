//
//  User.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 20/01/2017.
//
//

import Vapor
import Fluent
import Foundation

final class Cocktail: Model {
    var id: Node?
    var exists: Bool = false

    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.id = UUID().uuidString.makeNode()
        self.name = name
        self.description = description
    }

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        description = try node.extract("description")
    }

    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "description": description
        ])
    }
}

extension Cocktail {
    /**
        This will automatically fetch from database, using example here to load
        automatically for example. Remove on real models.
    */
    public convenience init?(from string: String) throws {
        self.init(name: string, description: string)
    }
}

extension Cocktail: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("cocktails", closure: { cocktails in
            cocktails.id()
            cocktails.string("name")
            cocktails.string("description")
        })
    }

    static func revert(_ database: Database) throws {
        try database.delete("cocktails")
    }
}
