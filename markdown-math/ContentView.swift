//
//  ContentView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/12.
//

import SwiftDown
import SwiftUI
enum ManualOrientation {
    case horizontal
    case vertical
}

struct ContentView: View {
    @State var markdownContent: String = initialMarkdown
    @State var selectedrange: NSRange = .init()
    @State var inlineDelimeter: DelimeterType = .GitLab
    @State var mathFormat: MathFormatType = .Latex
    @State private var inputMode = false
    @State private var manualOrientation: ManualOrientation = .vertical

    var body: some View {
        VStack {
            HStack {
                Text("Delimeter style")
                Picker("Inline Delimeter", selection: $inlineDelimeter) {
                    ForEach(DelimeterType.allCases) { style in
                        Text(style.rawValue)
                    }
                }
                Text("Math renderer")
                Picker("Format", selection: $mathFormat) {
                    ForEach(MathFormatType.allCases) { style in
                        Text(style.rawValue.capitalized)
                    }
                }

                Button("Input Math") {
                    inputMode.toggle()
                }.sheet(isPresented: $inputMode) {
                    VStack {
                        MathInput(tex: "", format: mathFormat, onCancel: {
                            inputMode.toggle()

                        }, onInsert: { tex in
                            print("rng", selectedrange)
                            let x = markdownContent.index(markdownContent.startIndex, offsetBy: selectedrange.location)
                            let y = markdownContent.index(markdownContent.startIndex, offsetBy: selectedrange.location + selectedrange.length)

                            DispatchQueue.main.async {
                                markdownContent = markdownContent[..<x] + tex + markdownContent[y...]
                            }

                            inputMode.toggle()
                        })
                    }
                }.buttonStyle(.borderedProminent)
            }

            let layout = manualOrientation == .vertical ?
                AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

            layout {
                WebView(markdown: $markdownContent, delimeter: $inlineDelimeter, format: $mathFormat)

                SwiftDownEditor(text: $markdownContent, selectedRange: $selectedrange)
                    .insetsSize(40)
                    .theme(Theme.BuiltIn.defaultDark.theme()).onSelectedRangeChange { rng in
                        selectedrange = rng
                    }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
