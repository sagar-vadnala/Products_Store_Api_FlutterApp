import 'package:flutter/material.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/widgets/feeds_widget.dart';
import 'package:provider/provider.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({super.key, required this.productsList});
  final List<ProductModel> productsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 0.6),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
              value: productsList[index], child: const FeedWidget());
        });
  }
}
