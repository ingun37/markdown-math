//
//  Handwriting.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI
import PencilKit

struct Handwriting: View, CanvasViewDelegate {
    var engine: IINKEngine
    init(engine: IINKEngine) {
        self.engine = engine;
        do {
            let contentPackage = try engine.createPackage("tmp");
            let contentPart = contentPackage.createPart(with: "Math")
            let editor = engine.createEditor(renderer: <#T##IINKRenderer#>, toolController: <#T##IINKToolController?#>)

        } catch {
            
        }
        
    }
    var body: some View {
        VStack {
            Canvas(engine: engine, delegate: self)
            Button("finish") {
                print("finish")
            }
        }
    }
    func didChange(strokes: [PKStroke]) {
        print("haha")
    }
}

// struct Handwriting_Previews: PreviewProvider {
//    static var previews: some View {
//        Handwriting()
//    }
// }
