class Note {
  final String id;
  final String text;
  final String title;
  final int colorIndex;
  final String posterId;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  const Note({
    required this.id,
    required this.text,
    required this.title,
    required this.posterId,
    required this.colorIndex,
    required this.dateCreated,
    required this.dateUpdated,
  });

  // converts an object of our class to a map for sending to firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'title': title,
      'colorIndex': colorIndex,
      'posterId': posterId,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateUpdated': dateUpdated.millisecondsSinceEpoch,
    };
  }

  // Called on our class iteself,
  // takes a map as argument and returns an object of Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      text: map['text'] as String,
      title: map['title'] as String,
      colorIndex: map['colorIndex'] as int,
      posterId: map['posterId'] as String,
      dateCreated:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
      dateUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['dateUpdated'] as int),
    );
  }
}
