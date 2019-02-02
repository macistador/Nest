//
//  NestConfigurator.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 04/02/2017.
//
//

import Foundation
import Vapor
import VaporPostgreSQL
import SwiftyBeaverVapor
import SwiftyBeaver

class NestConfigurator {
    
    static var logger : LogProtocol?
    
    
    static func apply(with configuration: Configuration, drop: Droplet) {

        // Database
        if case .postgreSql = configuration.databaseType {
            configureDatabase(with: configuration, drop: drop)
        }
        
        // Basin routing
        let basic = BasicController()
        basic.addRoutes(drop: drop)
        
        // Admin
        if configuration.adminInterface == true {
            configureAdmin(with: configuration, drop: drop)
        }
        
        // Api
        if case .json = configuration.apiType {
            configureApi(with: configuration, drop: drop)
        }
        
        
        // Logger
        if case .swifty = configuration.logger {
            configureLogger(with: drop)
        }
    }
    
    
    //
    // MARK: BDD
    //
    static func configureDatabase(with configuration: Configuration, drop: Droplet) {
        do {
            try drop.addProvider(VaporPostgreSQL.Provider)
            try drop.addProvider(VaporPostgreSQL.Provider)
            drop.preparations += Cocktail.self
            
            let cocktails = CocktailsController()
            drop.resource("cocktails", cocktails)
            
            (drop.view as? LeafRenderer)?.stem.cache = nil
        } catch {}
        
    }
    
    
    //
    // MARK: ADMIN
    //
    static func configureAdmin(with configuration: Configuration, drop: Droplet) {
        let adminController = AdminController()
        adminController.addRoutes(drop: drop)
    }
    
    
    //
    // MARK: API
    //
    static func configureApi(with configuration: Configuration, drop: Droplet) {
        let apiController = ApiController()
        apiController.addRoutes(drop: drop)
    }
    
    
    //
    // MARK: LOGGER
    // SwiftyBeaver
    static func configureLogger(with drop: Droplet){
        let appId = "B1QJJa"
        let appSecret = "9smelayqqdrgnoCmzxgoxkycbyjaHRkc"
        let encryptionKey = "rm1yc4glum1zesnpuyi9afufmqccwhqt"
        
        // set-up SwiftyBeaver logging destinations (console, file, cloud, ...)
        // learn more at http://bit.ly/2ci4mMX
        let console = ConsoleDestination()  // log to Xcode Console in color
        let file = FileDestination()  // log to file in color
        file.logFileURL = URL(fileURLWithPath: "/tmp/VaporLogs.log") // set log file
        let platform = SBPlatformDestination(appID: appId, appSecret: appSecret, encryptionKey: encryptionKey)
        let sbProvider = SwiftyBeaverProvider(destinations: [console, file, platform])
        
        drop.addProvider(sbProvider)
        
        // shortcut to avoid writing app.log all the time
        logger = drop.log.self
    }
    
    
}
