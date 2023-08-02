//
//  SwiftUIView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/28.
//

import SwiftUI

struct SwiftUIView: View {
    @State var engine: IINKEngine?
    @State var errorMessage: String?

    var body: some View {
        if engine != nil {
            ContentView(engine: engine!)
        } else if errorMessage != nil {
            Text("Something went wrong")
            Text(errorMessage!)
        } else {
            Text("Loading ...").onAppear {
                DispatchQueue.global().async {
                    do {
                        engine = try EngineProvider.make()
                    } catch {
                        switch error {
                        case EngineError.CFile:
                            errorMessage = "Certificate file"
                        case EngineError.InvalidCert:
                            errorMessage = "Invalid Certificate"
                        case let EngineError.RecognitionAsset(msg):
                            errorMessage = "Recognition Asses problem: " + msg
                        case let EngineError.TempDirectory(msg):
                            errorMessage = "Temp Directory problem: " + msg
                        default:
                            errorMessage = "unknown: " + error.localizedDescription
                        }
                    }
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
