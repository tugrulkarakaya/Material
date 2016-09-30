/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import Material

class RootViewController: UIViewController {
    /// A reference to the Undo button.
    private var undoButton: FlatButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.lighten1
        
        prepareUndoButton()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        prepareSnackbar()
        animateSnackbar()
    }
    
    private func prepareUndoButton() {
        undoButton = FlatButton(title: "Undo", titleColor: Color.yellow.base)
        undoButton.pulse.animation = .backing
        undoButton.titleLabel?.font = RobotoFont.regular(with: 14)
    }
    
    private func prepareSnackbar() {
        guard let sc = snackbarController else {
            return
        }
        
        sc.snackbar.text = "Reminder saved."
        sc.snackbar.rightViews = [undoButton]
    }
    
    private func animateSnackbar() {
        guard let sc = snackbarController else {
            return
        }
        
        _ = sc.animate(snackbar: .visible, delay: 1)
        _ = sc.animate(snackbar: .hidden, delay: 4)
    }
}
