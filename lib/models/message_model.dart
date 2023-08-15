class GetDataMessage {
  String name;
  String location;
  String timestamp;

  GetDataMessage({
    required this.name,
    required this.location,
    required this.timestamp,
  });

  factory GetDataMessage.fromJson(Map<String, dynamic> json) => GetDataMessage(
        name: json['name'],
        location: json['location'],
        timestamp: json['timestamp'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'location': location,
        'timestamp': timestamp,
      };
}
