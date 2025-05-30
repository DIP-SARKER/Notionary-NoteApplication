class Note {
  final String title;
  final String content;
  final String createdAt;
  final String modifiedAt;
  final String category;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
    required this.category,
  });

  static List<Note> notes = [
    Note(
      title: 'Meeting Notes',
      content: 'Discuss project timeline with team',
      createdAt: '2023-10-01 10:00',
      modifiedAt: '2023-10-01 12:00',
      category: 'Work',
    ),
    Note(
      title: 'Shopping List',
      content: 'Milk, Eggs, Bread, Fruits',
      createdAt: '2023-10-02 09:30',
      modifiedAt: '2023-10-02 10:00',
      category: 'Personal',
    ),
    Note(
      title: 'App Ideas',
      content: 'Create a habit tracking feature',
      createdAt: '2023-10-03 14:00',
      modifiedAt: '2023-10-03 15:00',
      category: 'Ideas',
    ),
    Note(
      title: 'Vacation Plan',
      content: 'Research hotels in Bali',
      createdAt: '2023-10-04 11:00',
      modifiedAt: '2023-10-04 12:30',
      category: 'To-Do',
    ),
    Note(
      title: 'Grocery List',
      content: 'Buy vegetables and fruits',
      createdAt: "2023-10-05 08:00",
      modifiedAt: "2023-10-05 09:00",
      category: 'Personal',
    ),
    Note(
      title: 'Project Update',
      content: 'Send the latest project updates to the client',
      createdAt: '2023-10-06 13:00',
      modifiedAt: '2023-10-06 14:00',
      category: 'Work',
    ),
    Note(
      title: 'Book Recommendations',
      content: 'Read "Atomic Habits" and "The Subtle Art of Not Giving a F*ck"',
      createdAt: '2023-10-07 16:00',
      modifiedAt: '2023-10-07 17:00',
      category: 'Ideas',
    ),
    Note(
      title: 'Weekend Plans',
      content: 'Hiking trip with friends',
      createdAt: '2023-10-08 10:00',
      modifiedAt: '2023-10-08 11:00',
      category: 'To-Do',
    ),
  ];
}
