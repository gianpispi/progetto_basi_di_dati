//
//  PostgresManager.swift
//  
//
//  Created by Gianpiero Spinelli on 08/01/22.
//

import Foundation
import PostgresClientKit

enum KeychainError: Error {
    case noData
}

class PostgresManager: NSObject {
    private static let appName = "Progetto 23 - Menoo - Spinelli"
    
    private var connection: Connection!
    private let keychain = Keychain(service: "com.gianpispi.menoo")
    
    private let overwritePassword: Bool
    
    public init(host: String, database: String, user: String, credential: String) throws {
        overwritePassword = true
        
        super.init()
        
        var configuration = ConnectionConfiguration()
        configuration.host = host
        configuration.database = database
        configuration.user = user
        configuration.credential = .cleartextPassword(password: credential)
        
        configuration.applicationName = PostgresManager.appName
        
        connection = try login(configuration: configuration, password: credential)
    }
    
    public init(_ a: String = "") throws {
        overwritePassword = false
        
        super.init()
        
        let config = try retrieveUserFromKeychain()
        
        var configuration = ConnectionConfiguration()
        configuration.host = config.host
        configuration.database = config.database
        configuration.user = config.user
        configuration.credential = .cleartextPassword(password: config.password)
        
        configuration.applicationName = PostgresManager.appName
        
        connection = try login(configuration: configuration, password: config.password)
    }
    
    private func login(configuration: ConnectionConfiguration, password: String) throws -> Connection {
        do {
            Postgres.logger.level = .off
            let connection = try Connection(configuration: configuration)
            
            if overwritePassword {
                try? saveUserToKeychain(username: configuration.user, password: password, host: configuration.host, databaseName: configuration.database)
            }
            
            return connection
        } catch {
            switch error {
            case PostgresError.cleartextPasswordCredentialRequired:
                var config = configuration
                config.credential = .cleartextPassword(password: password)
                return try login(configuration: config, password: password)
                
            case PostgresError.md5PasswordCredentialRequired:
                var config = configuration
                config.credential = .md5Password(password: password)
                return try login(configuration: config, password: password)
                
            case PostgresError.trustCredentialRequired:
                var config = configuration
                config.credential = .trust
                return try login(configuration: config, password: password)
                
            case PostgresError.scramSHA256CredentialRequired:
                var config = configuration
                config.credential = .scramSHA256(password: password)
                return try login(configuration: config, password: password)
                
            default:
                throw error
            }
        }
    }
    
    private func saveUserToKeychain(username: String, password: String, host: String, databaseName: String) throws {
        keychain["password"] = password
        
        UserDefaults.standard.set(username, forKey: "user")
        UserDefaults.standard.set(host, forKey: "host")
        UserDefaults.standard.set(databaseName, forKey: "database")
    }
    
    public func removeFromKeychain() {
        keychain["password"] = nil
        
        UserDefaults.standard.set(nil, forKey: "user")
        UserDefaults.standard.set(nil, forKey: "database")
        UserDefaults.standard.set(nil, forKey: "host")
    }
    
    private func retrieveUserFromKeychain() throws -> (user: String, password: String, database: String, host: String) {
        
        guard let password = keychain[string: "password"],
              let user = UserDefaults.standard.string(forKey: "user"),
              let database = UserDefaults.standard.string(forKey: "database"),
              let host = UserDefaults.standard.string(forKey: "host")
        else {
            throw KeychainError.noData
        }
        
        return (user, password, database, host)
    }
    
    public func close() {
        connection.close()
    }
    
    public func prepareStatement(text: String) throws -> Statement {
        try connection.prepareStatement(text: text)
    }
}
