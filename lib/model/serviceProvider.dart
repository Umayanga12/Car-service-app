
class ServiceProvider {
  final String id;
  final String name;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final String experience;
  final String imageUrl;
  final double hourlyRate;
  final String location;
  final bool isVerified;
  final List<String> specialties;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    required this.experience,
    required this.imageUrl,
    required this.hourlyRate,
    required this.location,
    required this.isVerified,
    required this.specialties,
  });
}