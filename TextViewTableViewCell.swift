//
//  TextViewTableViewCell.swift
//  TextViewInTableView
//
//  Created by Alexey Chekanov on 1/23/18.
//  Copyright © 2018 Alexey Chekanov. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell, UITextViewDelegate {
    
    weak var tableView: UITableView?
    var textViewHeight: CGFloat?

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textViewHeight = textView.intrinsicContentSize.height
        textView.becomeFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
        guard let tableView = tableView else { return }
        
        selfUpdate(in: tableView)
        scrollToCursor()
    }
    
    func selfUpdate(in tableView: UITableView) {
        
        // Do nothing if the height wasn't change
        guard textViewHeight != textView.intrinsicContentSize.height else { return }
        
        textViewHeight = textView.intrinsicContentSize.height
        // Disabling animations gives us our desired behaviour
        UIView.setAnimationsEnabled(false)
        /* These will causes table cell heights to be recaluclated,
         without reloading the entire cell */
        tableView.beginUpdates()
        tableView.endUpdates()
        
        UIView.setAnimationsEnabled(true)
    }
    
    func scrollToCursor() {
        
        guard let tableView = tableView else { return }
        
        if let currentCursorPosition = textView.selectedTextRange?.end {
            print(currentCursorPosition)
            
            let caret = textView.caretRect(for: currentCursorPosition)
            
            print(caret)
            
            tableView.scrollRectToVisible(caret, animated: false)
        }
    }
}
