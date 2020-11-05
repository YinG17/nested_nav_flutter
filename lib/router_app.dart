import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPaths {
  static const home = '/';
  static const screenA = '/screenA';
  static const screenB = '/screenB';
  static const screenC = '/screenC';
}

//////////////////////////////////////////////// `Route observer`
///
class AppRouter extends NavigatorObserver {
  static Map<String, GetPageRoute> navStack = {};

  static GetPageRoute generate(routeSettings) {
    String routeName = routeSettings.name;
    Widget routePage;

    switch (routeName) {
      case ScreenPaths.home:
        routePage = Home();
        break;
      case ScreenPaths.screenA:
        routePage = ScreenA();
        break;
      case ScreenPaths.screenB:
        routePage = ScreenB();
        break;
      case ScreenPaths.screenC:
        routePage = ScreenC();
        break;

      /// Default route, can be use to redirect to `Page not found` screen when wrong path is provided.
      default:
        routePage = Home();
    }

    GetPageRoute route = GetPageRoute(
      settings: routeSettings,
      routeName: routeName,
      page: () => routePage,
    );

    /// check if the route already exists on `navStack`.
    if (navStack[routeName] != null) {
      /// remove if it exists.
      navigator.removeRoute(navStack[routeName]);
    }

    /// add to `navStack`
    navStack[routeName] = route;

    return route;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    final routeName = route.settings.name;
    navStack.remove(routeName);
  }
}

//////////////////////////////////////////////// `App`
///
class RouterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: ScreenPaths.home,
      onGenerateRoute: AppRouter.generate,
      navigatorObservers: [AppRouter()],
    );
  }
}

//////////////////////////////////////////////// `SCREENS`
///
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenA);
              },
              child: Text('Go to Screen A'),
            ),
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenB);
              },
              child: Text('Go to Screen B'),
            ),
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenC);
              },
              child: Text('Go to Screen C'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[500],
      appBar: AppBar(
        title: Text('Screen A'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenB);
              },
              child: Text('Go to Screen B'),
            ),
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenC);
              },
              child: Text('Go to Screen C'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      appBar: AppBar(
        title: Text('Screen B'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenA);
              },
              child: Text('Go to Screen A'),
            ),
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenC);
              },
              child: Text('Go to Screen C'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500],
      appBar: AppBar(
        title: Text('Screen C'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenA);
              },
              child: Text('Go to Screen A'),
            ),
            RaisedButton(
              onPressed: () {
                Get.toNamed(ScreenPaths.screenC);
              },
              child: Text('Go to Screen B'),
            ),
          ],
        ),
      ),
    );
  }
}
