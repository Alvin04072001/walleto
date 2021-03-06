import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walleto/data/model/category.dart';
import 'package:walleto/data/model/history_target.dart';
import 'package:walleto/data/model/history_wallet.dart';
import 'package:walleto/data/model/saving_target.dart';
import 'package:walleto/data/model/wallet.dart';
import 'package:walleto/screens/category/category_page.dart';
import 'package:walleto/screens/home_page.dart';
import 'package:walleto/screens/main_menu_page.dart';
import 'package:walleto/screens/notes/note_add_page.dart';
import 'package:walleto/screens/notes/note_edit_page.dart';
import 'package:walleto/screens/notes/note_page.dart';
import 'package:walleto/screens/onboarding/onboarding_page.dart';
import 'package:walleto/screens/target/target_cash_page.dart';
import 'package:walleto/screens/target/target_detail_page.dart';
import 'package:walleto/screens/target/target_add_page.dart';
import 'package:walleto/screens/target/target_edit_page.dart';
import 'package:walleto/screens/target/target_list_page.dart';
import 'package:walleto/screens/wallet/wallet_edit_page.dart';
import 'package:walleto/screens/wallet/wallet_cash_page.dart';
import 'package:walleto/screens/wallet/wallet_detail_page.dart';
import 'package:walleto/screens/wallet/wallet_add_page.dart';
import 'package:walleto/screens/wallet/wallet_list_page.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'data/model/note.dart';
import 'notification/background_service.dart';
import 'notification/navigation.dart';
import 'notification/notification_helper.dart';
import 'notification/preference_provider.dart';
import 'notification/preferences_helper.dart';
import 'notification/scheduling_provider.dart';

bool? seenOnboard;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;

  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter<SavingTarget>(SavingTargetAdapter());
  Hive.registerAdapter<HistoryTarget>(HistoryTargetAdapter());
  Hive.registerAdapter<Wallet>(WalletAdapter());
  Hive.registerAdapter<HistoryWallet>(HistoryWalletAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  Hive.registerAdapter<Category>(CategoryAdapter());

  await Hive.openBox<HistoryTarget>("history_target");
  await Hive.openBox<HistoryWallet>("history_wallet");
  await Hive.openBox<SavingTarget>("savings_targets");
  await Hive.openBox<Wallet>("wallets");
  await Hive.openBox<Note>("notes");

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Walleto',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: OnBoardingPage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          MainMenuPage.routeName: (context) => MainMenuPage(),
          WalletAddPage.routeName: (context) => WalletAddPage(),
          WalletEditPage.routeName: (context) => WalletEditPage(),
          WalletDetailPage.routeName: (context) => WalletDetailPage(),
          WalletListPage.routeName: (context) => WalletListPage(),
          WalletCashPage.routeName: (context) => WalletCashPage(),
          TargetAddPage.routeName: (context) => TargetAddPage(),
          TargetEditPage.routeName: (context) => TargetEditPage(),
          TargetDetailPage.routeName: (context) => TargetDetailPage(),
          TargetListPage.routeName: (context) => TargetListPage(),
          TargetCashPage.routeName: (context) => TargetCashPage(),
          NoteAddPage.routeName: (context) => NoteAddPage(),
          NotePage.routeName: (context) => NotePage(),
          NoteEditPage.routeName: (context) => NoteEditPage(),
          CategoryPage.routeName: (context) => CategoryPage(
              isWallet: ModalRoute.of(context)!.settings.arguments as bool)
        },
        home: seenOnboard == true ? HomePage() : const OnBoardingPage(),
      ),
    );
  }
}
