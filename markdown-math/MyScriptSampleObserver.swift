//
//  MyScriptSampleObserver.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/09/03.
//

import Foundation
protocol MyScriptSampleObserverDelegate {
    func cancel()
    func done(tex:String)
}
class MyScriptSampleObserver {
    
    private static var sharedNetworkManager: MyScriptSampleObserver = {
        let networkManager = MyScriptSampleObserver()

        // Configuration
        // ...

        return networkManager
    }()

    // MARK: -

    
    var delegate:MyScriptSampleObserverDelegate?
    // Initialization


    // MARK: - Accessors

    class func shared() -> MyScriptSampleObserver {
        return sharedNetworkManager
    }
}

