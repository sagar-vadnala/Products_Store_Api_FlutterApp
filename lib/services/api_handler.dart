import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:products_app/conts/api_conts.dart';
import 'package:products_app/models/categories_model.dart';
import 'package:products_app/models/product_model.dart';
import 'package:products_app/models/users_model.dart';

class APIHandler {
  static Future<List<dynamic>> getData({
    required String target,
    String? limit,
  }) async {
    try {
      var uri = Uri.https(
          BASE_URL,
          "api/v1/$target",
          target == "products"
              ? {
                  "offset": "0",
                  "limit": limit,
                }
              : {});
      var response = await http.get(uri);
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
      }
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }

  // short code for api calling
  static Future<List<ProductModel>> getAllProducts(
      {required String targe,
      required String limit,
      required String target}) async {
    List temp = await getData(target: "products", limit: limit);
    return ProductModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModel>> getAllCategories(
      {required String target}) async {
    List temp = await getData(target: "categories");
    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getAllUsers({required String target}) async {
    List temp = await getData(target: "users");
    return UsersModel.usersFromSnapshot(temp);
  }

// long form of api calling
  // static Future<List<ProductModel>> getAllProducts() async {
  //   var uri = Uri.https(BASE_URL, "api/v1/products");
  //   var response = await http.get(uri);
  //   // http.Response response;
  //   // response = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products")

  //   // );

  //   // print("response ${jsonDecode(response.body)}");
  //   var data = jsonDecode(response.body);
  //   List tempList = [];
  //   for (var v in data) {
  //     tempList.add(v);
  //   }
  //   return ProductModel.productsFromSnapshot(tempList);
  // }

  // static Future<List<CategoriesModel>> getAllCategories() async {
  //   var uri = Uri.https(BASE_URL, "api/v1/categories");
  //   var response = await http.get(uri);

  //   // print("response ${jsonDecode(response.body)}");
  //   var data = jsonDecode(response.body);
  //   List tempList = [];
  //   for (var v in data) {
  //     tempList.add(v);
  //   }
  //   return CategoriesModel.categoriesFromSnapshot(tempList);
  // }

  static Future<ProductModel> getProductById({required String id}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var response = await http.get(uri);
      var data = jsonDecode(response.body);

      return ProductModel.fromJson(data);
    } catch (error) {
      log("An erroe occured while getting product info $error");
      throw error.toString();
    }
  }
}
