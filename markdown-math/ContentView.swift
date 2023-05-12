//
//  ContentView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/12.
//

import SwiftUI
import MarkdownUI
struct ContentView: View {
    @State var markdownContent: String = ""
    
    var body: some View {
        VStack {
            HStack{
                Text("Hello, world!")
                Button("click", action: doNothing)
            }
            TextEditor(text: $markdownContent)
            Markdown(markdownContent)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
