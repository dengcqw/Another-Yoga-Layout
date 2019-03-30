//
//  SingleObjMap.swift
//  TVGuor
//
//  Created by Deng Jinlong on 21/04/2018.
//  Copyright © 2018 tvguo. All rights reserved.
//

import UIKit

public protocol MapSelf {
}

extension MapSelf {
    public func mapSelf(_ config: (Self)->Void) -> Self {
        config(self)
        return self
    }
}

extension UIView: MapSelf {
}

extension UIViewController: MapSelf {
}
