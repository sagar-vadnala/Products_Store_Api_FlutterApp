import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:products_app/conts/global_colors.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/screens/categories_screen.dart';
import 'package:products_app/screens/feeds_screen.dart';
import 'package:products_app/screens/users_screen.dart';
import 'package:products_app/services/api_handler.dart';
import 'package:products_app/widgets/appbar_icons.dart';
import 'package:products_app/widgets/feed_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;
  // List<ProductModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productsList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const CategoriesScreen(),
                ),
              );
            },
            icon: IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const UsersScreen(),
                  ),
                );
              },
              icon: IconlyBold.user3,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).cardColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: lightIconsColor,
                    )),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Text("data")
                        // Swiper(
                        //   itemCount: 3,
                        //   itemBuilder: (ctx, index) {
                        //     // PageTransition(
                        //     //   child: SaleWidget(),
                        //     //   type: PageTransitionType.fade,
                        //     // );
                        //     return const SaleWidget();
                        //   },
                        //   autoplay: true,
                        //   pagination: const SwiperPagination(
                        //       alignment: Alignment.bottomCenter,
                        //       builder: DotSwiperPaginationBuilder(
                        //           color: Colors.white,
                        //           activeColor: Colors.red)),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Latest Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const FeedsScreen()));
                                },
                                icon: IconlyBold.arrowRight3),
                          ],
                        ),
                      ),
                      // GridView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: 3,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2,
                      //             crossAxisSpacing: 0.0,
                      //             mainAxisSpacing: 0.0,
                      //             childAspectRatio: 0.6),
                      //     itemBuilder: (ctx, index) {
                      //       return const FeedWidget();
                      //     }),
                      // HERE THERE WAS SIMPLE UI BEFORE API HANDLING
                      FutureBuilder<List<ProductModel>>(
                        future: APIHandler.getAllProducts(
                            target: 'products', limit: "3", targe: 'products'),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            Center(
                                child:
                                    Text("An error occures ${snapshot.error}"));
                          } else if (snapshot.data == null) {
                            const Center(
                                child: Text("No products has been added yet"));
                          }
                          return FeedsGridWidget(productsList: snapshot.data!);
                        }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
