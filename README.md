# Numbers - Flutter Samples
The project was created for understanding Flutter framework and mobile development methodologies in Flutter
Project is a simple mobile app for [NumbersAPI](http://numbersapi.com/) where user can find interesting fact about some random or specific (inputted) number
There are 3 examples of app, all developed using different approaches

1 app - is a basic app to become familiar with Flutter basic concepts: Widgets, Statefull/Stateless, FutureBuilder and etc.
It is possible to witness how app was developed by looking at 4 HomePage widgets, each representing "iteration" of development

2 app - is app developed using Simple State Management [approach](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)

3 app - is app developed using BLoC State Management [approach](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx)


## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
This application is developed with [Flutter](https://flutter.dev). 
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

Install Flutter on your local machine. View [install instructions](https://flutter.dev/docs/get-started/install)

### Installing
Copy [project files](https://github.com/inulugbek/numbers) and install app dependencies by executing the following command in the project folder.
```
flutter packages get
```

### Running
Run the app on emulator or physical device by executing the following command.
```
flutter run
```
*Run the app in release mode for the best performance
```
flutter run --release
```

## The important bits
### Architecture
While developing the project Clean Architecture principles were taken into consideration. 
The code base is divided into 3 layers: Data, Domain and Presentation/UI. 

#### Data Layer
Data layer of the application consists of Repositories, Models and Data Sources. 
Models are representations of business objects.
Data Sources are used to get data from different data sources local, remote (API) & etc
Repositories are used to determine which data sources should be used in particular situation.

`/src/data/datasources/*` - data sources (remote & local)
`/src/data/models/*` - models
`/src/data/repositories/*` - repositories

#### Domain Layer
Domain layer is the layer that performs middleman role between Data layer and Presentation layer. 
It contains of controllers and presentation logic holders. 
Controllers are the classes where all the core business logic of the app is concentrated.
Presenters are used to manage presentation logic - state pages. 
For this particular app ChangeNotifiers and Streams with the help of Provider package were mainly used to manage the state of the app.

`/src/domain/controllers/*` - controllers business logic
`/src/domain/presenters/*` - presentation logic made using ChangeNotifiers

#### Presentaion/UI Layer
Presentation layer consists of pages/screens of the app and common encapsulated widgets that were used in design of the app.
the main concern was to seperate as much logic from the UI as possible.

`/src/ui/pages/*` - screens/pages
`/src/ui/widgets/*` - widgets
`/src/ui/theme.dart` - app theme files, corporate colors, textstyles, icons and etc.

### Dependencies
This is the list of third-party libraries used in development.
* [provider](https://pub.dev/packages/provider)
* [http](https://pub.dev/packages/http)

## Authors
* **Ulugbek Isroilov** - *Author* - [Email](mailto:inulugbek@gmail.com)
