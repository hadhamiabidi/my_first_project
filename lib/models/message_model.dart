class Conversation {
  final String sender;
  final String text;
  final DateTime timestamp;
  final String clientId;
  final String driverId;

  Conversation({
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.clientId,
    required this.driverId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      sender: json['sender'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
      clientId: json['client_id'],
      driverId: json['driver_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'client_id': clientId,
      'driver_id': driverId,
    };
  }
}

