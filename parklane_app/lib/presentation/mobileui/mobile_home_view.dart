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
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Welcome User!',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: ListTile(
              leading: const CircleAvatar(
                  child: Text(
                    'U',
                  ),
                  radius: 30),
              title: Text(
                'User Name',
                style: Theme.of(context).textTheme.headline5,
              ),
              isThreeLine: true,
              subtitle: Text('Email'),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    width: _screenSize.width,
                    height: _screenSize.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(MapScreen.route);
                            },
                            child: Text('Let\'s Go Park'))
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28)))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28))),
                    height: _screenSize.height * 0.5,
                    width: _screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView(
                          padding: const EdgeInsets.all(12.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 12.0,
                                  crossAxisSpacing: 12.0,
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
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
