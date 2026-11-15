import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color primaryBlue = Color(0xFF4169E1);
const Color backgroundColor = Color(0xFFF4F6FA);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final isDark = prefs.getBool('app_theme_dark_mode') ?? false;
  final username = prefs.getString('user_display_name') ?? 'Guest User';

  List<NoteItem> notes = [];

  final savedNotes = prefs.getString('saved_notes');

  if (savedNotes != null) {
    try {
      final List decoded = jsonDecode(savedNotes);

      notes = decoded
          .map((item) => NoteItem.fromJson(item))
          .toList();
    } catch (error) {
      notes = [];
    }
  }

  runApp(
    MyApp(
      prefs: prefs,
      initialDarkMode: isDark,
      initialUsername: username,
      initialNotes: notes,
    ),
  );
}


class NoteItem {
  final String id;
  final String title;
  final String dateText;
  bool isCompleted;

  NoteItem({
    required this.id,
    required this.title,
    required this.dateText,
    this.isCompleted = false,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateText': dateText,
      'isCompleted': isCompleted,
    };
  }


  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(
      id: json['id'] as String,
      title: json['title'] as String,
      dateText: json['dateText'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}


class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  final bool initialDarkMode;
  final String initialUsername;
  final List<NoteItem> initialNotes;

  const MyApp({
    super.key,
    required this.prefs,
    required this.initialDarkMode,
    required this.initialUsername,
    required this.initialNotes,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.initialDarkMode;
  }

  void changeTheme(bool value) async {
    setState(() {
      isDarkMode = value;
    });

    await widget.prefs.setBool(
      'app_theme_dark_mode',
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Vault',

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      home: NotesScreen(
        prefs: widget.prefs,
        username: widget.initialUsername,
        initialNotes: widget.initialNotes,
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
      ),
    );
  }
}


class NotesScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final String username;
  final List<NoteItem> initialNotes;
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const NotesScreen({
    super.key,
    required this.prefs,
    required this.username,
    required this.initialNotes,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<NoteItem> notes;

  late TextEditingController nameController;
  final TextEditingController noteController = TextEditingController();

  late String username;

  @override
  void initState() {
    super.initState();

    notes = widget.initialNotes;
    username = widget.username;

    nameController = TextEditingController(
      text: username == 'Guest User' ? '' : username,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    noteController.dispose();
    super.dispose();
  }


  void saveUsername() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return;

    await widget.prefs.setString(
      'user_display_name',
      name,
    );

    setState(() {
      username = name;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Username saved!'),
      ),
    );
  }


  Future<void> saveNotes() async {
    final String jsonString = jsonEncode(
      notes.map((note) => note.toJson()).toList(),
    );

    await widget.prefs.setString(
      'saved_notes',
      jsonString,
    );
  }


  void addNote() async {
    final title = noteController.text.trim();

    if (title.isEmpty) return;

    final newNote = NoteItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      dateText: DateTime.now().toString().substring(0, 10),
    );

    setState(() {
      notes.insert(0, newNote);
      noteController.clear();
    });

    await saveNotes();
  }


  void toggleNote(int index, bool value) async {
    setState(() {
      notes[index].isCompleted = value;
    });

    await saveNotes();
  }


  void deleteNote(int index) async {
    setState(() {
      notes.removeAt(index);
    });

    await saveNotes();
  }


  Widget buildNoteCard(int index) {
    final note = notes[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Checkbox(
            value: note.isCompleted,
            activeColor: primaryBlue,
            onChanged: (value) {
              toggleNote(index, value ?? false);
            },
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: note.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: note.isCompleted
                        ? Colors.grey
                        : null,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  note.dateText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              deleteNote(index);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        notes.where((note) => note.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes Vault',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: primaryBlue,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Hello, $username!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Manage your personal notes',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),


            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Theme.of(context)
                          .scaffoldBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: saveUsername,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save Name'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),


            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Save your theme preference',
                ),
                secondary: const Icon(
                  Icons.dark_mode_outlined,
                  color: primaryBlue,
                ),
                value: widget.isDarkMode,
                activeThumbColor: primaryBlue,
                onChanged: widget.onThemeChanged,
              ),
            ),

            const SizedBox(height: 24),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Notes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '$completedCount / ${notes.length} completed',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),


            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      hintText: 'Write a new note...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: addNote,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Note'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),


            if (notes.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 55,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No notes yet',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...List.generate(
                notes.length,
                (index) => buildNoteCard(index),
              ),
          ],
        ),
      ),
    );
  }
}
