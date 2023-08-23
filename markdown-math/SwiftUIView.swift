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
                    self.engine = EngineProvider.sharedInstance.engine
                    if self.engine == nil {
                        errorMessage = "Failed to create myscript engine"

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
