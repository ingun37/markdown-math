//
//  MyScriptSampleObserver.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/09/03.
//

import Foundation

struct TexError: LocalizedError {
    var errorDescription: String?
    var failureReason: String?
    init(err: Error) {
        do {
            if let m = try /\[IINKEditor import_:data:selection:error:\]::(.+$)/.firstMatch(in: err.localizedDescription) {
                failureReason = "Incorrect LaTex format"
                errorDescription = String(m.output.1)
            } else {
                failureReason = "Unknown"
                errorDescription = "Unknown Error"
            }
        } catch {
            failureReason = "Unknown"
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
