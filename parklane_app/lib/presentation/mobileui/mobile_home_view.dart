import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parklane_app/business_logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:parklane_app/data/repository/auth_repository.dart';
import 'package:parklane_app/presentation/screen/map_screen.dart';
import 'package:parklane_app/presentation/widgets/gobals/home_screen_button_widget.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var user = context.watch<AuthenticationState>().user;
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Welcome Back!',
          style: Theme.of(context).textTheme.headline6,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutRequested());
                ;
                print("Logout button pressed");
              },
              tooltip: 'Logout',
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      backgroundColor: Colors.yellow.shade100,
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              var user = state.user;
              return Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 20.0),
                child: ListTile(
                  leading: CircleAvatar(
                      child: Text(user.username![0].toUpperCase()), radius: 40),
                  title: Text(
                    user.username!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  isThreeLine: true,
                  subtitle: Text(user.email!),
                ),
              );
            },
          ),
          Positioned(
              left: 0.0,
              top: _screenSize.height * 0.2,
              child: Container(
                height: _screenSize.height * 0.8,
                width: _screenSize.width,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28))),
              )),
          DraggableScrollableSheet(
              minChildSize: 0.6,
              initialChildSize: 0.6,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28))),
                  child: GridView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(12.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 16.0,
                              crossAxisSpacing: 16.0,
                              crossAxisCount: 2),
                      children: [
                        HomeScreenButtons(
                            label: 'History',
                            icon: const Icon(
                              Icons.history_rounded,
                              size: 30.0,
                            ),
                            onPressed: () {}),
                        HomeScreenButtons(
                            label: 'Edit Profile',
                            icon: const Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                            onPressed: () {}),
                        HomeScreenButtons(
                            label: 'Help',
                            icon: const Icon(
                              Icons.help_sharp,
                              size: 30.0,
                            ),
                            onPressed: () {})
                      ]),
                );
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Let Go Park'),
        onPressed: () {
          Navigator.of(context).pushNamed(MapScreen.route);
        },
      ),
      //  BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, state) {
      //     if (state.status == AuthenticationStatus.authenticated) {
      //       return Column(
      //           children: [Text(state.user.id), Text(state.user.email!)]);
      //     }
      //     return const Text('User');
      //   },
      // )
    );
  }
}
