class AuctionItem {
  final String id;
  final String title;
  final String imageUrl;
  final double currentBid;
  final String lastBidder;

  AuctionItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.currentBid,
    required this.lastBidder,
  });

  factory AuctionItem.fromMap(Map<dynamic, dynamic> map) {
    return AuctionItem(
      id: map['id'] ?? 'unknown',
      title: map['title'] ?? 'Unknown Item',
      imageUrl: map['imageUrl'] ?? 'https://placehold.co/600x400',
      currentBid: (map['currentBid'] ?? 0).toDouble(),
      lastBidder: map['lastBidder'] ?? 'No bids yet',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'currentBid': currentBid,
      'lastBidder': lastBidder,
    };
  }
}
