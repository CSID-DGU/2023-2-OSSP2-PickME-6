import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ossp_pickme/pages/MyInfo_page.dart';
import 'package:ossp_pickme/pages/Home_page.dart';
import 'package:ossp_pickme/pages/Match_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      title: 'PickME Demo',
      theme: ThemeData(
               primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PickME Home Page'),
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
      const MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '배달비 공유 앱',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'My Page',
            icon: Icon(_index==2 ? Icons.account_circle : Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}