//
//  MyScript.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/08/23.
//

import SwiftUI

struct MyScript: UIViewControllerRepresentable {
    let delegate: MyScriptSampleObserverDelegate
    let latex: String?
    @Binding var err: TexError?
    func makeCoordinator() -> Con {
        Con()
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        if let latex = self.latex, 0 < latex.count {
            MyScriptSampleObserver.shared().latex = latex
        } else {
            MyScriptSampleObserver.shared().latex = nil
        }
        MyScriptSampleObserver.shared().delegate = self.delegate
        FileManager.default.createIinkDirectory()

        let lastOpenedFile = FilesProvider.retrieveLastModifiedFile()

        if lastOpenedFile == nil {
            try? self.createPackage(engineProvider: EngineProvider.sharedInstance)
        }

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
        if let err = err {
            let alert = UIAlertController(title: err.failureReason, message: err.errorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                self.err = nil
                MyScriptSampleObserver.shared().delegate?.cancel()
            }))
            context.coordinator.coordinator?.navigationController.present(alert, animated: true, completion: nil)
            
        }
    }

    typealias UIViewControllerType = UINavigationController

    private func createPackage(engineProvider: EngineProvider) throws {
        guard let engine = engineProvider.engine else {
            return
        }
        let existingIInkFiles = FilesProvider.iinkFilesFromIInkDirectory()
        let fileNames: [String] = existingIInkFiles.map({ $0.fileName })
        var index: Int = 0
        var newName = ""
        var newTempName = ""
        repeat {
            index+=1
            newName = String(format: "File%d.iink", index)
            newTempName = String(format: "File%d.iink-files", index)
        } while fileNames.contains(newName) || fileNames.contains(newTempName)
        do {
            let fullPath = FileManager.default.pathForFileInIinkDirectory(fileName: newName)
            let package = try engine.createPackage(fullPath.decomposedStringWithCanonicalMapping)
            let part = try package.createPart(with: "Math")
            try package.save()
        } catch {
            print("Error while creating package : " + error.localizedDescription)
            throw error
        }
    }

}

class Con {
    var coordinator: MainCoordinator?
}
// struct Canvas_Previews: PreviewProvider {
//    static var previews: some View {
//        Canvas()
//    }
// }
