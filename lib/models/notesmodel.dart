class Note {
  final String title;
  final String content;
  final String text;
  final String createdAt;
  final String modifiedAt;
  final String category;

  Note({
    required this.title,
    required this.content,
    required this.text,
    required this.createdAt,
    required this.modifiedAt,
    required this.category,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      content: json['content'],
      text: json['text'],
      createdAt: json['createdAt'],
      modifiedAt: json['modifiedAt'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'text': text,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'category': category,
    };
  }
}
