import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/app/router.dart';
import 'package:shoe_shop_app/core/services/injection_container.dart';
import 'package:shoe_shop_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shoe_shop_app/features/discover/presentation/view/discover_page.dart';
import 'package:shoe_shop_app/features/review/presentation/bloc/review_bloc.dart';
import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DiscoverBloc>(),
        ),
        BlocProvider(create: (context) => sl<ReviewBloc>()),
        BlocProvider(create: (context) => sl<CartBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: DiscoverPage.routeName,
      ),
    );
  }
}
