import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDemoActive = false;
  int _selectedDrawerIndex = 0; // साइडबार नेविगेशन ट्रैकिंग के लिए

  final List<Map<String, dynamic>> recentComplaints = [
    {'title': 'Overflowing Bin', 'ward': 'Ward 2', 'time': '25 min ago', 'status': 'Pending', 'icon': Icons.delete_outline},
    {'title': 'Water leakage', 'ward': 'Ward 5', 'time': '1 hour ago', 'status': 'Assigned', 'icon': Icons.water_drop_outlined},
    {'title': 'Street light not working', 'ward': 'Ward 1', 'time': '2 hours ago', 'status': 'Pending', 'icon': Icons.lightbulb_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0D0F1D),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildStatsSection(),
              const SizedBox(height: 20),
              _buildGpsTrackingSection(),
              const SizedBox(height: 20),
              _buildRecentComplaintsSection(),
              const SizedBox(height: 20),
              _buildVehicleStatusSection(),
              const SizedBox(height: 20),
              _buildQuickActionsSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(Icons.menu, color: Colors.white70),
          style: IconButton.styleFrom(backgroundColor: const Color(0xFF181B34), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(color: const Color(0xFF181B34), borderRadius: BorderRadius.circular(12)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search tasks, vehicles...',
                  hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.white54, size: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, color: Colors.white70, size: 20),
          style: IconButton.styleFrom(backgroundColor: const Color(0xFF181B34), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF38BDF8)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Good day, Operator 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 6),
          const Text("Here's what's happening with your city services today.", style: TextStyle(fontSize: 13, color: Colors.white70)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              _buildBadge(Icons.local_shipping, 'Active Routes'),
              _buildBadge(Icons.eco, 'Collection Metrics'),
              _buildBadge(Icons.warning_amber, 'Action Required', isAlert: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text, {bool isAlert = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withOpacity(isAlert ? 0.25 : 0.15), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return GridView.count(
      crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.4,
      children: [
        _buildStatCard('Total Trucks', 'Manage Fleet', Icons.local_shipping, Colors.indigo),
        _buildStatCard('Total Bins', 'Bin Status', Icons.delete_outline, Colors.teal),
        _buildStatCard('Open Complaints', 'Review Open', Icons.warning_amber_rounded, Colors.amber),
        _buildStatCard('Employees', 'Staff Active', Icons.group_outlined, Colors.green),
      ],
    );
  }

  Widget _buildStatCard(String title, String subtitle, IconData icon, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181B34), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: accentColor, size: 22),
              const Icon(Icons.show_chart, color: Colors.white30, size: 18),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white60, fontSize: 12)),
              const SizedBox(height: 2),
              const Text('System Live', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(subtitle, style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildGpsTrackingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181B34), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Live GPS Tracking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 2),
                  Text('Monitor collection vehicles in real time', style: TextStyle(fontSize: 12, color: Colors.white54)),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening Full Map View...')));
                },
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: const Text('View Full Map ↗', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 180, width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFF0D0F1D), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 40, color: Colors.indigo.withOpacity(0.5)),
                      const SizedBox(height: 8),
                      Text(isDemoActive ? 'Simulating Fleet Routes...' : 'Interactive GPS Ready', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 12, left: 12, right: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () { setState(() { isDemoActive = !isDemoActive; }); },
                        icon: Icon(isDemoActive ? Icons.pause : Icons.play_arrow, size: 14),
                        label: Text(isDemoActive ? 'Pause Demo' : 'Start Demo', style: const TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(backgroundColor: isDemoActive ? Colors.amber : Colors.indigo, foregroundColor: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () { setState(() { isDemoActive = false; }); },
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24)),
                        child: const Text('Reset', style: TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentComplaintsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181B34), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Complaints', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigating to Complaints Panel...')));
                },
                child: const Text('View All', style: TextStyle(color: Color(0xFF38BDF8), fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            itemCount: recentComplaints.length,
            itemBuilder: (context, index) {
              final item = recentComplaints[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6), padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFF0D0F1D), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white10)),
                child: Row(
                  children: [
                    Icon(item['icon'], color: Colors.white70, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 2),
                          Text('${item['ward']} • ${item['time']}', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          recentComplaints[index]['status'] = 'Resolved';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complaint marked as resolved')));
                      },
                      child: Text(item['status'], style: const TextStyle(color: Colors.amber, fontSize: 11)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleStatusSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181B34), borderRadius: BorderRadius.circular(16)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vehicle Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 2),
          Text('Fleet overview & operational status', style: TextStyle(fontSize: 12, color: Colors.white54)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatusLegendItem(color: Colors.green, label: 'On Route'),
              _StatusLegendItem(color: Colors.cyan, label: 'Idle'),
              _StatusLegendItem(color: Colors.amber, label: 'Maintenance'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181B34), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 2),
          const Text('Common admin operations', style: TextStyle(fontSize: 12, color: Colors.white54)),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 2.2,
            children: [
              _buildActionCard(Icons.add, 'Assign Task', 'Create collection task'),
              _buildActionCard(Icons.local_shipping, 'Add Vehicle', 'Register new vehicle'),
              _buildActionCard(Icons.list_alt, 'View Complaints', 'Review open complaints'),
              _buildActionCard(Icons.bar_chart, 'View Reports', 'Check analytics'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String title, String subtitle) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Action Selected: $title')));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFF0D0F1D), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF38BDF8), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // पूरी तरह फंक्शनल साइडबार (अब हर ऑप्शन क्लिक करने पर नेविगेट या रिस्पांस देगा)
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF181B34),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0D0F1D)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Eco Track', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('City Services Management', style: TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
          _buildDrawerItem(Icons.location_on_outlined, 'Live GPS Tracking', 1),
          _buildDrawerItem(Icons.local_shipping_outlined, 'Vehicle Management', 2),
          _buildDrawerItem(Icons.assignment_outlined, 'Task Management', 3),
          _buildDrawerItem(Icons.group_outlined, 'Employees', 4),
          _buildDrawerItem(Icons.report_problem_outlined, 'Complaints', 5),
          _buildDrawerItem(Icons.home_outlined, 'Residents', 6),
          _buildDrawerItem(Icons.star_outline, 'Other Services', 7),
          _buildDrawerItem(Icons.alt_route, 'Route Optimization', 8),
          _buildDrawerItem(Icons.analytics_outlined, 'Analytics & Reports', 9),
          _buildDrawerItem(Icons.notifications_none, 'Notifications', 10),
          _buildDrawerItem(Icons.settings_outlined, 'Settings', 11),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    bool isSelected = _selectedDrawerIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF6366F1) : Colors.white70, size: 20),
      title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      selectedTileColor: const Color(0xFF6366F1).withOpacity(0.2),
      onTap: () {
        setState(() {
          _selectedDrawerIndex = index;
        });
        Navigator.pop(context); // ड्रॉअर बंद करें
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Switched to $title')));
      },
    );
  }
}

class _StatusLegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _StatusLegendItem({Key? key, required this.color, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}