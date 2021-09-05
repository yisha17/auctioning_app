import 'package:auction_real/business_logic/bloc/alluser_bloc.dart';
import 'package:auction_real/data/dataproviders/UserdataProvider.dart';
import 'package:auction_real/data/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUser extends StatelessWidget {
  final UserRepository userRepository = UserRepository(UserDataProvider());
  final snackBar = SnackBar(content: Text('user deleted!'));
  void messageDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete user?"),
            actions: [
              TextButton(
                child: Text("YES"),
                onPressed: () {
                  BlocProvider.of<AlluserBloc>(context).add(DeleteEvent(id));
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          title: Text('All Users'),
        ),
        body: RepositoryProvider.value(
          value: this.userRepository,
          child: BlocProvider(
            create: (context) =>
                AlluserBloc(user: this.userRepository)..add(UserLoad()),
            child: BlocBuilder<AlluserBloc, AlluserState>(
              builder: (context, state) {
                if (state is UserFailure) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ),
                      Center(
                        child: Text('could not get items'),
                      ),
                    ],
                  );
                }
                if (state is UserSuccess) {
                  final user = state.users;
                  return Container(
                    child: ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (_, index) {
                          if (user.elementAt(index).administrator == false) {
                            return ListTile(
                                leading: Icon(Icons.person),
                                title: Text('${user.elementAt(index).name}'),
                                subtitle:
                                    Text('${user.elementAt(index).email}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    BlocProvider.of<AlluserBloc>(context).add(
                                        DeleteEvent(
                                            '${user.elementAt(index).id}'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                ));
                          }
                          return Container();
                        }),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}
