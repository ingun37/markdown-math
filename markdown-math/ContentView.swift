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
    @State private var inputMode = false

    let engine:IINKEngine
    var body: some View {
        VStack {
            HStack{
                Text("Add")
                Button("Math") {
                    inputMode.toggle()
                }.sheet(isPresented: $inputMode) {
                    VStack {
                        HStack {
                            Button("Cancel") {
                                inputMode.toggle()
                            }
                            Spacer()
                            Button("Insert") {
                                inputMode.toggle()
                            }
                        }
                        MathInput(tex: "", format: mathFormat)
                    }
                }
                                
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
            
            WebView(markdown: $markdownContent, delimeter: $inlineDelimeter, format: $mathFormat)
            
            SwiftDownEditor(text: $markdownContent)
                        .insetsSize(40)
                        .theme(Theme.BuiltIn.defaultDark.theme()).onSelectedRangeChange { range in
                          print("onon", range)
                        }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(engine: try! EngineProvider.make())
    }
}
