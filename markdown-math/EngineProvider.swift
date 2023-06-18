// Copyright @ MyScript. All rights reserved.

import Foundation

/// The EngineProvider is used to manage the creation and the exposition of the Engine to the rest of the classes. It's important to use the same instance during all the application life cycle (hence the Singleton).
enum EngineError: Error {
    case CFile
    case InvalidCert
    case RecognitionAsset(String)
    case TempDirectory(String)
    case Config
}

enum EngineProvider {
    static func make() throws -> IINKEngine {
        if myCertificate.length == 0 {
            throw EngineError.CFile
        }

        // Create the iink runtime environment
        let data = Data(bytes: myCertificate.bytes, count: myCertificate.length)
        guard let engine = IINKEngine(certificate: data) else {
            throw EngineError.InvalidCert
        }

        // Configure the iink runtime environment
        let configurationPath = Bundle.main.bundlePath.appending("/recognition-assets/conf")
        do {
            try engine.configuration.set(stringArray: [configurationPath],
                                         forKey: "configuration-manager.search-path") // Tells the engine where to load the recognition assets from.
        } catch {
            throw EngineError.RecognitionAsset(error.localizedDescription)
        }

        // Set the temporary directory
        do {
            try engine.configuration.set(string: NSTemporaryDirectory(),
                                         forKey: "content-package.temp-folder")
        } catch {
            throw EngineError.TempDirectory(error.localizedDescription)
        }
        
        do {
            try engine.configuration.set(boolean: false, forKey: "math.solver.enable")
        } catch {
            throw EngineError.Config
        }

        return engine
    }
}
