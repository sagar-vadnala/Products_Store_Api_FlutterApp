import 'package:flutter/material.dart';
import 'package:products_app/models/categories_model.dart';
import 'package:products_app/models/users_model.dart';
import 'package:products_app/widgets/category_widgets.dart';
import 'package:products_app/widgets/users_widgets.dart';
import 'package:provider/provider.dart';

import '../services/api_handler.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getAllUsers(target: 'Users'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Center(child: Text("An error occures ${snapshot.error}"));
          } else if (snapshot.data == null) {
            const Center(child: Text("No products has been added yet"));
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const UsersWidget(),
                );
              });
        }),
      ),
    );
  }
}
