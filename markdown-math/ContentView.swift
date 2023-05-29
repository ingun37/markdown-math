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
    @State var selectedrange: NSRange = NSRange()
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
                        MathInput(tex: "", format: mathFormat, onCancel: {
                            inputMode.toggle()

                        }, onInsert: {tex in
                            print("rng",selectedrange)
                            let x = markdownContent.index(markdownContent.startIndex, offsetBy: selectedrange.location);
                            let y = markdownContent.index(markdownContent.startIndex, offsetBy: selectedrange.location + selectedrange.length);
                            
                            DispatchQueue.main.async {
                                markdownContent = markdownContent[..<x] + tex + markdownContent[y...]
                            }
                            
                            
                            inputMode.toggle()
                        })
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
            
            SwiftDownEditor(text: $markdownContent, selectedRange: $selectedrange)
                        .insetsSize(40)
                        .theme(Theme.BuiltIn.defaultDark.theme()).onSelectedRangeChange { rng in
                            selectedrange = rng
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
