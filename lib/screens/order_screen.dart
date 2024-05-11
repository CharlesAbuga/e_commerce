import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          print(state.user!.uid);
          return BlocProvider<MyUserBloc>(
            create: (context) =>
                MyUserBloc(myUserRepository: FirebaseUserRepository())
                  ..add(GetMyUser(
                      myUserId:
                          context.read<AuthenticationBloc>().state.user!.uid)),
            child: BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                if (state.status == MyUserStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status == MyUserStatus.success) {
                  final myUser = context.read<MyUserBloc>().state.user!;
                  final orderRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(myUser!.id)
                      .collection('orders');
                  return Scaffold(
                      appBar: MediaQuery.of(context).size.width < 800
                          ? PreferredSize(
                              preferredSize:
                                  Size(MediaQuery.of(context).size.width, 70),
                              child: const AppBarSmall())
                          : PreferredSize(
                              preferredSize:
                                  Size(MediaQuery.of(context).size.width, 70),
                              child: const Center(child: AppBarMain())),
                      drawer: MediaQuery.of(context).size.width < 800
                          ? const DrawerWidget()
                          : null,
                      body: StreamBuilder<QuerySnapshot>(
                        stream: orderRef.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Text('ORDERS',
                                      style: TextStyle(fontSize: 20)),
                                  ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document
                                          .data() as Map<String, dynamic>;
                                      final date =
                                          (data['date'] as Timestamp).toDate();
                                      final formattedDate =
                                          DateFormat.yMMMd().format(date);
                                      return Theme(
                                        data: ThemeData(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            dividerColor: Colors.transparent),
                                        child: Column(
                                          children: [
                                            ExpansionTile(
                                                tilePadding: EdgeInsets.all(10),
                                                childrenPadding:
                                                    const EdgeInsets.all(8),
                                                title:
                                                    Text('Date $formattedDate'),
                                                subtitle: Text(
                                                    'Order: ${document.id}'),
                                                trailing: Text(
                                                    'Total Price: ${data['totalPrice']}'),
                                                children: [
                                                  ...data['products']
                                                      .map<Widget>((product) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                            product['name']),
                                                        subtitle: Text(
                                                            'Price: ${product['price']}'),
                                                        trailing: Text(
                                                            'Quantity: ${product['quantity']}'),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ]),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ));
                } else {
                  return const Center(
                      child: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator()));
                }
              },
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
