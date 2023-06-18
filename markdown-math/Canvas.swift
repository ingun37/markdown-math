//
//  Canvas.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI

struct Canvas: UIViewRepresentable {
    func updateUIView(_ uiView: CanvasView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> CanvasView {
        let canvasView = UINib(nibName: "CanvasView", bundle: nil).instantiate(withOwner: nil).first as! CanvasView
        return canvasView
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas()
    }
}
