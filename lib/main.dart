// ignore: depend_on_referenced_packages
import 'package:Panasonic_offline/cubits/DarkMode/DarkModeCubit.dart';
import 'package:Panasonic_offline/cubits/DarkMode/DarkModeStates.dart';
import 'package:Panasonic_offline/cubits/EditingProduct/EditingProductCubit.dart';
import 'package:flutter/material.dart';
import 'package:Panasonic_offline/NavigationBar.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:Panasonic_offline/screens/AddProductPage.dart';
import 'package:Panasonic_offline/screens/EditOrDeleteProductPage.dart';
import 'package:Panasonic_offline/screens/SplachScreen.dart';
import 'package:Panasonic_offline/screens/MyProductsPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>(kProductsBox);

  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return ProviderVariables();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EditProductCubit()),
        BlocProvider(create: (context) => DarkModeCubit()),
      ],
      child: BlocBuilder<DarkModeCubit, Mode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: BlocProvider.of<DarkModeCubit>(context).isDark
                ? // Dark
                ThemeData(
                    brightness: Brightness.dark,
                    primaryColor: Colors.grey[700],
                    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
                    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850], elevation: 0, shape: Border(bottom: BorderSide(color: Colors.grey[800]!))),
                    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.dark(scrim: Colors.white.withOpacity(.5), background: Colors.grey[850]!, outline: Colors.grey[700]!)),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.grey[900], selectedItemColor: Colors.blue, unselectedItemColor: Colors.grey),
                    checkboxTheme: CheckboxThemeData(overlayColor: MaterialStateProperty.all(Colors.blue)),
                    scaffoldBackgroundColor: Colors.grey[900],
                  )
                : // Light
                ThemeData(
                    brightness: Brightness.light,
                    primaryColor: kPrimayColor,
                    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
                    appBarTheme: const AppBarTheme(backgroundColor: kPrimayColor),
                    buttonTheme: const ButtonThemeData(colorScheme: ColorScheme.light(scrim: kPrimayColor, background: Colors.white, outline: kPrimayColor)),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white, selectedItemColor: kPrimayColor, unselectedItemColor: Colors.grey[800]),
                    checkboxTheme: CheckboxThemeData(overlayColor: MaterialStateProperty.all(kPrimayColor)),
                  ),
            routes: {
              'SplachScreen': (context) => const SplachScreen(),
              'MyProductsPage': (context) => const MyProductsPage(),
              'AddProductPage': (context) => const AddProductPage(),
              'EditOrDeleteProductPage': (context) => const EditOrDeleteProductPage(),
              'HomeNavigationBar': (context) => const HomeNavigationBar(),
            },
            home: const SplachScreen(),
          );
        },
      ),
    );
  }
}

class ProviderVariables extends ChangeNotifier {
  ProductModel? product;
}
