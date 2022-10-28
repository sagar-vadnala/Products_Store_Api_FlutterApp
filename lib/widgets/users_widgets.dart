import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:products_app/conts/global_colors.dart';
import 'package:products_app/models/users_model.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UsersModelProvider = Provider.of<UsersModel>(context);

    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: const Icon(
          IconlyBold.danger,
          color: Colors.red,
        ),
        imageUrl: UsersModelProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title: Text(UsersModelProvider.role.toString()),
      subtitle: Text(UsersModelProvider.email.toString()),
      trailing: Text(
        "user role",
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
