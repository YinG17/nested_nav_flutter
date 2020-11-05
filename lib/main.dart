import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class NavigatorKeys {
  static const screenANavigator = 0;
  static const screenBNavigator = 1;
}

class ScreenPaths {
  static const home = '/';
  static const subScreenA = '/subScreenA';
  static const subScreenB = '/subScreenB';
  static const DefaultScreen = '/DefaultScreen';
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      getPages: [
        GetPage(name: ScreenPaths.home, page: () => Home()),
        GetPage(name: ScreenPaths.subScreenA, page: () => SubScreenA()),
        GetPage(name: ScreenPaths.subScreenB, page: () => SubScreenB()),
        GetPage(name: ScreenPaths.DefaultScreen, page: () => DefaultScreen()),
      ],
    );
  }
}

/// `HOME`
///
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          ScreenANavigator(),
          ScreenBNavigator(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Screen A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Screen B',
          ),
        ],
      ),
    );
  }
}

/// `Screen A Navigator`
///
class ScreenANavigator extends StatefulWidget {
  @override
  _ScreenANavigatorState createState() => _ScreenANavigatorState();
}

class _ScreenANavigatorState extends State<ScreenANavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavigatorKeys.screenANavigator),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ScreenPaths.subScreenA:
            return GetPageRoute(
              settings: settings,
              page: () => SubScreenA(
                parent: 'Screen A',
                stackIndex: NavigatorKeys.screenANavigator,
              ),
            );
          case ScreenPaths.subScreenB:
            return GetPageRoute(
              settings: settings,
              page: () => SubScreenB(
                parent: 'Screen A',
                stackIndex: NavigatorKeys.screenANavigator,
              ),
            );
          default:
            return GetPageRoute(
              settings: settings,
              page: () => DefaultScreen(
                parent: 'Screen A',
                stackIndex: NavigatorKeys.screenANavigator,
              ),
            );
        }
      },
    );
  }
}

/// `Screen B Navigator`
///
class ScreenBNavigator extends StatefulWidget {
  @override
  _ScreenBNavigatorState createState() => _ScreenBNavigatorState();
}

class _ScreenBNavigatorState extends State<ScreenBNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavigatorKeys.screenBNavigator),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ScreenPaths.subScreenA:
            return GetPageRoute(
              settings: settings,
              page: () => SubScreenA(
                parent: 'Screen B',
                stackIndex: NavigatorKeys.screenBNavigator,
              ),
            );
          case ScreenPaths.subScreenB:
            return GetPageRoute(
              settings: settings,
              page: () => SubScreenB(
                parent: 'Screen B',
                stackIndex: NavigatorKeys.screenBNavigator,
              ),
            );
          default:
            return GetPageRoute(
              settings: settings,
              page: () => DefaultScreen(
                parent: 'Screen B',
                stackIndex: NavigatorKeys.screenBNavigator,
              ),
            );
        }
      },
    );
  }
}

/// `SUB SCREENS`
///
class SubScreenA extends StatelessWidget {
  final String parent;
  final int stackIndex;
  SubScreenA({this.parent, this.stackIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$parent : SUB SCREEN A'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('GO TO Sub Screen B'),
              onPressed: () {
                Get.toNamed(ScreenPaths.subScreenB, id: stackIndex);
              },
            ),
            RaisedButton(
              child: Text('GO TO Default Sub Screen'),
              onPressed: () {
                Get.toNamed(ScreenPaths.DefaultScreen, id: stackIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubScreenB extends StatelessWidget {
  final String parent;
  final int stackIndex;
  SubScreenB({this.parent, this.stackIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$parent : SUB SCREEN B'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('GO TO Sub Screen A'),
              onPressed: () {
                Get.toNamed(ScreenPaths.subScreenA, id: stackIndex);
              },
            ),
            RaisedButton(
              child: Text('GO TO Default Sub Screen'),
              onPressed: () {
                Get.toNamed(ScreenPaths.DefaultScreen, id: stackIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultScreen extends StatelessWidget {
  final String parent;
  final int stackIndex;
  DefaultScreen({this.parent, this.stackIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$parent : Default Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('GO TO Sub Screen A'),
              onPressed: () {
                Get.toNamed(ScreenPaths.subScreenA, id: stackIndex);
              },
            ),
            RaisedButton(
              child: Text('GO TO Sub Screen B'),
              onPressed: () {
                Get.toNamed(ScreenPaths.subScreenB, id: stackIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
