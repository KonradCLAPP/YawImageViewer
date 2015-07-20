# YawImageViewer

If you have a photo that is vertical and you would like to present it on iPhone horizontal screen, than YawImageViewer is what you are looking for! YawImageViewer is a view that implements Facebook Paper like effect for image browsing. After presenting that view user see only center of a photo, buy tilt movement user can see other parts of image. 

http://youtu.be/1lPkNb1MWYk

[![CI Status](http://img.shields.io/travis/KonraCLAPP/YawImageViewer.svg?style=flat)](https://travis-ci.org/KonraCLAPP/YawImageViewer)
[![Version](https://img.shields.io/cocoapods/v/YawImageViewer.svg?style=flat)](http://cocoapods.org/pods/YawImageViewer)
[![License](https://img.shields.io/cocoapods/l/YawImageViewer.svg?style=flat)](http://cocoapods.org/pods/YawImageViewer)
[![Platform](https://img.shields.io/cocoapods/p/YawImageViewer.svg?style=flat)](http://cocoapods.org/pods/YawImageViewer)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

After downloading a pod you can add it to your ViewController like that:

```objc
#import"KGTiltView.h"

@property (nonatomic, strong) KGTiltView* tiltView;


self.tiltView = [[KGTiltView alloc] initWithFrame:self.view.bounds image:[UIImage imageNamed:@"Image.jpg"]];
[self.tiltView setMotionEnabled:YES];
self.tiltView.yawTresholdLevel=[NSNumber numberWithDouble:0.07];
[self.view addSubview:self.tiltView];
```

## Requirements

iOS 8.0

## Installation

YawImageViewer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YawImageViewer"
```

## Author

KonraCLAPP, kgnoinski@clapp.de

## Contribution

If you need sth more to be implemented in that pod just let me know :)

## License

YawImageViewer is available under the MIT license. See the LICENSE file for more info.
