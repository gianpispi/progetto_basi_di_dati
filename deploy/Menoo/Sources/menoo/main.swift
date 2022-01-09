import Foundation
import PostgresClientKit
import ArgumentParser
import Rainbow

struct GlobalColorOption: ParsableArguments {
    @Flag(
        inversion: .prefixedNo,
        help: ArgumentHelp(
            "Determina se l'output deve essere colorato.",
            discussion: ""
        )
    )
    var color: Bool = true
}

struct Menoo: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Manage menoo database",
        shouldDisplay: true,
        subcommands: [Login.self, Setup.self, Query.self, Operations.self, Signout.self]
    )
    
    static func printError(error: Error) {
        switch error {
        case KeychainError.noData:
            print("C'è un errore nel recuperare le informazioni per il login. Per iniziare esegui il login tramite " + "$ menoo login".bold)
            
        case PostgresError.sqlError(notice: let notice):
            print("Errore: ".red.bold + (notice.message ?? "C'è un errore nella query SQL"))
            
        case is PostgresError:
            print(error)
            
        default:
            print(error.localizedDescription)
        }
    }
    
    static func printResultTable(cursor: Cursor, limit: Int = 0) {
        if cursor.columns == nil {
            print("Query eseguita con successo".green)
        } else {
            let res = cursor.map({ try? $0.get().columns.map({ try? $0.string() }) })
            TextTable.print(header: cursor.columns?.map({ $0.name }) ?? [], body: res, limit: limit)
        }
    }
    
    struct Login: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Login into the database",
            discussion: """
                        In order to execute operations in a database, the program needs to establish a connection with the database. Please insert the data (host, username, database, password) here.
                        
                        ESEMPIO:
                          menoo login host.example.com user password [-d databaseName]
                        """
        )
        
        @Argument(help: "The database host.")
        var host: String
        
        @Argument(help: "The username.")
        var username: String
        
        @Argument(help: "The password to login in the database.")
        var password: String
        
        @Option(name: [.customShort("d"), .long], help: "The database name. If nil it uses the username as database name.")
        var database: String?
        
        @OptionGroup
        var globalColor: GlobalColorOption
        
        func run() {
            Rainbow.enabled = Rainbow.enabled && globalColor.color
            
            do {
                let _ = try PostgresManager(host: host, database: database ?? username, user: username, credential: password)
                print("Il login è stato eseguito con successo. Ora puoi usare altri comandi come ad esempio " + "$ menoo setup".bold + " o " + "$ menoo query".bold + " Per visualizzare gli altri comandi disponibili, usa " + "$ menoo --help".bold)
            } catch {
                print("Error logging in. Please change parameters")
                Login.exit(withError: ExitCode.failure)
            }
        }
    }
    
    struct Query: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Esegui una query personalizzata.",
            discussion: """
                        ESEMPI:
                          menoo query "SELECT * FROM utente \
                        WHERE nome LIKE 'Giulio%'"
                        """
        )
        
        @Argument(help: "Query da eseguire")
        var query: String
        
        @OptionGroup
        var globalColor: GlobalColorOption
        
        @Option(name: .shortAndLong, help: "Lunghezza limite della colonna")
        var columnLenghtLimit: Int = 0
        
        func run() {
            Rainbow.enabled = Rainbow.enabled && globalColor.color
            
            print("Query:".yellow, query)
            
            do {
                let manager = try PostgresManager()
                let statement = try manager.prepareStatement(text: query)
                let cursor = try statement.execute(retrieveColumnMetadata: true)
                defer { cursor.close() }
                
                printResultTable(cursor: cursor, limit: columnLenghtLimit)
            } catch {
                printError(error: error)
                Query.exit(withError: ExitCode.failure)
            }
        }
    }

    struct Setup: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Crea tutte le relazioni e le entità necessarie per il database",
            discussion: "Crea tutte le relazioni e le entità necessarie e pensate per il database, e inserisce i dati di esempio."
        )

        @OptionGroup
        var globalColor: GlobalColorOption
        
        func run() {
            Rainbow.enabled = Rainbow.enabled && globalColor.color
            
            do {
                let manager = try PostgresManager()
                
                for query in queries {
                    print("Preparo ed eseguo", query.name.yellow)
                    let statement = try manager.prepareStatement(text: query.body)
                    try statement.execute()
                    statement.close()
                }
                
                print("Il database è stato impostato correttamente! Ora puoi utilizzare " + "$ menoo query".bold + " oppure " + "$ menoo operations".bold + " per eseguire le operazioni.")
            } catch {
                printError(error: error)
                Setup.exit(withError: ExitCode.failure)
            }
        }
    }
    
    struct Operations: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Crea tutte le relazioni e le entità necessarie per il database",
            discussion: """
                        Crea tutte le relazioni e le entità necessarie e pensate per il database, e inserisce i dati di esempio.
                        
                        ESEMPI:
                          menoo operations ristorantiInZona "Trento"
                          menoo operations allergeniDiUtente "id_utente"
                        """
        )
        
        @Flag(
            name: .shortAndLong,
            help: ArgumentHelp(
                "Visualizza la lista di operazioni preimpostate disponibili, e annesse variabili.",
                discussion: ""
            )
        )
        var list: Bool = false
        
        @Argument(help: "Il nome della query da eseguire. Per trovare i nomi, eseguire \("$ menoo operations -l".bold)")
        var queryName: String = ""
        
        @Argument(help: "Argomenti per eseguire la query, come ad esempio i dettagli di un piatto quando si vuole aggiungerne uno.")
        var arguments: [String] = []
        
        @Option(name: .shortAndLong, help: "Lunghezza limite della colonna")
        var columnLenghtLimit: Int = 0
        
        @OptionGroup
        var globalColor: GlobalColorOption
        
        func run() {
            Rainbow.enabled = Rainbow.enabled && globalColor.color
            
            guard !list else {
                // stampiamo la lista di possibili operazioni
                print("Le operazioni disponibili sono:".green.bold)
                
                for op in operationQueries {
                    print("\(op.name.bold):", (op.arguments ?? []).joined(separator: ", ").yellow)
                }
                
                return
            }
            
            guard let query = operationQueries.first(where: { $0.name == queryName }) else {
                print("Devi inserire almeno un argomento (nome della query, che può essere trovato tramite " + "$ menoo operations -l".bold + ") e relativi argomenti.")
                return
            }
            
            guard arguments.count == (query.arguments ?? []).count else {
                print("Il numero di argomenti non è corretto. Devono essere \((query.arguments ?? []).count), ovvero \((query.arguments ?? []).joined(separator: ", "))")
                return
            }
            
            do {
                let manager = try PostgresManager()
                
                let statement = try manager.prepareStatement(text: query.body)
                var arguments = arguments
                
                if query.name == "aggiungiPiatto" {
                    arguments.insert(UUID().uuidString, at: 0)
                }
                
                let cursor = try statement.execute(parameterValues: arguments, retrieveColumnMetadata: true)
                defer { statement.close() }
                
                printResultTable(cursor: cursor, limit: columnLenghtLimit)
            } catch {
                printError(error: error)
                Setup.exit(withError: ExitCode.failure)
            }
        }
    }
    
    struct Signout: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Elimina tutti i dati salvati durante il login"
        )
        
        @OptionGroup
        var globalColor: GlobalColorOption

        func run() {
            Rainbow.enabled = Rainbow.enabled && globalColor.color
            
            do {
                let manager = try PostgresManager()
                manager.removeFromKeychain()
                
                print("Il logout è stato eseguito correttamente.".green)
            } catch {
                print(error.localizedDescription.red)
                Signout.exit(withError: ExitCode.failure)
            }
        }
    }
}

// @main doesn't work yet because of https://bugs.swift.org/browse/SR-12683
Menoo.main()
