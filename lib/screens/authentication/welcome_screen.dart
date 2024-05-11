import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:ecommerce_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:ecommerce_app/screens/authentication/sign_in_screen.dart';
import 'package:ecommerce_app/screens/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatefulWidget {
  final ScaffoldMessengerState? scaffoldMessenger;
  final AppBar? appBar;
  const WelcomeScreen({super.key, this.scaffoldMessenger, this.appBar})
      : super();

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    Future.delayed(const Duration(seconds: 5), () {
      widget.scaffoldMessenger?.hideCurrentSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                SvgPicture.asset(
                  'assets/images/reusable-shopping-bags-svgrepo-com.svg',
                  height: 100,
                )
                    .animate(delay: 500.ms)
                    .scale(begin: Offset(0, 0), duration: 1.seconds)
                    .shake(delay: 1000.ms, duration: 500.ms),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                TabBar(
                    controller: tabController,
                    unselectedLabelColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.3),
                    labelColor: Theme.of(context).colorScheme.onBackground,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ]),
                Expanded(
                  child: TabBarView(controller: tabController, children: [
                    BlocProvider<SignInBloc>(
                      create: (context) => SignInBloc(
                          userRepository: context
                              .read<AuthenticationBloc>()
                              .userRepository),
                      child: const SignInScreen(),
                    ),
                    BlocProvider<SignUpBloc>(
                      create: (context) => SignUpBloc(
                          userRepository: context
                              .read<AuthenticationBloc>()
                              .userRepository),
                      child: const SignUpScreen(),
                    ),
                  ]),
                )
              ],
            ).animate().fade(duration: 1.seconds).then(delay: 500.ms),
          ),
        ),
      ),
    );
  }
}
