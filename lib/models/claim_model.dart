class Claim {
  final String uid;
  final String title;
  final String description;
  final String date;

  Claim({
    required this.uid,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}
