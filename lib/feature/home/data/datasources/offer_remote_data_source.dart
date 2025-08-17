import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/offer_model.dart';

abstract class OfferRemoteDataSource {
  Future<List<OfferModel>> getOffers();
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final FirebaseFirestore firestore;

  OfferRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<OfferModel>> getOffers() async {
    final querySnapshot = await firestore.collection("offers").where("active" ,isEqualTo: true).get();

    return querySnapshot.docs
        .map((doc) => OfferModel.fromFirestore(doc))
        .toList();
  }
}
