import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_web_linux_app/layout/home_layout_news.dart';
import 'package:news_web_linux_app/shared/bloc_observer.dart';
import 'package:news_web_linux_app/shared/cubit/cubit.dart';
import 'package:news_web_linux_app/shared/cubit/cubit_mode.dart';
import 'package:news_web_linux_app/shared/cubit/states_mode.dart';
import 'package:news_web_linux_app/shared/network/local/cache_helper.dart';
import 'package:news_web_linux_app/shared/network/remote/dio_helper.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;

  if (Platform.isLinux) {
    await DesktopWindow.setMinWindowSize(
      const Size(
        600,
        600,
      ),
    );
  }

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getDataBuisness(),
        ),
        BlocProvider(
          create: (context) => AppCubitMode()..changemode(formShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubitMode, AppCubitModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubitMode cubit = AppCubitMode.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                selectedIconTheme: IconThemeData(
                  color: Colors.deepOrange,
                  size: 40.0,
                ),
                selectedLabelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.deepOrange,
              ),
              textTheme: const TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333738'),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333738'),
                  statusBarIconBrightness: Brightness.light,
                ),
                color: HexColor('333738'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333738'),
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                selectedIconTheme: const IconThemeData(
                  color: Colors.deepOrange,
                  size: 40.0,
                ),
                selectedLabelStyle: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
              ),
              textTheme: const TextTheme(
                headline6: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const Directionality(
              textDirection: TextDirection.rtl,
              child: HomeLayoutNews(),
            ),
          );
        },
      ),
    );
  }
}
