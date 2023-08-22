import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/model/ad_banner.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/service/local_service/local_ad_banner_service.dart';
import 'package:flutter_ecommerce_app/service/local_service/local_product_service.dart';
import 'package:flutter_ecommerce_app/service/local_service/local_category_service.dart';
import '../model/category.dart' as ct;
import '../model/category.dart';
import '../model/product.dart';
import '../service/remote_service/remote_banner_service.dart';
import '../service/remote_service/remote_popular_category_service.dart'; 
import '../service/remote_service/remote_popular_porduct_service.dart';


class HomeController extends GetxController { 
  static HomeController instance = Get.find();

  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<ct.Category> popularCategoryList = List<ct.Category>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void onInit() async {
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();
    getAdBanners();
    getPopularCategories();
    getPopularProducts();
    super.onInit(); 
  }
 
  void getAdBanners() async {
    try {
      isBannerLoading(true);
      // assigning local ad banners before call api
      if (_localAdBannerService.getAdBanners().isNotEmpty){
        bannerList.assignAll(_localAdBannerService.getAdBanners());
      }
      // call api
      var result = await RemoteBannerService().get();
      if (result != null) {
        // assign api result
        bannerList.assignAll(adBannerListFromJson(result.body));
        //save api result to local db
        _localAdBannerService.assignAllAdBanners(adBanners: adBannerListFromJson(result.body));
      }
    } finally {
      if (kDebugMode) {
        print(bannerList.length);
      }
      isBannerLoading(false);
    }
  }
  
  void getPopularCategories() async {
    try {
      isPopularCategoryLoading(true);
      if(_localCategoryService.getPopularCategories().isNotEmpty){
        popularCategoryList.assignAll(_localCategoryService.getPopularCategories());
      }
      var result = await RemotePopularCategoryService().get();
      if(result != null) {
        popularCategoryList.assignAll(popularCategoryListFromJson(result.body));
        _localCategoryService.assignAllPopularCategories(popularCategories: popularCategoryListFromJson(result.body));
      }
    } finally {
      if (kDebugMode) {
        print(popularCategoryList.length);
      }
      isPopularCategoryLoading(false);
    }
  }
  
  
  void getPopularProducts() async {
    try {
      isPopularProductLoading(true);
      if(_localProductService.getPopularProducts().isNotEmpty) {
        popularProductList.assignAll(_localProductService.getPopularProducts());
      }
      var result = await RemotePopularProductService().get();
      if (result != null) {
        popularProductList.assignAll(popularProductListFromJson(result.body));
        _localProductService.assignAllPopularProducts(popularProductListFromJson(result.body), popularProducts: []);        
      }
    } finally {
      isPopularProductLoading(false);
    }
  }
}
