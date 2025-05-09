import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  List<ParseObject> members = [];

  @override
  void initState() {
    super.initState();
    fetchMembers(); // Load data initially
  }

  Future<void> fetchMembers() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Member'));
    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        print('Fetched members: ${response.results!.length}');
        members = List<ParseObject>.from(response.results!);
      });
    }
  }

  Future<void> addMember() async {
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());

    if (name.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid Name and Age')),
      );
      return;
    }

    final member = ParseObject('Member')
      ..set('Name', name)
      ..set('Age', age);

    await member.save();
    nameController.clear();
    ageController.clear();
    fetchMembers(); // Refresh the list
  }

  void showEditDialog(ParseObject member) {
    final editNameController = TextEditingController(text: member.get<String>('Name'));
    final editAgeController = TextEditingController(text: member.get<int>('Age')?.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editNameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: editAgeController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Update'),
            onPressed: () async {
              final updatedName = editNameController.text.trim();
              final updatedAge = int.tryParse(editAgeController.text.trim());

              if (updatedName.isEmpty || updatedAge == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Enter valid Name and Age')),
                );
                return;
              }

              member
                ..set('Name', updatedName)
                ..set('Age', updatedAge);

              await member.save();
              Navigator.of(context).pop();
              fetchMembers(); // Refresh list
            },
          )
        ],
      ),
    );
  }

  Future<void> deleteMember(ParseObject member) async {
    await member.delete();
    fetchMembers(); // Refresh list
  }

  Future<void> logoutUser() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      final response = await user.logout();
      if (response.success) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: ${response.error?.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Members'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
            logoutUser();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: addMember,
              child: Text('Add Member'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return ListTile(
                    title: Text(member.get<String>('Name') ?? ''),
                    subtitle: Text('Age: ${member.get<int>('Age')}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            showEditDialog(member);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteMember(member);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}