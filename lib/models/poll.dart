class Poll {
  final String id;
  final String topic;
  final String question;
  final String pollType;
  final List<String> textOptions;
  final String? imageUrl; // Optional field for image URL
  final bool isAnonymous;

  Poll({
    required this.id,
    required this.topic,
    required this.question,
    required this.pollType,
    required this.textOptions,
    this.imageUrl,
    required this.isAnonymous,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      topic: json['topic'],
      question: json['question'],
      pollType: json['poll_type'],
      textOptions: List<String>.from(json['text_options']),
      imageUrl:
          json['image_url'], // Assuming the key for image URL is 'image_url'
      isAnonymous: json['is_anonymous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'question': question,
      'poll_type': pollType,
      'text_options': textOptions,
      'image_url': imageUrl,
      'is_anonymous': isAnonymous,
    };
  }
}
