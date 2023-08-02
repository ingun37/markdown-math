//
//  Canvas.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI
import PencilKit

struct Canvas: UIViewRepresentable, CanvasViewDelegate {
    func updateUIView(_ uiView: CanvasView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> CanvasView {
        let canvasView = UINib(nibName: "CanvasView", bundle: nil).instantiate(withOwner: nil).first as! CanvasView
        canvasView.delegate = self
        return canvasView
    }
    func didChange(strokes: [PKStroke]) {
        print("hehe")
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas()
    }
}
