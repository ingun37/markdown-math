//
//  CanvasView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI
import PencilKit

protocol CanvasViewDelegate {
    func     didChange (strokes: [PKStroke])
}

class CanvasView: UIView, PKCanvasViewDelegate {
    @IBOutlet weak var pkCanvasView: PKCanvasView!
    var delegate: CanvasViewDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        self.delegate?.didChange(strokes: canvasView.drawing.strokes)
    }
}
