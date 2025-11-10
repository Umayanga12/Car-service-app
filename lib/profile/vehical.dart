import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({Key? key}) : super(key: key);

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Form controllers
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _vinController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();

  String? selectedFuelType;
  String? selectedTransmission;

  // Fuel type options
  final List<String> fuelTypes = [
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid',
    'CNG',
    'LPG',
  ];

  // Transmission options
  final List<String> transmissions = [
    'Manual',
    'Automatic',
    'Semi-Automatic',
    'CVT',
  ];

  // Mock vehicle data
  final List<Map<String, dynamic>> vehicles = [
    {
      'id': '001',
      'make': 'Toyota',
      'model': 'Corolla',
      'year': '2020',
      'plate': 'ABC-1234',
      'color': 'White',
      'fuelType': 'Petrol',
      'transmission': 'Automatic',
      'mileage': '45,000 km',
      'vin': '1HGBH41JXMN109186',
      'isPrimary': true,
      'lastService': 'Nov 05, 2025',
      'nextService': 'Feb 05, 2026',
    },
    {
      'id': '002',
      'make': 'Honda',
      'model': 'Civic',
      'year': '2019',
      'plate': 'XYZ-5678',
      'color': 'Black',
      'fuelType': 'Petrol',
      'transmission': 'Manual',
      'mileage': '62,000 km',
      'vin': '2HGFC2F59KH542391',
      'isPrimary': false,
      'lastService': 'Oct 20, 2025',
      'nextService': 'Jan 20, 2026',
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
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _vinController.dispose();
    _colorController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  void _addVehicle() {
    if (_makeController.text.isEmpty ||
        _modelController.text.isEmpty ||
        _yearController.text.isEmpty ||
        _plateController.text.isEmpty) {
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
              'Vehicle Added!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_makeController.text} ${_modelController.text} has been added to your garage',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _makeController.clear();
                  _modelController.clear();
                  _yearController.clear();
                  _plateController.clear();
                  _vinController.clear();
                  _colorController.clear();
                  _mileageController.clear();
                  selectedFuelType = null;
                  selectedTransmission = null;
                  _tabController.animateTo(0);
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
                'View My Vehicles',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Vehicles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF00E676),
          indicatorWeight: 3,
          labelColor: const Color(0xFF00E676),
          dividerColor: const Color(0xFF121212),
          unselectedLabelColor: Colors.white54,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'My Garage'),
            Tab(text: 'Add Vehicle'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVehiclesTab(),
          _buildAddVehicleTab(),
        ],
      ),
    );
  }

  Widget _buildVehiclesTab() {
    return vehicles.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        return _buildVehicleCard(vehicles[index]);
      },
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: vehicle['isPrimary']
              ? const Color(0xFF00E676)
              : const Color(0xFF3A3A3A),
          width: vehicle['isPrimary'] ? 2 : 1,
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
                    Icons.directions_car,
                    color: Color(0xFF00E676),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${vehicle['make']} ${vehicle['model']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (vehicle['isPrimary']) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00E676).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'PRIMARY',
                                style: TextStyle(
                                  color: Color(0xFF00E676),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${vehicle['year']} • ${vehicle['plate']}',
                        style: const TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white54),
                  color: const Color(0xFF1E1E1E),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18, color: Color(0xFF00E676)),
                          SizedBox(width: 12),
                          Text('Edit Details', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    if (!vehicle['isPrimary'])
                      const PopupMenuItem(
                        value: 'primary',
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 18, color: Color(0xFF00E676)),
                            SizedBox(width: 12),
                            Text('Set as Primary',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 12),
                          Text('Delete Vehicle',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'delete') {
                      _showDeleteDialog(context, vehicle);
                    }
                  },
                ),
              ],
            ),
          ),

          // Divider
          const Divider(color: Color(0xFF3A3A3A), height: 1),

          // Vehicle Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow(Icons.palette, 'Color', vehicle['color']),
                const SizedBox(height: 12),
                _buildDetailRow(
                    Icons.local_gas_station, 'Fuel Type', vehicle['fuelType']),
                const SizedBox(height: 12),
                _buildDetailRow(
                    Icons.settings, 'Transmission', vehicle['transmission']),
                const SizedBox(height: 12),
                _buildDetailRow(Icons.speed, 'Mileage', vehicle['mileage']),
                const SizedBox(height: 12),
                _buildDetailRow(Icons.confirmation_number, 'VIN', vehicle['vin']),
              ],
            ),
          ),

          // Service Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Service History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Service',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vehicle['lastService'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: const Color(0xFF3A3A3A),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Next Service',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vehicle['nextService'],
                            style: const TextStyle(
                              color: Color(0xFF00E676),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.history, size: 18),
                    label: const Text('View Full History'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00E676),
                      side: const BorderSide(color: Color(0xFF00E676)),
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white54),
        const SizedBox(width: 12),
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildAddVehicleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Vehicle',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your vehicle details below',
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 32),

          // Make
          _buildSectionLabel('Make *'),
          _buildTextField(_makeController, 'e.g., Toyota, Honda, BMW'),
          const SizedBox(height: 20),

          // Model
          _buildSectionLabel('Model *'),
          _buildTextField(_modelController, 'e.g., Corolla, Civic, X5'),
          const SizedBox(height: 20),

          // Year
          _buildSectionLabel('Year *'),
          _buildTextField(_yearController, 'e.g., 2020',
              keyboardType: TextInputType.number),
          const SizedBox(height: 20),

          // License Plate
          _buildSectionLabel('License Plate Number *'),
          _buildTextField(_plateController, 'e.g., ABC-1234'),
          const SizedBox(height: 20),

          // Color
          _buildSectionLabel('Color'),
          _buildTextField(_colorController, 'e.g., White, Black, Red'),
          const SizedBox(height: 20),

          // Fuel Type
          _buildSectionLabel('Fuel Type'),
          _buildDropdown(
            value: selectedFuelType,
            hint: 'Select fuel type',
            items: fuelTypes,
            onChanged: (value) {
              setState(() {
                selectedFuelType = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Transmission
          _buildSectionLabel('Transmission'),
          _buildDropdown(
            value: selectedTransmission,
            hint: 'Select transmission',
            items: transmissions,
            onChanged: (value) {
              setState(() {
                selectedTransmission = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Mileage
          _buildSectionLabel('Current Mileage (km)'),
          _buildTextField(_mileageController, 'e.g., 45000',
              keyboardType: TextInputType.number),
          const SizedBox(height: 20),

          // VIN
          _buildSectionLabel('VIN (Vehicle Identification Number)'),
          _buildTextField(_vinController, '17-character VIN'),
          const SizedBox(height: 32),

          // Add Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _addVehicle,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add Vehicle',
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

  Widget _buildTextField(
      TextEditingController controller,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value != null ? const Color(0xFF00E676) : const Color(0xFF3A3A3A),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: const TextStyle(color: Colors.white54)),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00E676)),
          dropdownColor: const Color(0xFF1E1E1E),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
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
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.directions_car_outlined,
              size: 80,
              color: Color(0xFF00E676),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Vehicles Added',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add your first vehicle to get started',
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _tabController.animateTo(1);
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
              'Add Vehicle',
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

  void _showDeleteDialog(BuildContext context, Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Vehicle',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete ${vehicle['make']} ${vehicle['model']}?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vehicle deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}