
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Study Planner',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4967E8),
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),
      home: const StudyPlannerScreen(),
    );
  }
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() =>
      _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {

  // LOGIC: Stores all study goals
  List<Map<String, dynamic>> goals = [
    {
      'subject': 'Mathematics',
      'hours': 3,
      'done': false,
    },
    {
      'subject': 'Programming',
      'hours': 2,
      'done': false,
    },
    {
      'subject': 'Networking',
      'hours': 4,
      'done': false,
    },
  ];

  // LOGIC: Marks a goal as completed or incomplete
  void toggleGoal(int index, bool value) {
    setState(() {
      goals[index]['done'] = value;
    });
  }

  // LOGIC: Deletes a selected study goal
  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  // LOGIC: Adds a new sample study goal
  void addGoal() {
    setState(() {
      goals.add({
        'subject': 'English',
        'hours': 2,
        'done': false,
      });
    });
  }

  // LOGIC: Calculates total study hours using fold()
  int get totalHours {
    return goals.fold<int>(
      0,
      (sum, goal) => sum + (goal['hours'] as int),
    );
  }

  // LOGIC: Counts completed goals using where()
  int get completedGoals {
    return goals.where((goal) => goal['done'] == true).length;
  }

  // LOGIC: Counts remaining goals
  int get remainingGoals {
    return goals.length - completedGoals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // STATIC: AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Study Planner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF24345A),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      // STATIC: Main screen content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // STATIC: Welcome heading
            const Text(
              'Hello, Student! 👋',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF24345A),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Ready to achieve your study goals?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // STATIC: Study overview card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4967E8),
                    Color(0xFF7956D8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOUR STUDY JOURNEY',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Make every hour count!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Small steps today, great achievements tomorrow.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // STATIC: Statistics heading
            const Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF24345A),
              ),
            ),

            const SizedBox(height: 12),

            // CONNECTION: Connects calculated values to statistics cards
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Total Hours',
                    value: '$totalHours',
                    icon: Icons.access_time,
                    color: const Color(0xFF4967E8),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatCard(
                    title: 'Completed',
                    value: '$completedGoals',
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatCard(
                    title: 'Remaining',
                    value: '$remainingGoals',
                    icon: Icons.flag_outlined,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // STATIC: Study goals heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Study Goals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF24345A),
                  ),
                ),
                Text(
                  '${goals.length} Goals',
                  style: const TextStyle(
                    color: Color(0xFF4967E8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // CONNECTION: Displays goals from the goals list
            if (goals.isEmpty)

              // STATIC: Friendly empty-state message
              const Padding(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No study goals yet.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24345A),
                        ),
                      ),
                      Text(
                        'Tap the + button to add your first goal!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];

                  return Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),

                      // CONNECTION: Checkbox connects UI to completion logic
                      leading: Checkbox(
                        value: goal['done'],
                        activeColor: const Color(0xFF4967E8),
                        onChanged: (value) {
                          if (value != null) {
                            toggleGoal(index, value);
                          }
                        },
                      ),

                      title: Text(
                        goal['subject'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: goal['done']
                              ? Colors.grey
                              : const Color(0xFF24345A),
                          decoration: goal['done']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),

                      subtitle: Text(
                        '${goal['hours']} Hours',
                        style: TextStyle(
                          color: goal['done']
                              ? Colors.grey
                              : Colors.black54,
                        ),
                      ),

                      // CONNECTION: Connects delete button to delete logic
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (goal['done'])
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              deleteGoal(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),

      // CONNECTION: Connects the + button to add-goal logic
      floatingActionButton: FloatingActionButton(
        onPressed: addGoal,
        backgroundColor: const Color(0xFF4967E8),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// STATIC: Reusable statistics card widget
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 23,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF24345A),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
