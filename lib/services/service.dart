import 'package:flutter/material.dart';

import '../component/Navbar.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedCategory = 'All';

  void _onNavBarTap(int index) {
    // Don't navigate if already on the current page
    if (index == 1) return;

    final routes = ['/home', '/service', '/appointment', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  final List<String> categories = [
    'All',
    'Maintenance',
    'Repair',
    'Detailing',
    'Emergency'
  ];

  final List<Map<String, dynamic>> services = [
    {
      'name': 'Oil Change',
      'category': 'Maintenance',
      'description': 'Complete oil and filter replacement service',
      'price': '\$45',
      'duration': '30 min',
      'icon': Icons.oil_barrel,
      'color': const Color(0xFF00E676),
      'popular': true,
    },
    {
      'name': 'Full Car Wash',
      'category': 'Detailing',
      'description': 'Exterior and interior deep cleaning',
      'price': '\$30',
      'duration': '45 min',
      'icon': Icons.local_car_wash,
      'color': const Color(0xFF00B8D4),
      'popular': true,
    },
    {
      'name': 'Brake Service',
      'category': 'Repair',
      'description': 'Brake pad replacement and inspection',
      'price': '\$120',
      'duration': '1.5 hr',
      'icon': Icons.settings,
      'color': const Color(0xFFFF6B6B),
      'popular': false,
    },
    {
      'name': 'Tire Rotation',
      'category': 'Maintenance',
      'description': 'Tire rotation and pressure check',
      'price': '\$25',
      'duration': '20 min',
      'icon': Icons.tire_repair,
      'color': const Color(0xFFFFB800),
      'popular': false,
    },
    {
      'name': 'Engine Diagnostics',
      'category': 'Repair',
      'description': 'Complete engine system check',
      'price': '\$80',
      'duration': '1 hr',
      'icon': Icons.miscellaneous_services,
      'color': const Color(0xFFAA00FF),
      'popular': true,
    },
    {
      'name': 'Battery Check',
      'category': 'Maintenance',
      'description': 'Battery health test and replacement',
      'price': '\$15',
      'duration': '15 min',
      'icon': Icons.battery_charging_full,
      'color': const Color(0xFF00E676),
      'popular': false,
    },
    {
      'name': 'AC Service',
      'category': 'Repair',
      'description': 'AC system inspection and recharge',
      'price': '\$90',
      'duration': '1 hr',
      'icon': Icons.ac_unit,
      'color': const Color(0xFF00B8D4),
      'popular': false,
    },
    {
      'name': 'Premium Detailing',
      'category': 'Detailing',
      'description': 'Complete interior and exterior detailing',
      'price': '\$150',
      'duration': '3 hr',
      'icon': Icons.auto_awesome,
      'color': const Color(0xFFFFB800),
      'popular': true,
    },
    {
      'name': 'Wheel Alignment',
      'category': 'Maintenance',
      'description': 'Professional wheel alignment service',
      'price': '\$75',
      'duration': '45 min',
      'icon': Icons.straighten,
      'color': const Color(0xFFFF6B6B),
      'popular': false,
    },
    {
      'name': '24/7 Roadside',
      'category': 'Emergency',
      'description': 'Emergency roadside assistance',
      'price': '\$60',
      'duration': 'Varies',
      'icon': Icons.emergency,
      'color': const Color(0xFFFF6B6B),
      'popular': false,
    },
    {
      'name': 'Transmission Service',
      'category': 'Repair',
      'description': 'Transmission fluid change and inspection',
      'price': '\$130',
      'duration': '2 hr',
      'icon': Icons.build,
      'color': const Color(0xFFAA00FF),
      'popular': false,
    },
    {
      'name': 'Headlight Restoration',
      'category': 'Detailing',
      'description': 'Headlight cleaning and restoration',
      'price': '\$50',
      'duration': '30 min',
      'icon': Icons.lightbulb,
      'color': const Color(0xFFFFB800),
      'popular': false,
    },
  ];

  List<Map<String, dynamic>> get filteredServices {
    if (selectedCategory == 'All') {
      return services;
    }
    return services
        .where((service) => service['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our Services',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${filteredServices.length} services available',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2328),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Category Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF00E676)
                                  : const Color(0xFF1E2328),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF00E676)
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF0F1419)
                                      : Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Services List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return _buildServiceCard(service);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: _onNavBarTap,
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2328),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: service['color'].withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showServiceDetails(service);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Service Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        service['color'].withOpacity(0.2),
                        service['color'].withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: service['color'].withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    service['icon'],
                    color: service['color'],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),

                // Service Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (service['popular'])
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00E676).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Popular',
                                style: TextStyle(
                                  color: const Color(0xFF00E676),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        service['description'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            service['duration'],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.attach_money,
                            size: 14,
                            color: service['color'],
                          ),
                          Text(
                            service['price'],
                            style: TextStyle(
                              color: service['color'],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceDetails(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF1E2328),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Handle Bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Icon and Name
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                service['color'].withOpacity(0.3),
                                service['color'].withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: service['color'].withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            service['icon'],
                            color: service['color'],
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: service['color'].withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  service['category'],
                                  style: TextStyle(
                                    color: service['color'],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['description'],
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Details
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F1419),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            Icons.access_time,
                            'Duration',
                            service['duration'],
                          ),
                          const Divider(height: 24, color: Color(0xFF2A2F35)),
                          _buildDetailRow(
                            Icons.attach_money,
                            'Price',
                            service['price'],
                          ),
                          const Divider(height: 24, color: Color(0xFF2A2F35)),
                          _buildDetailRow(
                            Icons.location_on,
                            'Location',
                            'At our service center',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // What's Included
                    Text(
                      "What's Included",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildIncludedItem('Professional technician service'),
                    _buildIncludedItem('Quality parts and materials'),
                    _buildIncludedItem('Service warranty'),
                    _buildIncludedItem('Free vehicle inspection'),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Book Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2328),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[800]!,
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to booking screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E676),
                    foregroundColor: const Color(0xFF0F1419),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Book This Service',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00E676), size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: const Color(0xFF00E676),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}