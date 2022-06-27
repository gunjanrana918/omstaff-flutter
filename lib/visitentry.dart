import 'package:employee_attendance/empvisitentry.dart';
import 'package:employee_attendance/visitmis.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp());
}

class visitentry extends StatefulWidget {
  const visitentry({Key? key}) : super(key: key);

  @override
  State<visitentry> createState() => _visitentryState();
}

class _visitentryState extends State<visitentry>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.black,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.assignment_rounded,
                  size: 20.0,
                ),
                text: 'Emp Visit Entry',
              ),
              Tab(
                icon: Icon(
                  Icons.assignment,
                  size: 20,
                ),
                text: 'Visit MIS',
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          empvisitentry(),
          visitmis(),
        ],
      ),
    );
  }
}
