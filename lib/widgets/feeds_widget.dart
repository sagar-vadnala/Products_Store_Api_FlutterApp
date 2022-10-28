import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:products_app/conts/global_colors.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/screens/products_details.dart';
import 'package:provider/provider.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductModel productsModelProvider =
        Provider.of<ProductModel>(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ProductDetails(
                    id: productsModelProvider.id.toString(),
                  )),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: "\$",
                            style: const TextStyle(
                              color: Color.fromRGBO(33, 150, 243, 1),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${productsModelProvider.price}",
                                style: TextStyle(
                                    color: lightTextColor,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                    ),
                    const Icon(IconlyBold.heart)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  height: size.height * 0.2,
                  width: double.infinity,
                  errorWidget: const Icon(
                    IconlyBold.danger,
                    color: Colors.red,
                  ),
                  imageUrl: productsModelProvider.images![0],
                  boxFit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productsModelProvider.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
