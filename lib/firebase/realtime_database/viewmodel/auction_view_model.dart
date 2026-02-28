import 'package:flutter/material.dart';
import '../repository/model/auction_model.dart';
import '../repository/auction_repository.dart';

class AuctionViewModel extends ChangeNotifier {
  final AuctionRepository _repo = AuctionRepository();

  AuctionItem? _item;
  bool _isLoading = true;
  String? _errorMessage;

  AuctionItem? get item => _item;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void listenToAuction(String auctionId) {
    print("DEBUG: 1. Starting to listen...");

    _repo
        .getAuctionStream(auctionId)
        .listen(
          (updatedItem) {
            print("DEBUG: 2. Data received!");

            _item = updatedItem;
            _isLoading = false;
            notifyListeners();
          },
          onError: (error) {
            print("DEBUG: 3. Error occurred: $error");

            _errorMessage = error.toString();
            _isLoading = false;
            notifyListeners();
          },
        );
  }

  Future<void> placeBid(double amount) async {
    if (_item == null) return;

    // if (amount <= _item!.currentBid) {
    //   _errorMessage = "Bid must be higher than \$${_item!.currentBid}";
    //   notifyListeners();
    //   return;
    // }

    if (_item!.currentBid <= 0 && amount <= 0) {
      _errorMessage = "Bid must be higher than 0}";
      notifyListeners();
      return;
    }

    try {
      await _repo.placeBid(_item!.id, amount, "Me");
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to place bid";
    }
    notifyListeners();
  }

  Future<void> seedDatabase(String auctionId) async {
    await _repo.createDummyAuction(auctionId);
  }
}
