# Instantiatable

[![CI Status](http://img.shields.io/travis/muukii/Instantiatable.svg?style=flat)](https://travis-ci.org/muukii/Instantiatable)
[![Version](https://img.shields.io/cocoapods/v/Instantiatable.svg?style=flat)](http://cocoapods.org/pods/Instantiatable)
[![License](https://img.shields.io/cocoapods/l/Instantiatable.svg?style=flat)](http://cocoapods.org/pods/Instantiatable)
[![Platform](https://img.shields.io/cocoapods/p/Instantiatable.svg?style=flat)](http://cocoapods.org/pods/Instantiatable)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Usage

```swift
import Instantiatable

final class MyViewController: UIViewController, InstantiatableFromStoryboard {}
```

```swift
let controller = MyViewController.instantiate() // Load from Storyboard
```

## Requirements

## Installation

Instantiatable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Instantiatable"
```

## Author

muukii, m@muukii.me

## License

Instantiatable is available under the MIT license. See the LICENSE file for more info.
