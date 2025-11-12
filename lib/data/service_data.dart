import 'package:flutter/material.dart';

import '../model/serviceModel.dart';
import '../model/serviceProvider.dart';

class ServiceData {
  static List<ServiceCategory> getCategories() {
    return [
      ServiceCategory(
        id: 'electrical',
        name: 'Electrical',
        icon: '⚡',
        description: 'Wiring, repairs & installations',
        color: const Color(0xFFFFB800),
      ),
      ServiceCategory(
        id: 'plumbing',
        name: 'Plumbing',
        icon: '🔧',
        description: 'Pipe repairs & installations',
        color: const Color(0xFF00B8D4),
      ),
      ServiceCategory(
        id: 'carpentry',
        name: 'Carpentry',
        icon: '🪚',
        description: 'Wood work & furniture',
        color: const Color(0xFFD84315),
      ),
      ServiceCategory(
        id: 'masonry',
        name: 'Masonry',
        icon: '🧱',
        description: 'Brick & concrete work',
        color: const Color(0xFF757575),
      ),
      ServiceCategory(
        id: 'painting',
        name: 'Painting',
        icon: '🎨',
        description: 'Interior & exterior painting',
        color: const Color(0xFF9C27B0),
      ),
      ServiceCategory(
        id: 'cleaning',
        name: 'Cleaning',
        icon: '🧹',
        description: 'Home & office cleaning',
        color: const Color(0xFF00E676),
      ),
      ServiceCategory(
        id: 'hvac',
        name: 'HVAC',
        icon: '❄️',
        description: 'AC & heating services',
        color: const Color(0xFF2196F3),
      ),
      ServiceCategory(
        id: 'automotive',
        name: 'Automotive',
        icon: '🚗',
        description: 'Vehicle service & repair',
        color: const Color(0xFFFF6B6B),
      ),
      ServiceCategory(
        id: 'appliance',
        name: 'Appliance',
        icon: '🔌',
        description: 'Appliance repair services',
        color: const Color(0xFF4CAF50),
      ),
      ServiceCategory(
        id: 'landscaping',
        name: 'Landscaping',
        icon: '🌱',
        description: 'Garden & lawn care',
        color: const Color(0xFF8BC34A),
      ),
      ServiceCategory(
        id: 'pest_control',
        name: 'Pest Control',
        icon: '🐛',
        description: 'Pest management services',
        color: const Color(0xFFFF9800),
      ),
      ServiceCategory(
        id: 'locksmith',
        name: 'Locksmith',
        icon: '🔐',
        description: 'Lock repair & installation',
        color: const Color(0xFF607D8B),
      ),
    ];
  }
  static List<ServiceProvider> getProvidersByCategory(String categoryId) {
    // Sample providers for demonstration
    return [
      ServiceProvider(
        id: '1',
        name: 'John Smith',
        categoryId: categoryId,
        rating: 4.8,
        reviewCount: 127,
        experience: '8 years',
        imageUrl: 'https://i.pravatar.cc/150?img=12',
        hourlyRate: 45.0,
        location: '2.5 km away',
        isVerified: true,
        specialties: ['Residential', 'Commercial', 'Emergency Service'],
      ),
      ServiceProvider(
        id: '2',
        name: 'Sarah Johnson',
        categoryId: categoryId,
        rating: 4.9,
        reviewCount: 203,
        experience: '12 years',
        imageUrl: 'https://i.pravatar.cc/150?img=5',
        hourlyRate: 55.0,
        location: '3.8 km away',
        isVerified: true,
        specialties: ['Expert Installation', 'Maintenance', '24/7 Available'],
      ),
      ServiceProvider(
        id: '3',
        name: 'Mike Davis',
        categoryId: categoryId,
        rating: 4.7,
        reviewCount: 89,
        experience: '6 years',
        imageUrl: 'https://i.pravatar.cc/150?img=33',
        hourlyRate: 40.0,
        location: '1.2 km away',
        isVerified: true,
        specialties: ['Repair Specialist', 'Quick Service', 'Affordable'],
      ),
      ServiceProvider(
        id: '4',
        name: 'Emily Chen',
        categoryId: categoryId,
        rating: 5.0,
        reviewCount: 156,
        experience: '10 years',
        imageUrl: 'https://i.pravatar.cc/150?img=9',
        hourlyRate: 60.0,
        location: '4.5 km away',
        isVerified: true,
        specialties: ['Premium Service', 'Warranty', 'Certified Professional'],
      ),
    ];
  }
}