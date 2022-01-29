// import 'dart:async';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class Database {
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;
//   static final box = GetStorage();
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



//   static Future<void> userCheckMail(Map<String, dynamic> user) async {
//     var data = await _db
//         .collection('users')
//         .where("email", isEqualTo: user["email"])
//         .get();
//     print(data.documents.length);
//     if (data.documents.length == 0) {
//       userRegister(user);
//     } else {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Email already Exist", "Try with another Email");
//     }
//   }

//   static Future<Map> userRegister(Map<String, dynamic> data) async {
//     // data["id"] = _db.collection('users').document().documentID;
//     await _db.collection('users').document().setData(data).then((value) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       Get.back();
//       success_mgs("Registration Successful", "Now you can Login");
//     }).catchError(() {
//       server_error();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//     });
//   }

//   static Future<void> userLogin(String email, String password) async {
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//     var data = await _db
//         .collection('users')
//         .where("password", isEqualTo: password)
//         .where("email", isEqualTo: email)
//         .getDocuments();
//     if (Get.isDialogOpen) {
//       Get.back();
//     }
//     if (data.documents.length == 1) {
//       box.write('user', data.documents[0].data);
//       box.write('my_id', data.documents[0].documentID);
//       box.write("isOwner", false);

//       Get.offAll(UserDashboard());
//     } else {
//       failure_msg("Invalide Email/Password", "Try again");
//     }
//   }

//   static Future<void> ownerCheckMail(Map<String, dynamic> owner) async {
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//     var data = await _db
//         .collection('owners')
//         .where("email", isEqualTo: owner["email"])
//         .getDocuments();
//     print(data.documents.length);
//     if (data.documents.length == 0) {
//       ownerRegister(owner);
//     } else {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Email already Exist", "Try with another Email");
//     }
//   }

//   static Future<Map> ownerRegister(Map<String, dynamic> data) async {
//     // data["id"] = _db.collection('owners').document().documentID;
//     await _db.collection('owners').add(data).then((value) {
//       print(value.toString());
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       Get.back();
//       success_mgs("Registration Successful", "Now you can Login as Owner");
//     }).catchError(() {
//       server_error();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//     });
//   }

//   static Future<void> ownerLogin(String email, String password) async {
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//     var data = await _db
//         .collection('owners')
//         .where("password", isEqualTo: password)
//         .where("email", isEqualTo: email)
//         .getDocuments();
//     if (Get.isDialogOpen) {
//       Get.back();
//     }
//     if (data.documents.length == 1) {
//       box.write('user', data.documents[0].data);
//       box.write('my_id', data.documents[0].documentID);
//       box.write("isOwner", true);

//       Get.to(OwnerDashboard());
//     } else {
//       failure_msg("Invalide Email/Password", "Try again");
//     }
//   }

//   static Future shopImage() async {
//     var data = await _db
//         .collection('owners')
//         .where("email", isEqualTo: box.read("user")["email"])
//         .getDocuments();
//     if (Get.isDialogOpen) {
//       Get.back();
//     }
//     if (data.documents.length == 1) {
//       return data.documents[0].data;
//     } else {
//       return null;
//     }
//   }

//   static Future<void> uploadShopImage(File file) async {
//     StorageReference storageReference;
//     storageReference = FirebaseStorage.instance
//         .ref()
//         .child("shop_img/${box.read("user")["id_no"]}");
//     final StorageUploadTask uploadTask = storageReference.putFile(file);
//     final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
//     final String url = (await downloadUrl.ref.getDownloadURL());
//     print("URL is $url");
//     updateshopImage({"shop_image": url});
//   }

//   static Future updateshopImage(Map<String, dynamic> data) async {
//     await _db
//         .collection('owners')
//         .document(box.read("my_id"))
//         .updateData(data)
//         .catchError((e) {
//       print(e);
//     });
//   }

//   static Future<Map> addFood(Map<String, dynamic> data) async {
//     // data["id"] = _db.collection('owners').document().documentID;
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//     await _db.collection('foods').add(data).then((value) {
//       print(value.toString());
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       Get.back(result: data);
//       success_mgs("Info", "Food added Successful!");
//     }).catchError(() {
//       server_error();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//     });
//   }

//   static Future fetchOwnerFood() async {
    
