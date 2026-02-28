import 'package:flutter/material.dart';
import '../viewmodel/auction_view_model.dart';

class AuctionScreen extends StatefulWidget {
  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final AuctionViewModel _viewModel = AuctionViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.seedDatabase('item_001').then((_) {
      _viewModel.listenToAuction('item_001');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text("Firebase Realtime DB"),
            backgroundColor: Colors.white,
          ),
          body: _viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    final item = _viewModel.item!;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),
          ),

          SizedBox(height: 20),

          Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CURRENT BID",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\$${item.currentBid.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Last Bidder: ${item.lastBidder}",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),

          if (_viewModel.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _viewModel.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ),

          Spacer(),

          Row(
            children: [
              Expanded(child: _bidButton(amount: -10, label: "- \$10")),
              SizedBox(width: 15),
              Expanded(child: _bidButton(amount: 20, label: "+ \$20")),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bidButton({required double amount, required String label}) {
    bool isDisabled = (_viewModel.item!.currentBid <= 0 && amount <= 0);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        splashFactory: isDisabled
            ? NoSplash.splashFactory
            : InkSplash.splashFactory,
        backgroundColor: Colors.black.withValues(alpha: isDisabled ? 0.0 : 1.0),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        if (isDisabled) return;
        double newPrice = _viewModel.item!.currentBid + amount;
        _viewModel.placeBid(newPrice);
      },
      child: Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
