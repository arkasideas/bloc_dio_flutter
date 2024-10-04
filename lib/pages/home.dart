import 'package:bloc_dio/data/datasource/remote_datasource.dart';
import 'package:bloc_dio/pages/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(remoteDataSource: RemoteDatasource())..add(LoadUser()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final data = state.users;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        data[index].avatar,
                      ),
                    ),
                    title: Text(
                        '${data[index].firstName} ${data[index].lastName}'),
                    subtitle: Text(data[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit),
                        Icon(Icons.delete),
                      ],
                    ),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(
                child: Text(state.error),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
