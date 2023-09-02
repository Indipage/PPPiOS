//
//  ViewModelType.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/08/31.
//

import Foundation

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var disposeBag: DisposeBag { get set }

    func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
