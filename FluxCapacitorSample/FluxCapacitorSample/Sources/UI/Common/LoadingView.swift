//
//  LoadingView.swift
//  FluxCapacitorSample
//
//  Created by marty-suzuki on 2017/08/02.
//  Copyright © 2017年 marty-suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoadingView: UIView {
    static let defaultHeight: CGFloat = 44
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let me = self else { return }
                me.activityIndicator?.isHidden = !me.isLoading
                if me.isLoading {
                    me.activityIndicator?.startAnimating()
                } else {
                    me.activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
    func add(to view: UIView) {
        removeFromSuperview()
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension Reactive where Base == LoadingView {
    var isLoading: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { me, isLoading in
            me.isLoading = isLoading
        }.asObserver()
    }
}
