import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/layout/layout_main.dart';
import 'package:kitajom/layout/layout_mobile.dart';
import 'package:kitajom/provider/filter_provider.dart';
import 'package:kitajom/provider/request_provider.dart';
import 'package:kitajom/provider/booking_provider.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:kitajom/resources/local_notification.dart';
import 'package:kitajom/screens/login_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:provider/provider.dart';

import 'provider/page_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.initializeNotification();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC50PYrp-1seZPOEBcPisYPmDNNsM7YbKk",
      appId: "1:1064917493526:android:e1cc6af2113b6dbb929237",
      messagingSenderId: "1064917493526",
      projectId: "kitajomdemo",
      storageBucket: "gs://kitajomdemo.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RequestProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FilterProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: mainGreen),
          primarySwatch:generateMaterialColor(mainGreen),
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              toolbarHeight: 100,
              centerTitle: true,
              color: Colors.white,
              //<-- SEE HERE
              titleTextStyle:(Theme.of(context).textTheme).titleLarge!.copyWith(
                    //Theme.of() instead of ThemeData
                    color: titleGreen,
                fontSize: 22
                  ),
            ),
            scaffoldBackgroundColor: white,
            //textTheme: GoogleFonts.lexendTextTheme(Theme.of(context).textTheme)
    ),
        debugShowCheckedModeBanner: false,
        home:
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("error"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: darkGray),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

// Add a new document with a generated ID

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
