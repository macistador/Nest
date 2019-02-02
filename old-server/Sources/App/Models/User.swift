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
import Turnstile
import TurnstileCrypto


// Model > Birdy ? 

final class User: Model {
    var id: Node?
    var exists: Bool = false

    var nickname: String
    var name: String
    var email: String
    var password: String
    
    init(nickname: String, name: String, email: String, rawPassword: String) {
        self.id = UUID().uuidString.makeNode()
        self.nickname = nickname
        self.name = name
        self.email = email
        self.password = BCrypt.hash(password: rawPassword)
    }

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        nickname = try node.extract("nickname")
        name = try node.extract("name")
        email = try node.extract("email")
        password = try node.extract("password")
    }

    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "nickname": nickname,
            "name": name,
            "email": email,
            "password": password
        ])
    }
}

extension User {
    /**
        This will automatically fetch from database, using example here to load
        automatically for example. Remove on real models.
    */
    public convenience init?(from string: String) throws {
        self.init(nickname: string, name: string, email: string, rawPassword: string)
    }
}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        //
    }

    static func revert(_ database: Database) throws {
        try database.delete("users")
    }
    
    static func register(nickname: String, name: String, email: String, rawPassword: String) throws -> User {
        var newUser = User(nickname: nickname, name: name, email: email, rawPassword: rawPassword)
        if try User.query().filter("email", newUser.email).first() == nil { //.value
            try newUser.save()
            return newUser
        }
        else {
            throw AccountTakenError()
        }
    }
    
}

