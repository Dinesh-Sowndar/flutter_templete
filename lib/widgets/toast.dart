import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSuccessMessage(String content) {
  Get.snackbar("Success", content,
      colorText: Colors.white,
      barBlur: 100,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      dismissDirection: DismissDirection.horizontal,
      borderRadius: 8,
      margin: const EdgeInsets.all(15),
      isDismissible: true);
}

showErrorMessage(String content) {
  Get.snackbar("Info", content,
      colorText: Colors.white,
      barBlur: 100,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      dismissDirection: DismissDirection.horizontal,
      borderRadius: 8,
      margin: const EdgeInsets.all(15),
      isDismissible: true);
}
