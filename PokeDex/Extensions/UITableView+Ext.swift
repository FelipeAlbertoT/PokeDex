//
//  UITableView+Ext.swift
//  PokeDex
//
//  Created by Felipe Treichel on 10/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}
