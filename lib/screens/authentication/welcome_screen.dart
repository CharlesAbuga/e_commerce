import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:ecommerce_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:ecommerce_app/screens/authentication/sign_in_screen.dart';
import 'package:ecommerce_app/screens/authentication/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
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
                      child: SignInScreen(),
                    ),
                    BlocProvider<SignUpBloc>(
                      create: (context) => SignUpBloc(
                          userRepository: context
                              .read<AuthenticationBloc>()
                              .userRepository),
                      child: SignUpScreen(),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
