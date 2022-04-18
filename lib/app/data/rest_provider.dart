import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RestProvider extends GetConnect {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get data from firebase order by
  Future<QuerySnapshot> getAllData(
      String collection, String orderBy, bool descending) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    return await firestore
        .collection(collection)
        .orderBy(orderBy, descending: descending)
        .get()
        .whenComplete(() => EasyLoading.dismiss());
  }

  // get data where from firebase
  Future<QuerySnapshot<Map<String, dynamic>>> getDataWhere(
      String collection, String field, dynamic value) {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    return firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get()
        .whenComplete(() => EasyLoading.dismiss());
  }

  // get data firebase by id
  Future<DocumentSnapshot> getDataById(String collection, String id) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    return await firestore
        .collection(collection)
        .doc(id)
        .get()
        .whenComplete(() => EasyLoading.dismiss());
  }

  // add data firebase
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    await firestore
        .collection(collection)
        .add(data)
        .whenComplete(() => EasyLoading.dismiss());
  }

  // edit data firebase
  Future<void> editData(
      String collection, String id, Map<String, dynamic> data) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    await firestore
        .collection(collection)
        .doc(id)
        .update(data)
        .whenComplete(() => EasyLoading.dismiss());
  }

  // get all data firebase between date
  Future<QuerySnapshot> getAllDataBetweenDate(
      String collection, String field, DateTime start, DateTime end) async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    return await firestore
        .collection(collection)
        .where(field, isGreaterThanOrEqualTo: start)
        .where(field, isLessThanOrEqualTo: end)
        .get()
        .whenComplete(() => EasyLoading.dismiss());
  }
}
