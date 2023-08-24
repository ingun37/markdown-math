//
//  MyScript.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/08/23.
//

import SwiftUI

struct MyScript: UIViewControllerRepresentable {
    func makeCoordinator() -> Con {
        Con()
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        FileManager.default.createIinkDirectory()
        // create the main navigation controller to be used for our app
        let navController = UINavigationController()
        let engine = EngineProvider.sharedInstance.engine
        try? engine?.configuration.set(boolean: false, forKey: "math.solver.enable")
        // send that into our coordinator so that it can display view controllers
        context.coordinator.coordinator = MainCoordinator(navigationController: navController, engine: engine)
        // tell the coordinator to take over control
        context.coordinator.coordinator?.start()
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    
    typealias UIViewControllerType = UINavigationController
    
}

class Con {
    var coordinator: MainCoordinator?
}
// struct Canvas_Previews: PreviewProvider {
//    static var previews: some View {
//        Canvas()
//    }
// }

