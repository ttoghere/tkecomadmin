import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tkecomadmin/inner_screens/all_orders_screen.dart';
import 'package:tkecomadmin/inner_screens/all_products_grid.dart';
import 'package:tkecomadmin/screens/screens_shelf.dart';
import 'package:firebase_core/firebase_core.dart';
import 'consts/theme_data.dart';
import 'firebase_options.dart';
import 'controllers/list_menu_controller.dart';
import 'providers/dark_theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  final Future<FirebaseApp> firebaseInit = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebaseInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("An Error Occured"),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ListMenuController(),
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return themeChangeProvider;
                },
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Grocery',
                  theme: Styles.themeData(themeProvider.getDarkTheme, context),
                  routes: {
                    AllOrdersScreen.routeName: (context) =>
                        const AllOrdersScreen(),
                    AllProductsGrid.routeName: (context) =>
                        const AllProductsGrid(),
                    MainScreen.routeName: (context) => const MainScreen(),
                  },
                  initialRoute: MainScreen.routeName,
                );
              },
            ),
          );
        });
  }
}
