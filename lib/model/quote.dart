class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  Map<String, dynamic> toJson() => {
    'text': text,
    'author': author,
  };

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    text: json['text'],
    author: json['author'],
  );

  // FireStore
  // factory Quote.fromJson(Map<String, dynamic> json) => Quote(
  //   text: json['text'] ?? '',
  //   author: json['author'] ?? '',
  // );

}