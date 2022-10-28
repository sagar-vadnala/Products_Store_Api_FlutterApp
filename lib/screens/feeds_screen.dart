import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:products_app/widgets/feeds_widget.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../services/api_handler.dart';
import '../widgets/appbar_icons.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductModel> productsList = [];
  int limit = 10;
  bool _isLoading = false;
  bool _isLimit = false;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(
        target: 'products', limit: limit.toString(), targe: '');
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        limit += 10;
        log("limit $limit");
        await getProducts();
        _isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: productsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 0.6),
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                            value: productsList[index],
                            child: const FeedWidget());
                      }),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
    );
  }
}
