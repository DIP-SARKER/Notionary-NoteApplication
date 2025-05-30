class Note {
  final String title;
  final String content;
  final String date;
  final String category;

  Note({
    required this.title,
    required this.content,
    required this.date,
    required this.category,
  });

  static List<Note> notes = [
    Note(
      title: 'Meeting Notes',
      content: 'Discuss project timeline with team',
      date: 'Today, 10:30 AM',
      category: 'Work',
    ),
    Note(
      title: 'Shopping List',
      content: 'Milk, Eggs, Bread, Fruits',
      date: 'Yesterday',
      category: 'Personal',
    ),
    Note(
      title: 'App Ideas',
      content: 'Create a habit tracking feature',
      date: 'May 28',
      category: 'Ideas',
    ),
    Note(
      title: 'Vacation Plan',
      content: 'Research hotels in Bali',
      date: 'May 25',
      category: 'To-Do',
    ),
    Note(
      title: 'Grocery List',
      content: 'Buy vegetables and fruits',
      date: 'May 20',
      category: 'Personal',
    ),
    Note(
      title: 'Project Update',
      content: 'Send the latest project updates to the client',
      date: 'May 18',
      category: 'Work',
    ),
    Note(
      title: 'Book Recommendations',
      content: 'Read "Atomic Habits" and "The Subtle Art of Not Giving a F*ck"',
      date: 'May 15',
      category: 'Ideas',
    ),
    Note(
      title: 'Weekend Plans',
      content: 'Hiking trip with friends',
      date: 'May 10',
      category: 'To-Do',
    ),
  ];
}
