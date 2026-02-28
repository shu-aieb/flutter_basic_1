import 'package:firebase_database/firebase_database.dart';
import 'model/auction_model.dart';

class AuctionRepository {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child(
    'auctions',
  );

  Stream<AuctionItem> getAuctionStream(String auctionId) {
    return _dbRef.child(auctionId).onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) throw Exception("Auction not found");
      return AuctionItem.fromMap(data);
    });
  }

  Future<void> placeBid(
    String auctionId,
    double newAmount,
    String bidderName,
  ) async {
    await _dbRef.child(auctionId).update({
      'currentBid': newAmount,
      'lastBidder': bidderName,
    });
  }

  Future<void> createDummyAuction(String auctionId) async {
    final targetRef = _dbRef.child(auctionId);
    final snapshot = await targetRef.get();
    if (snapshot.exists) return;

    await _dbRef.child('item_001').set({
      'id': 'item_001',
      'title': 'Vintage Leica M3 Camera',
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/09/04/03/00/stock-6596910_1280.jpg',
      'currentBid': 100.0,
      'lastBidder': 'Starting Price',
    });
  }
}
