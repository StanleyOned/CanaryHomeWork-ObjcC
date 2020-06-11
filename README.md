# CanaryHomework-ObjC

### Setup

The project doesn't depend on any third party libraries to compile, you can run the project by opening the CanaryHomework.xcodeproj file in Xcode and pressing the play button.

### Architecture

The architecture of the application follows the [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) pattern. All business logic is handle in the view controller including fetching for devices/readings using the **CoreDataController** object, you can see an example inside the **DeviceViewController.m**.

**Note** this code-base uses a lot of [Singleton](https://en.wikipedia.org/wiki/Singleton_pattern), I believe [Singleton](https://en.wikipedia.org/wiki/Singleton_pattern) defeats the purpose or definition of [Object Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming) because theirs a global access to Singleton, not all classes needs to know about such object, which is why I like to use the  the [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) pattern in my projects. See the [Swift](https://github.com/StanleyOned/CanaryHomework-Swift) version of this project to see the difference between the two.

### Testing

Most of the project main functionalities are fully tested using Unit Testing. Inside the CanaryHomeworkTests folder, you will find the Unit Test. There you will find tests for all Device feature.

### Extra Features

The project supports Dark Mode. You can test the functionality by toggling the `Dark/light` mode in your device Settings application.

### Author

Stanle De la Cruz


