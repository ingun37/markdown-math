//
//  MathInput.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/29.
//

import SwiftUI

struct MathInput: View, MyScriptSampleDelegate {
    @State var tex: String
    @State var format: MathFormatType
    @State private var handwriting = false
    var onCancel: () -> Void
    var onInsert: (String) -> Void
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    onCancel()
                }
                Spacer()
                Button("Insert") {
                    onInsert(tex)
                }
            }
            InputWebView(tex: $tex, format: $format)
            TextEditor(text: $tex)
            Button("Handwriting") {
                handwriting.toggle()
            }.fullScreenCover(isPresented: $handwriting) {
                MyScript(myScriptSampleDelegate: self)
            }.buttonStyle(.borderedProminent)

        }.padding()
    }
    func cancel() {
        handwriting.toggle()
    }
    func done(tex:String) {
        self.tex = tex
        handwriting.toggle()
    }
}

struct MathInput_Previews: PreviewProvider {
    static var previews: some View {
        MathInput(tex: """
        \\tau
        """, format: .Katex, onCancel: {}, onInsert: { _ in })
    }
}
