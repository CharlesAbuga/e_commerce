import 'package:ecommerce_app/Routes/go_router.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBv4VMbGf9X3JaYmXgkEZq3Sx54rhiGpL0",
        appId: "1:1031724627022:web:16730cc69964e285b27f1f",
        messagingSenderId: "1031724627022",
        projectId: "ecommerce-3fdff"),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepository()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) {
            AuthenticationBloc(myUserRepository: userRepository);
          })
        ],
        child: BlocProvider(
          create: (context) =>
              AuthenticationBloc(myUserRepository: userRepository),
          child: MaterialApp.router(
            routerConfig: AppRouter().router,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(
                primary: Colors.black,
                onPrimary: Colors.black,
                secondary: Colors.white,
                onSecondary: Colors.grey[600],
                tertiary: Colors.orange,
                seedColor: Colors.black,
                background: Colors.white,
                error: Colors.red,
                outline: Colors.black,
                onBackground: Colors.black,
              ),
              useMaterial3: true,
            ),
          ),
        ));
  }
}
