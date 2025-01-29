import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:products_app/conts/global_colors.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/services/api_handler.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id});
  final String id;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  ProductModel? productModel;
  bool isError = false;
  String errorStr = "";
  Future<void> getProductInfo() async {
    try {
      productModel = await APIHandler.getProductById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isError
            ? Center(
                child: Text(
                  "An error occured $errorStr",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : productModel == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        const BackButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productModel!.category!.name.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      productModel!.title.toString(),
                                      textAlign: TextAlign.start,
                                      style: titleStyle,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                          text: '\$',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  33, 150, 243, 1)),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: productModel!.price
                                                  .toString(),
                                              style: TextStyle(
                                                  color: lightTextColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Text("data")
                          // Swiper(
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return FancyShimmerImage(
                          //       width: double.infinity,
                          //       imageUrl:
                          //           productModel!.images![index].toString(),
                          //       boxFit: BoxFit.fill,
                          //     );
                          //   },
                          //   autoplay: true,
                          //   itemCount: 3,
                          //   pagination: const SwiperPagination(
                          //       alignment: Alignment.bottomCenter,
                          //       builder: DotSwiperPaginationBuilder(
                          //         color: Colors.white,
                          //         activeColor: Colors.red,
                          //       )),
                          // ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: titleStyle,
                              ),
                              Text(
                                productModel!.description.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
