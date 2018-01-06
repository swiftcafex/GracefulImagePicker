# GracefulImagePicker

[![CI Status](http://img.shields.io/travis/SwiftCafe/GracefulImagePicker.svg?style=flat)](https://travis-ci.org/SwiftCafe/GracefulImagePicker)
[![Version](https://img.shields.io/cocoapods/v/GracefulImagePicker.svg?style=flat)](http://cocoapods.org/pods/GracefulImagePicker)
[![License](https://img.shields.io/cocoapods/l/GracefulImagePicker.svg?style=flat)](http://cocoapods.org/pods/GracefulImagePicker)
[![Platform](https://img.shields.io/cocoapods/p/GracefulImagePicker.svg?style=flat)](http://cocoapods.org/pods/GracefulImagePicker)

## Example

GracefulImagePicker is a designed and simple UI component for pick image from system album. Like the image show above, it provide a better user experience than the default native component.

[这篇文档的简体中文版本]()

## Requirements

- Swift 4.0
- CocoaPods

## Installation

GracefulImagePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GracefulImagePicker'
```

## Usage

First import the GracefulImagePicker framework:

```swift
import GracefulImagePicker
```

Then:

```swift
let pickerController = GracefulImagePickerViewController()
pickerController.imageSelected = { image, asset in

    // handle image picked
    
}
self.navigationController?.pushViewController(pickerController, animated: true)
```

Create a `GracefulImagePickerViewController`, and set `imageSelected` callback, which provide the selected image and asset.

### Use Config

You can also config the `GracefulImagePickerViewController`:

```swift
let config = ImagePickerConfiguration()
config.style = .Black
config.reverseImageList = true

let pickerController = GracefulImagePickerViewController(config: config)
pickerController.imageSelected = { image, asset in

    // handle image picked.
    
}
self.navigationController?.pushViewController(pickerController, animated: true)
```

Currently, the `ImagePickerConfiguration` class support two config,  style and reverseImageList.

- **Style**:  .White or .Black indicate the color theme of the image picker.
- **reverseImageList**: Default to false.  if set to true, the image will be display in reverse order in the album.


### Use View Directly

If you do not like ues the ViewController, you can also use `GracefulImagePickerView`, that a UIView subclass, can be directly added to view hierarchy:

```swift
var pickerView = GracefulImagePickerView(frame: CGRect.zero)
pickerView?.backClicked = {

self.dismiss(animated: true, completion: nil)

    // handle back button clicked.
    
}

pickerView?.imageSelected = { image, asset in

    // handle image picked

}
self.view.addSubview(pickerView)
```

`GracefulImagePickerView` has similar callback of `GracefulImagePickerViewController`, except , it has an additional `backClicked` callback, which handle the back button clicked of image picker.

Last , The `ImagePickerConfiguration` class, also applied to `GracefulImagePickerView` :

```swift
let config = ImagePickerConfiguration()
config.style = .Black
config.reverseImageList = true

pickerView = GracefulImagePickerView(frame: CGRect.zero, config: config)
```

## Author

My email: swiftcafex@gmail.com.
You can also follow me on wechat:



## License

GracefulImagePicker is available under the MIT license. See the LICENSE file for more info.
