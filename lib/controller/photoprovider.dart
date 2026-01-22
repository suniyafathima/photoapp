import 'package:flutter/material.dart';
import 'package:photoapp/model/fetch_photo_model.dart';
import 'package:photoapp/service/photo_service.dart';

class PhotoProvider extends ChangeNotifier {
  final PhotoService _photoService = PhotoService();

  List<Fetchphotomodel> photos = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchPhotos() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      photos = await _photoService.fetchPhotos();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
