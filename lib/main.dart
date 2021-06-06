import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:progressor/MainScene/HomePageView.dart';
import 'package:progressor/Service/NotificationService.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await LocalNotification().init();
  await NotificationService().init();
  runApp(MainApp());
  
  initForegroundRunning();
}

Future<void> initForegroundRunning() async {
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "The Progressor",
    notificationText: "App is running to track the time",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  bool success = await FlutterBackground.initialize(androidConfig: androidConfig);

}



class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        home: HomePageView(),
        debugShowCheckedModeBanner: false,
        
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationService())
      ],
    );
  }
}
