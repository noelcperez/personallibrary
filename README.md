# Personal Library using Coordinator Pattern on a Tab Bar
Sample project presenting a coordinator pattern where the root View Controller is a TabBar, I have found various articles and solutions using Navigation Controllers but never one made with TabBar so I wanted to give it a try and this is the result of it. The App allows you to manage a personal library to add, edit and remove books and authors. A third functionality was added to manipulate authentication but it doesn't have any impact on the others functionalities of the app yet.

I wanted to use Storyboards as well, all over internet is possible to find a solution where the injection is via constructor but the way storyboard works today doesn't allow you to do that, so the injection is done via properties.

## Version

0.2

## Build and Runtime Requirements
+ Xcode 8.0 or later
+ iOS 10.0 or later
+ OS X v10.11 or later


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

This sample project uses cocoapods, to install the project dependencies please follow these instructions.

```
$ git clone https://github.com/noelcarlosperez/personallibrary.git
$ cd personallibrary
$ pod install
```

## Built With

* [SwiftGen](https://github.com/SwiftGen/SwiftGen) - Code Generation Tool
* [ReSwift](https://github.com/ReSwift/ReSwift) - Swift Redux implementation
* [Firebase](https://firebase.google.com/) - Google Firebase

## Author

**Noel Perez**
* GitHub (https://github.com/noelcarlosperez)
* LinkedIn (https://www.linkedin.com/in/noelcarlosperezdieguez/)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Nataliya Patsovska's talk on try! swift NY (https://www.tryswift.co/events/2017/nyc/)
* Sommer Panage's talk on iOS Conf SG 2017 (https://engineers.sg/conference/iosconfsg-2017)
* Will Townsend's article and example of the Coordinator Pattern (https://will.townsend.io/2016/an-ios-coordinator-pattern)
* Khanlou's Coordinators Redux example (http://khanlou.com/2015/10/coordinators-redux/)
