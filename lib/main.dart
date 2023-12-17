import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:ossp_pickme/chatting/chat/chat_screen.dart';
import 'package:ossp_pickme/comment/comment_repository.dart';
import 'package:ossp_pickme/comment/comment_state.dart';
import 'package:ossp_pickme/comment/user_provider.dart';
import 'package:ossp_pickme/comment/user_state.dart';
import 'package:ossp_pickme/pages/Chat_page.dart';
import 'package:ossp_pickme/pages/Login_page.dart';
import 'package:ossp_pickme/pages/MyInfo_page.dart';
import 'package:ossp_pickme/pages/Home_page.dart';
import 'package:ossp_pickme/pages/Match_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'comment/comment_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<CommentRepository>(
        create: (_) => CommentRepository(
        firebaseFirestore: FirebaseFirestore.instance,
        ),
      ),
      StateNotifierProvider<UserProvider, UserState>(
          create: (context) => UserProvider(),
        ),
      StateNotifierProvider<CommentProvider, CommentState>(
        create: (_) => CommentProvider(),
      ),
      ],
      child: const MyApp(),
      ),
    );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'PickME',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
               primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();


  
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  
  final List<Widget> _pages = [
      const HomePage(),
      const MatchingPage(),
      const ChatPage(),
      const MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PickME'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, 
                    icon: Icon(Icons.notifications)),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(_index==0 ? Icons.home : Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Matching',
            icon: Icon(_index==1 ? Icons.people : Icons.people_outlined),
          ),
           BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(_index==2 ? Icons.chat : Icons.chat_outlined),
          ),
          BottomNavigationBarItem(
            label: 'My Page',
            icon: Icon(_index==3 ? Icons.account_circle : Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}

