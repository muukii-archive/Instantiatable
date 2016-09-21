// Instantiatable.swift
//
// Copyright (c) 2016 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

/// Make your UITableViewCell and UICollectionViewCell subclasses
/// conform to this protocol when they are *not* NIB-based but only code-based
/// to be able to dequeue them in a type-safe manner
public protocol Reusable: class {
    /// The reuse identifier to use when registering and later dequeuing a reusable cell
    static var reuseIdentifier: String { get }
}

/// Make your UITableViewCell and UICollectionViewCell subclasses
/// conform to this protocol when they *are* NIB-based
/// to be able to dequeue them in a type-safe manner
public protocol NibReusable: Reusable, InstantiatableFromXIB {}

// MARK: - Default implementation for Reusable

public extension Reusable {
    /// By default, use the name of the class as String for its reuseIdentifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - UITableView support for Reusable & NibReusable

public extension UITableView {
    /**
     Register a NIB-Based `UITableViewCell` subclass (conforming to `NibReusable`)
     
     - parameter cellType: the `UITableViewCell` (`NibReusable`-conforming) subclass to register
     
     - seealso: `registerNib(_:,forCellReuseIdentifier:)`
     */
    final func registerReusableCell<T: UITableViewCell>(cellType: T.Type) where T: NibReusable {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)
     
     - parameter cellType: the `UITableViewCell` (`Reusable`-conforming) subclass to register
     
     - seealso: `registerClass(_:,forCellReuseIdentifier:)`
     */
    final func registerReusableCell<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UITableViewCell` object for the class inferred by the return-type
     
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     
     - returns: A `Reusable`, `UITableViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCellWithIdentifier(_:,forIndexPath:)`
     */
    final func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    /**
     Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `NibReusable`)
     
     - parameter viewType: the `UITableViewHeaderFooterView` (`NibReusable`-conforming) subclass to register
     
     - seealso: `registerNib(_:,forHeaderFooterViewReuseIdentifier:)`
     */
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: NibReusable {
        self.register(viewType.nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)
     
     - parameter viewType: the `UITableViewHeaderFooterView` (`Reusable`-confirming) subclass to register
     
     - seealso: `registerClass(_:,forHeaderFooterViewReuseIdentifier:)`
     */
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: Reusable {
        self.register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type
     
     - parameter viewType: The view class to dequeue
     
     - returns: A `Reusable`, `UITableViewHeaderFooterView` instance
     
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableHeaderFooterViewWithIdentifier(_:)`
     */
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type = T.self) -> T? where T: Reusable {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the header/footer beforehand"
            )
        }
        return view
    }
}

// MARK: - UICollectionView support for Reusable & NibReusable

public extension UICollectionView {
    /**
     Register a NIB-Based `UICollectionViewCell` subclass (conforming to `NibReusable`)
     
     - parameter cellType: the `UICollectionViewCell` (`NibReusable`-conforming) subclass to register
     
     - seealso: `registerNib(_:,forCellWithReuseIdentifier:)`
     */
    final func registerReusableCell<T: UICollectionViewCell>(cellType: T.Type) where T: NibReusable {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)
     
     - parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register
     
     - seealso: `registerClass(_:,forCellWithReuseIdentifier:)`
     */
    final func registerReusableCell<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
     
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     
     - returns: A `Reusable`, `UICollectionViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCellWithReuseIdentifier(_:,forIndexPath:)`
     */
    final func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    /**
     Register a NIB-Based `UICollectionReusableView` subclass (conforming to `NibReusable`) as a Supplementary View
     
     - parameter elementKind: The kind of supplementary view to create.
     - parameter viewType: the `UIView` (`NibReusable`-conforming) subclass to register as Supplementary View
     
     - seealso: `registerNib(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    final func registerReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, viewType: T.Type) where T: NibReusable {
        self.register(viewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /**
     Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View
     
     - parameter elementKind: The kind of supplementary view to create.
     - parameter viewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View
     
     - seealso: `registerClass(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
     */
    final func registerReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, viewType: T.Type) where T: Reusable {
        self.register(viewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /**
     Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type
     
     - parameter elementKind: The kind of supplementary view to retrieve.
     - parameter indexPath:   The index path specifying the location of the cell.
     - parameter viewType: The view class to dequeue
     
     - returns: A `Reusable`, `UICollectionReusableView` instance
     
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableSupplementaryViewOfKind(_:,withReuseIdentifier:,forIndexPath:)`
     */
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (elementKind: String, indexPath: IndexPath, viewType: T.Type = T.self) -> T where T: Reusable {
        let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath as IndexPath)
        guard let typedView = view as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the supplementary view beforehand"
            )
        }
        return typedView
    }
}
