import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/view/page/splash_page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: () async {
//         bool isLoggedIn = await getValue("boolean");
//         saveValue("boolean", !isLoggedIn);
//       }),
//       body: Center(
//         child: RaisedButton(onPressed: () async {
//           bool isLoggedIn = await getValue("boolean");
//
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//             return isLoggedIn
//                 ? MyWorkSpasesPage()
//                 : LoginScreen(isLogged: isLoggedIn);
//           }));
//         }),
//       ),
//     );
//   }
// }
//
// class LoginScreen extends StatefulWidget {
//   final bool isLogged;
//
//   const LoginScreen({Key? key, required this.isLogged}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState(isLogged);
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool isLogged;
//   _LoginScreenState(this.isLogged);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isLogged.toString()),
//       ),
//       body: const Center(
//         child: Text("Please create a new account"),
//       ),
//     );
//   }
// }
//
// class MyWorkSpasesPage extends StatefulWidget {
//   @override
//   MyWorkSpasesPageState createState() => MyWorkSpasesPageState();
// }
//
// class MyWorkSpasesPageState extends State<MyWorkSpasesPage> {
//   final HttpService httpService = HttpService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Work Spaces'),
//       ),
//       body: FutureBuilder(
//         future: httpService.getMyWorkSpaces(),
//         builder: (context, snapshot) {
//           Iterable l = json.decode(snapshot.data.toString());
//           List<WorkSpace> myWorkSpaces =
//               List<WorkSpace>.from(l.map((model) => WorkSpace.fromJson(model)));
//
//           if (snapshot.connectionState == ConnectionState.done) {
//             return ListView.separated(
//               separatorBuilder: (context, index) {
//                 return const Divider(
//                   height: 2,
//                   color: Colors.black,
//                 );
//               },
//               itemBuilder: (context, index) {
//                 return ListTile(
//                     title: Center(
//                         child: Text(
//                       myWorkSpaces[index].workSpaceTitle,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w500, fontSize: 18.0),
//                     )),
//                     subtitle: Center(
//                       child: Text('Id : ${myWorkSpaces[index].workSpaceId}'),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => WorkSpaseScreen(
//                                   workSpaceId:
//                                       myWorkSpaces[index].workSpaceId)));
//                     });
//               },
//               itemCount: myWorkSpaces.length,
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class WorkSpaseScreen extends StatelessWidget {
//   final String workSpaceId;
//
//   WorkSpaseScreen({Key? key, required this.workSpaceId}) : super(key: key);
//
//   final HttpService httpService = HttpService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Work Spaces'),
//       ),
//       body: FutureBuilder(
//         future: httpService.getWorkSpace(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             WorkSpace? workSpace = snapshot.data as WorkSpace?;
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text(workSpace!.workSpaceTitle),
//                 ),
//                 body: Container(
//                   alignment: Alignment.topCenter,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // Container(
//                       //   height: 200.0,
//                       //   width: 200.0,
//                       //   decoration: BoxDecoration(
//                       //       image: DecorationImage(
//                       //           image: AssetImage('assets/logo.png'),
//                       //           fit: BoxFit.fill),
//                       //       shape: BoxShape.circle),
//                       // ),
//                       // Container(
//                       //   child: Text(
//                       //     workSpace.g,
//                       //     textAlign: TextAlign.center,
//                       //     style: TextStyle(
//                       //         fontStyle: FontStyle.normal, fontSize: 14.0),
//                       //   ),
//                       // ),
//                       Container(
//                         child: Text(
//                           workSpace.workSpaceId,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Text(
//                           workSpace.workSpaceTitle,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontStyle: FontStyle.normal,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ));
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
//
// void saveValue(String key, bool value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool(key, value);
// }
//
// Future<bool> getValue(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //Return String
//   return prefs.getBool(key) ?? false;
// }
