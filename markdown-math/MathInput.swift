//
//  MathInput.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/29.
//

import SwiftUI

struct MathInput: View {
    @State var tex: String
    @State var format: MathFormatType
    @State private var handwriting = false
    var engine: IINKEngine?
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
            }.sheet(isPresented: $handwriting) {
                if engine != nil {
                  Handwriting(engine: engine!)}
            }.buttonStyle(.borderedProminent)

        }.padding()
    }
}

struct MathInput_Previews: PreviewProvider {
    static var previews: some View {
        MathInput(tex: """
        \\tau
        """, format: .Katex, onCancel: {}, onInsert: { _ in })
    }
}
