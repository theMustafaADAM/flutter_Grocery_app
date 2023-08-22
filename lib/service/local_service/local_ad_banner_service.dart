// ignore_for_file: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:flutter_ecommerce_app/model/ad_banner.dart';

class LocalAdBannerService {
  late Box<AdBanner> _adBannerBox;

  Future<void> init() async {
   _adBannerBox = await Hive.openBox<AdBanner>('AdBanners');
  }

  Future<void> assignAllAdBanners({required List<AdBanner> adBanners}) async {
    await _adBannerBox.clear();
    await _adBannerBox.addAll(adBanners);
  }

  List<AdBanner> getAdBanners() => _adBannerBox.values.toList();
}