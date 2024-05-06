import 'dart:developer';

import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/update_user_info/update_user_info_bloc.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: '');
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  PlatformFile? imageFile;
  Uint8List file = Uint8List(0);

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          imageFile = result.files.first;
          file = imageFile!.bytes!;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: MediaQuery.of(context).size.width < 800
                ? PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 70),
                    child: const AppBarSmall())
                : PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 70),
                    child: const Center(child: AppBarMain())),
            drawer: MediaQuery.of(context).size.width < 800
                ? const DrawerWidget()
                : null,
            body: SingleChildScrollView(
              child: Padding(
                padding: MediaQuery.of(context).size.width > 700
                    ? const EdgeInsets.symmetric(horizontal: 200.0)
                    : const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    BlocProvider(
                      create: (context) =>
                          MyUserBloc(myUserRepository: FirebaseUserRepository())
                            ..add(GetMyUser(
                                myUserId: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user!
                                    .uid)),
                      child: BlocBuilder<MyUserBloc, MyUserState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              pickImage();
                              imageCache.clear();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 50,
                              backgroundImage: NetworkImage(context
                                      .read<MyUserBloc>()
                                      .state
                                      .user
                                      ?.profilePicture ??
                                  'assets/images/account.png'),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0.5, 0.3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(children: [
                              TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: state.user!.email,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      backgroundColor: Colors.transparent),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0.5, 0.3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(children: [
                              const Text(
                                'Shipping Address',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: addressLine1Controller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Address Line 1',
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: addressLine2Controller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Street Address',
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: cityController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'City',
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: stateController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'County',
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: postalCodeController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  labelText: 'Postal Code',
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 40),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () async {
                              try {
                                String uuid = const Uuid().v1();
                                Reference ref = FirebaseStorage.instance.ref(
                                    '/user_images/${state.user!.uid}/$uuid');
                                await ref.putData(file);
                                String downloadUrl = await ref.getDownloadURL();

                                MyUser myUser =
                                    context.read<MyUserBloc>().state.user!;
                                myUser = myUser.copyWith(
                                  name: nameController.text.isNotEmpty
                                      ? nameController.text
                                      : myUser.name,
                                  addressLine1:
                                      addressLine1Controller.text.isNotEmpty
                                          ? addressLine1Controller.text
                                          : myUser.addressLine1,
                                  addressLine2:
                                      addressLine2Controller.text.isNotEmpty
                                          ? addressLine2Controller.text
                                          : myUser.addressLine2,
                                  city: cityController.text.isNotEmpty
                                      ? cityController.text
                                      : myUser.city,
                                  postalCode:
                                      postalCodeController.text.isNotEmpty
                                          ? postalCodeController.text
                                          : myUser.postalCode,
                                  profilePicture: downloadUrl.isNotEmpty
                                      ? downloadUrl
                                      : myUser.profilePicture,
                                );
                                context
                                    .read<UpdateUserInfoBloc>()
                                    .add(UpdateUserInfoRequired(myUser));
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ])),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
