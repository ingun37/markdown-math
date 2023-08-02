//
//  CanvasView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI
import PencilKit
class CanvasView: UIView, PKCanvasViewDelegate {
    @IBOutlet weak var pkCanvasView: PKCanvasView!;
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("did change!")
    }
}

