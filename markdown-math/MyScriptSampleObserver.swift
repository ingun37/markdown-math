//
//  MyScriptSampleObserver.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/09/03.
//

import Foundation

struct TexError: LocalizedError {
    var errorDescription: String?
    init(err: Error) {
        do {
            if let m = try /import failed :(.+$)/.firstMatch(in: err.localizedDescription) {
                errorDescription = String(m.output.1)
            } else {
                errorDescription = "Unknown Error"
            }
        } catch {
            errorDescription = "Unknown Error"
        }

    }
}
protocol MyScriptSampleObserverDelegate {
    func cancel()
    func done(tex: String)
    func alert(err: Error)
}
class MyScriptSampleObserver {
    public var latex: String?
    private static var sharedNetworkManager: MyScriptSampleObserver = {
        let networkManager = MyScriptSampleObserver()

        // Configuration
        // ...

        return networkManager
    }()

    // MARK: -

    var delegate: MyScriptSampleObserverDelegate?
    // Initialization

    // MARK: - Accessors

    class func shared() -> MyScriptSampleObserver {
        return sharedNetworkManager
    }
}