//     try {
//       var data = await _db
//           .collection('foods')
//           .where("owner_id", isEqualTo: box.read("my_id"))
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["product_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }
//   }

//   static Future deleteOwnerFood(id) async {
//     try {
//       await _db.collection('foods').document(id).delete();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       success_mgs("Info", "Food Deleted Successfully!");
//       return true;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//     }
//   }

//  static Future updateOwnerFood(String id, Map<String, dynamic> data) async {
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//    try {
//       await _db
//         .collection('foods')
//         .document(id)
//         .updateData(data)
//         .catchError((e) {
//       print(e);
//     });
//      if (Get.isDialogOpen) {
//         Get.back();
//       }
//        Get.back(result: data);
//       success_mgs("Info", "Food Updated Successfully!");
//     return true;
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//    }
   
//   }

//  static Future fetchStalls() async {
//     try {
//       var data = await _db
//           .collection('owners')
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["shop_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }
 
//  static Future fetchFoods(id) async {
//     try {
//       var data = await _db
//           .collection('foods')
//           .where("owner_id", isEqualTo: id)
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["product_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }

//    static Future updateUserProfile(Map<String, dynamic> data) async {
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//    try {
//        await _db
//         .collection('users')
//         .document(box.read("my_id"))
//         .updateData(data)
        
//         .catchError((e) {
//       print(e);
//     });
//      if (Get.isDialogOpen) {
//         Get.back();
//       }
//       print(data);
//       box.write('user', data);
//        Get.off(UserDashboard());
//       success_mgs("Info", "Profile Updated Successfully!");
//     return true;
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//    }
   
//   }

//  static Future<Map> addOrder(Map<String, dynamic> data) async {
//     // data["id"] = _db.collection('owners').document().documentID;
//     Get.dialog(LoadingWidget(), barrierDismissible: false);
//     await _db.collection('orders').add(data).then((value) {
//       print(value.toString());
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       Get.to(OrderConfirm(),arguments: [data["order_id"],data["total"],data["date"],]);
//       // success_mgs("Info", "Food added Successful!");
//     }).catchError(() {
//       server_error();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//     });
//   }
  
   
//  static Future fetchOrders(status) async {
//     try {
//       var data = await _db
//           .collection('orders')
//           .where("user_id", isEqualTo: box.read("my_id"))
//           .where("status", isEqualTo: status)

//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }


//    static Future updateUserCancel(String reason, String id) async {
//    try {
//        await _db
//         .collection('orders')
//         .document(id)
//         .updateData({"status": 1, "user_cancel_reason" : reason})
        
//         .catchError((e) {
//       print(e);
//     });
//      if (Get.isDialogOpen) {
//         Get.back();
//       }
//       success_mgs("Info", "Order Cancelled Successfully!");
//     return true;
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//    }
   
//   }

//    static Future updateUserRating(int rating, String id) async {
//    try {
//        await _db
//         .collection('orders')
//         .document(id)
//         .updateData({"review" : rating})
        
//         .catchError((e) {
//       print(e);
//     });
//      if (Get.isDialogOpen) {
//         Get.back();
//       }
//       success_mgs("Info", "Rated Successfully!");
//     return true;
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//    }
   
//   }
  
//    static Future fetchOwnerOrders(status) async {
//     try {
//       var data = await _db
//           .collection('orders')
//           .where("shop_id", isEqualTo: box.read("my_id"))
//           .where("status", isEqualTo: status)
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }
 
//    static Future updateOwnerCancel(String reason, String id) async {
//    try {
//        await _db
//         .collection('orders')
//         .document(id)
//         .updateData({"status": 1, "owner_cancel_reason" : reason})
        
//         .catchError((e) {
//       print(e);
//     });
//      if (Get.isDialogOpen) {
//         Get.back();
//       }
//       success_mgs("Info", "Order Cancelled Successfully!");
//     return true;
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//    }
   
//   }

//    static Future updateOwnerAccept(String id) async {
//    try {
//        await _db
//         .collection('orders')
//         .document(id)
//         .updateData({"status": 2})
        
//         .catchError((e) {
//       print(e);
//     });
//      if (Get.isDialogOpen) {
//         Get.back();
//       }
//       success_mgs("Info", "Order Accepted");
//     return true;
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");
//       return false;
//    }
   
//   }

//      static Future<List> fetchSales() async {
//     try {
//       var data = await _db
//           .collection('orders')
//           .where("shop_id", isEqualTo: box.read("my_id"))
//           .where("status", isEqualTo: 2)
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }

//    static Future updateOwnerToken() async {
//        _firebaseMessaging.getToken().then((String token) async{
    
//    try {
//       await _db
//         .collection('owners')
//         .document(box.read("my_id"))
//         .updateData({"token":token})
//         .catchError((e) {
//       print(e);
//     });
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//    }
//        });
//   }


//  static Future updateUserToken() async {
//     _firebaseMessaging.getToken().then((String token) async{
    
//    try {
//       await _db
//         .collection('users')
//         .document(box.read("my_id"))
//         .updateData({"token":token})
//         .catchError((e) {
//       print(e);
//     });
//    } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//    }
//      print(token);
//     });
//   }

//    static Future getUserToken(id,title, sub_title) async {
//     try {
//       var data = await _db
//           .collection('users')
//           .document(id)
//           .get()
//           ;

//           ApiServices().sendNotification(title, sub_title, data.data["token"]);
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//      ;
//     }

//   }
 
 
//    static Future getOwnerToken(id,title, sub_title) async {
//     try {
//       var data = await _db
//           .collection('owners')
//           .document(id)
//           .get()
//           ;

//           ApiServices().sendNotification(title, sub_title, data.data["token"]);
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
     
//     }

//   }
 

//   static Future userNotification() async {
//     try {
//       var data = await _db
//           .collection('orders')
//           .where("user_id", isEqualTo: box.read("my_id"))
//           .where("status",whereIn: [1,2])
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }


//   static Future ownerNotification() async {
//     try {
//       var data = await _db
//           .collection('orders')
//           .where("shop_id", isEqualTo: box.read("my_id"))
//           .where("status", whereIn: [1,0],)
          
//           .getDocuments();
//       if (Get.isDialogOpen) {
//         Get.back();
//       }

//       List filter_data = data.documents.map((e) {
//         var temp = e.data;
//         temp["_id"] = e.documentID;
//         return temp;
//       }).toList();

//       return filter_data;
//     } catch (e) {
//       if (Get.isDialogOpen) {
//         Get.back();
//       }
//       failure_msg("Server Error", "Try Again");

//       return [];
//     }

//   }
 
 
//   // static Future<void> ownerRegister(Map<String, dynamic> task) async {
//   //   await _db.collection('owners').document().setData(task).catchError((e) {
//   //     print(e);
//   //   });
//   // }

//   static Future<void> updateTask(String id, Map<String, dynamic> task) async {
//     await _db.collection('tasks').document(id).updateData(task).catchError((e) {
//       print(e);
//     });
//   }

//   static Future<void> deleteTask(String id) async {
//     await _db.collection('tasks').document(id).delete().catchError((e) {
//       print(e);
//     });
//   }
// }
