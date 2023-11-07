import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/DI.dart';
import 'core/MultiBlocProvidersList.dart';
import 'core/bloc_observer.dart';
import 'core/navigation_router.dart';

void main() async{
  await intiAppModule();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  Bloc.observer = MyGlobalObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: MultiBlocProvidersList.blocProvidersList(context),
  child:  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:    const AppBarTheme(elevation: 0,backgroundColor: Colors.transparent,),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(foregroundColor: Colors.black,backgroundColor: Colors.white),
        scaffoldBackgroundColor: const Color(0xffFEB054),
        useMaterial3: false,
      ),
    darkTheme: ThemeData.dark(),
    onGenerateRoute: NavigationRouter.generateRoute,
    initialRoute: homeRoute,
      
    ),
);
  }
}

