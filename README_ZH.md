# GracefulImagePicker

[![CI Status](http://img.shields.io/travis/SwiftCafe/GracefulImagePicker.svg?style=flat)](https://travis-ci.org/SwiftCafe/GracefulImagePicker)
[![Version](https://img.shields.io/cocoapods/v/GracefulImagePicker.svg?style=flat)](http://cocoapods.org/pods/GracefulImagePicker)
[![License](https://img.shields.io/cocoapods/l/GracefulImagePicker.svg?style=flat)](http://cocoapods.org/pods/GracefulImagePicker)
[![Platform](https://img.shields.io/cocoapods/p/GracefulImagePicker.svg?style=flat)](http://cocoapods.org/pods/GracefulImagePicker)

## 示例

![](https://github.com/swiftcafex/GracefulImagePicker/blob/master/Documents/title.gif)

GracefulImagePicker 是一个经过精心设计并且简单易用的 UI 组件，主要用于从系统相册中选取图片。 效果如上图所示。 它提供比系统原生组件更好的用户体验。

## 需求

- Swift 4.0
- CocoaPods

## 安装

GracefulImagePicker 可以通过 [CocoaPods](http://cocoapods.org) 来安装。 只需要在 Podfile 中添加如下内容：

```ruby
pod 'GracefulImagePicker'
```

## 使用

首先用 import 语句导入 GracefulImagePicker：

```swift
import GracefulImagePicker
```

然后:

```swift
let pickerController = GracefulImagePickerViewController()
pickerController.imageSelected = { image, asset in

// handle image picked

}
self.navigationController?.pushViewController(pickerController, animated: true)
```

创建一个 `GracefulImagePickerViewController` 实例 ,然后设置  `imageSelected` 回调属性, 它用于处理被选择的图片。

### 使用配置项

你还可以给 `GracefulImagePickerViewController` 添加配置项:

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

目前，`ImagePickerConfiguration` 支持两个配置项， `style` 和 `reverseImageList`。

- **Style**:  `.White` 或者  `.Black`  表示图片选择器的颜色风格。
- **reverseImageList**: 默认是 `false`. 如果设置为 `true`,  相册中的图片会以反向的顺序显示。


### 直接使用 View

如果你不想使用 ViewController 的形式， 你还可以使用 `GracefulImagePickerView` 类。 这是一个 `UIView` 的子类。 可以直接添加到视图层级中：

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

`GracefulImagePickerView` 和 `GracefulImagePickerViewController` 有类似的回调。 它还多了一个 `backClicked` 回调。 用于处理后退按钮点击。

最后 `GracefulImagePickerView`  可以用传入 `ImagePickerConfiguration` 用于设置项：

```swift
let config = ImagePickerConfiguration()
config.style = .Black
config.reverseImageList = true

pickerView = GracefulImagePickerView(frame: CGRect.zero, config: config)
```

## 作者

我的邮箱: swiftcafex@gmail.com.
另外，你也可以关注我的微信公众号：

![](https://github.com/swiftcafex/GracefulImagePicker/blob/master/Documents/qrcode.jpg)

欢迎交流

## License

GracefulImagePicker 使用 MIT license。

