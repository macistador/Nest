import Vapor
import VaporPostgreSQL
import SwiftyBeaverVapor
import SwiftyBeaver
import Foundation


/*
 *
 *          ███╗   ██╗███████╗███████╗████████╗
 *          ████╗  ██║██╔════╝██╔════╝╚══██╔══╝
 *          ██╔██╗ ██║█████╗  ███████╗   ██║
 *          ██║╚██╗██║██╔══╝  ╚════██║   ██║
 *          ██║ ╚████║███████╗███████║   ██║
 *          ╚═╝  ╚═══╝╚══════╝╚══════╝   ╚═╝
 *
 *          Nest . Swift . Mobile . Backend
 *
 *
 */


//
// MARK: APP START
//

let drop = Droplet()


// Configuration
let configuration = Configuration(databaseType: .postgreSql,
                                  apiType: .json,
                                  adminInterface: true,
                                  logger: .swifty)

NestConfigurator.apply(with: configuration, drop: drop)
let log = NestConfigurator.logger

log?.info("App is starting...")

//
// MARK: RUN
//

drop.run()

//log?.info("Ready.")
