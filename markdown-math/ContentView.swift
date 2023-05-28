//
//  ContentView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/12.
//

import SwiftUI
import MarkdownUI
import SwiftDown


struct ContentView: View {
    @State var markdownContent: String = initialMarkdown
    @State var inlineDelimeter: DelimeterType = DelimeterType.GitLab
    @State var mathFormat: MathFormatType = MathFormatType.Katex
    var body: some View {
        VStack {
            HStack{
                Text("Add")
                Button("Inline Math", action: doNothing)
                Text("or")
                Button("Math Block", action: doNothing)
                
                Text("In")
                Picker("Inline Delimeter", selection: $inlineDelimeter) {

                    ForEach(DelimeterType.allCases) { style in
                        Text(style.rawValue.capitalized)
                    }
                }
                Text("delimeter and ")
                Picker("Format", selection: $mathFormat) {

                    ForEach(MathFormatType.allCases) { style in
                        Text(style.rawValue.capitalized)
                    }
                }
                Text("format")


            }
            SwiftDownEditor(text: $markdownContent)
                        .insetsSize(40)
                        .theme(Theme.BuiltIn.defaultDark.theme())
            WebView(markdown: $markdownContent, delimeter: $inlineDelimeter, format: $mathFormat)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
