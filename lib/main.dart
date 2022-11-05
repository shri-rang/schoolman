import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schoolmanegment/firebase_options.dart';
import 'package:schoolmanegment/message.dart';
import 'package:schoolmanegment/screens/ForgortPassword/view/Forgotpassword.dart';
import 'package:schoolmanegment/screens/HomeScreen/view/HomeScreen.dart';
import 'package:schoolmanegment/screens/login/View/LoginScreen.dart';
import 'package:schoolmanegment/utility.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  var token = await getToken();
  Widget startScreen = LoginScreen();

  print("tyoken $token");
  if (token != null) {
    startScreen = HomeSreen();
  }
  runApp(MyApp(startScreen));
}

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);
  MyApp(this.startScreen);
  final Widget startScreen;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/message',
        arguments: MessageArguments(message, true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return CalendarControllerProvider(
          controller: EventController(),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Color(0xFF01579b),
              ),
              // primarySwatch: Colors.blue,
              primaryColor: Color(0xFF01579b),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF01579b),
                ),
              ),
              // accentColor: Colors.blueAccent,
              textTheme: Typography.englishLike2018.apply(
                  bodyColor: Color(0xFF01579b),
                  displayColor: Color(0xFF01579b),
                  fontSizeFactor: 1.sp),
            ),
            home: widget.startScreen,
            builder: EasyLoading.init(),
          ),
        );
      },
    );

    //  MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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

// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'firebase_options.dart';
// import 'package:flutter/foundation.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   // await Firebase.initializeApp();
//   // Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: MyHomePage(title: 'Flutter Auth Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _smsController = TextEditingController();
//   String? _verificationId;
//   final SmsAutoFill _autoFill = SmsAutoFill();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     // call();
//   }

//   call() async {
//     await Firebase.initializeApp();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title!),
//         ),
//         key: _scaffoldKey,
//         // resizeToAvoidBottomPadding: false,
//         body: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _phoneNumberController,
//                     decoration: const InputDecoration(
//                         labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     alignment: Alignment.center,
//                     child: RaisedButton(
//                         child: Text("Get current number"),
//                         onPressed: () async => {
//                               _phoneNumberController.text =
//                                   (await _autoFill.hint)!
//                             },
//                         color: Colors.greenAccent[700]),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     alignment: Alignment.center,
//                     child: RaisedButton(
//                       color: Colors.greenAccent[400],
//                       child: Text("Verify Number"),
//                       onPressed: () async {
//                         verifyPhoneNumber();
//                       },
//                     ),
//                   ),
//                   TextFormField(
//                     controller: _smsController,
//                     decoration:
//                         const InputDecoration(labelText: 'Verification code'),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(top: 16.0),
//                     alignment: Alignment.center,
//                     child: RaisedButton(
//                         color: Colors.greenAccent[200],
//                         onPressed: () async {
//                           signInWithPhoneNumber();
//                         },
//                         child: Text("Sign in")),
//                   ),
//                 ],
//               )),
//         ));
//   }

//   void verifyPhoneNumber() async {
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await _auth.signInWithCredential(phoneAuthCredential);
//       showSnackbar(
//           "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
//     };
//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       print("error $authException.message");
//       showSnackbar(
//           'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
//     };

//     PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       print("error $verificationId");
//       showSnackbar('Please check your phone for the verification code.');
//       _verificationId = verificationId;
//     };

//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       print("error $verificationId");
//       showSnackbar("verification code: " + verificationId);
//       _verificationId = verificationId;
//     };

//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: _phoneNumberController.text,
//           timeout: const Duration(seconds: 5),
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       print("error $e");
//       showSnackbar("Failed to Verify Phone Number: ${e}");
//     }
//   }

//   void signInWithPhoneNumber() async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId!,
//         smsCode: _smsController.text,
//       );

//       final User? user = (await _auth.signInWithCredential(credential)).user;

//       showSnackbar("Successfully signed in UID: ${user!.uid}");
//     } catch (e) {
//       showSnackbar("Failed to sign in: " + e.toString());
//     }
//   }

//   void showSnackbar(String message) {
//     _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
//   }


// }
