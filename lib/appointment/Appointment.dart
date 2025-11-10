import 'package:flutter/material.dart';
import '../component/Navbar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form data
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedService;
  final TextEditingController _notesController = TextEditingController();

  // Service options
  final List<Map<String, dynamic>> services = [
    {'name': 'Oil Change', 'duration': '30 min', 'price': 'Rs. 3,500'},
    {'name': 'Brake Service', 'duration': '1 hour', 'price': 'Rs. 8,500'},
    {'name': 'Tire Rotation', 'duration': '45 min', 'price': 'Rs. 2,500'},
    {'name': 'Full Service', 'duration': '2 hours', 'price': 'Rs. 15,000'},
    {'name': 'Engine Diagnostic', 'duration': '1 hour', 'price': 'Rs. 5,500'},
    {'name': 'AC Service', 'duration': '1.5 hours', 'price': 'Rs. 7,000'},
    {'name': 'Battery Check', 'duration': '20 min', 'price': 'Rs. 1,500'},
    {'name': 'Wheel Alignment', 'duration': '1 hour', 'price': 'Rs. 4,500'},
  ];

  // Mock appointment data with timeline
  final List<Map<String, dynamic>> appointments = [
    {
      'id': '001',
      'service': 'Full Service',
      'date': 'Nov 10, 2025',
      'time': '10:00 AM',
      'status': 'In Progress',
      'timeline': [
        {'step': 'Appointment Booked', 'completed': true, 'time': '9:00 AM'},
        {'step': 'Vehicle Received', 'completed': true, 'time': '10:00 AM'},
        {'step': 'Service In Progress', 'completed': true, 'time': '10:15 AM'},
        {'step': 'Quality Check', 'completed': false, 'time': 'Pending'},
        {'step': 'Ready for Pickup', 'completed': false, 'time': 'Pending'},
      ],
      'technician': 'Kasun Silva',
      'vehicle': 'Toyota Corolla - ABC-1234',
    },
    {
      'id': '002',
      'service': 'Oil Change',
      'date': 'Nov 05, 2025',
      'time': '2:00 PM',
      'status': 'Completed',
      'timeline': [
        {'step': 'Appointment Booked', 'completed': true, 'time': '1:30 PM'},
        {'step': 'Vehicle Received', 'completed': true, 'time': '2:00 PM'},
        {'step': 'Service In Progress', 'completed': true, 'time': '2:10 PM'},
        {'step': 'Quality Check', 'completed': true, 'time': '2:35 PM'},
        {'step': 'Ready for Pickup', 'completed': true, 'time': '2:40 PM'},
      ],
      'technician': 'Nuwan Perera',
      'vehicle': 'Toyota Corolla - ABC-1234',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onNavBarTap(int index) {
    if (index == 2) return;
    final routes = ['/home', '/service', '/appointment', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00E676),
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1E1E1E),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00E676),
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _bookAppointment() {
    if (selectedDate == null || selectedTime == null || selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00E676).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF00E676),
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Appointment Booked!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your appointment for $selectedService has been confirmed',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedDate = null;
                  selectedTime = null;
                  selectedService = null;
                  _notesController.clear();
                  _tabController.animateTo(1);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View My Appointments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF00E676),
          indicatorWeight: 3,
          labelColor: const Color(0xFF00E676),
          dividerColor: Color(0xFF121212),
          unselectedLabelColor: Colors.white54,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Book Appointment'),
            Tab(text: 'My Appointments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingTab(),
          _buildAppointmentsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: _onNavBarTap),
    );
  }

  Widget _buildBookingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Schedule Your Service',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select your preferred date, time, and service',
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 32),

          // Date Selection
          _buildSectionLabel('Select Date'),
          InkWell(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedDate != null
                      ? const Color(0xFF00E676)
                      : const Color(0xFF3A3A3A),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF00E676)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : 'Choose a date',
                      style: TextStyle(
                        color: selectedDate != null ? Colors.white : Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Time Selection
          _buildSectionLabel('Select Time'),
          InkWell(
            onTap: _selectTime,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedTime != null
                      ? const Color(0xFF00E676)
                      : const Color(0xFF3A3A3A),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Color(0xFF00E676)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : 'Choose a time',
                      style: TextStyle(
                        color: selectedTime != null ? Colors.white : Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Service Selection
          _buildSectionLabel('Select Service'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedService != null
                    ? const Color(0xFF00E676)
                    : const Color(0xFF3A3A3A),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedService,
                hint: const Text(
                  'Choose a service',
                  style: TextStyle(color: Colors.white54),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00E676)),
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                items: services.map((service) {
                  return DropdownMenuItem<String>(
                    value: service['name'],
                    child: Row(
                      children: [
                        const Icon(Icons.build, color: Color(0xFF00E676), size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(service['name']!),
                              Text(
                                '${service['duration']} • ${service['price']}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedService = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Additional Notes
          _buildSectionLabel('Additional Notes (Optional)'),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF3A3A3A)),
            ),
            child: TextField(
              controller: _notesController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Any specific requirements or concerns...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Book Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _bookAppointment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Book Appointment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAppointmentsTab() {
    return appointments.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointments[index]);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: appointment['status'] == 'In Progress'
              ? const Color(0xFF00E676)
              : const Color(0xFF3A3A3A),
          width: appointment['status'] == 'In Progress' ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.car_repair,
                    color: Color(0xFF00E676),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['service'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.white54),
                          const SizedBox(width: 4),
                          Text(
                            '${appointment['date']} • ${appointment['time']}',
                            style: const TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: appointment['status'] == 'Completed'
                        ? Colors.green.withOpacity(0.2)
                        : const Color(0xFF00E676).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    appointment['status'],
                    style: TextStyle(
                      color: appointment['status'] == 'Completed'
                          ? Colors.green
                          : const Color(0xFF00E676),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          const Divider(color: Color(0xFF3A3A3A), height: 1),

          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_car, size: 16, color: Colors.white54),
                    const SizedBox(width: 8),
                    Text(
                      appointment['vehicle'],
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.person, size: 16, color: Colors.white54),
                    const SizedBox(width: 8),
                    Text(
                      'Technician: ${appointment['technician']}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Timeline
          _buildTimeline(appointment['timeline']),

          // Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone, size: 18),
                    label: const Text('Contact'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00E676),
                      side: const BorderSide(color: Color(0xFF00E676)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (appointment['status'] != 'Completed')
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showCancelDialog(context);
                      },
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(List<Map<String, dynamic>> timeline) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF121212),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Service Timeline',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...timeline.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> step = entry.value;
            bool isLast = index == timeline.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: step['completed']
                            ? const Color(0xFF00E676)
                            : const Color(0xFF3A3A3A),
                        border: Border.all(
                          color: step['completed']
                              ? const Color(0xFF00E676)
                              : const Color(0xFF3A3A3A),
                          width: 2,
                        ),
                      ),
                      child: step['completed']
                          ? const Icon(Icons.check, size: 16, color: Colors.black)
                          : null,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: step['completed']
                            ? const Color(0xFF00E676)
                            : const Color(0xFF3A3A3A),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['step'],
                          style: TextStyle(
                            color: step['completed'] ? Colors.white : Colors.white54,
                            fontSize: 15,
                            fontWeight: step['completed']
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step['time'],
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: 80,
              color: Color(0xFF00E676),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Appointments Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Book your first service appointment',
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _tabController.animateTo(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Book Appointment',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Cancel Appointment',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'No, Keep It',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}