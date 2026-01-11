/// Helper class to handle image URLs from backend
class ImageHelper {
  // Base URL for images
  static const String baseUrl = 'https://api.thenaukrimitra.com';
  
  /// Converts a filename or partial URL to a full image URL
  /// 
  /// Examples:
  /// - "image-123.jpg" → "https://api.thenaukrimitra.com/uploads/image-123.jpg"
  /// - "https://example.com/image.jpg" → "https://example.com/image.jpg" (unchanged)
  static String getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return '';
    }
    
    // If already a full URL, return as is
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return imageUrl;
    }
    
    // If starts with /, remove it
    if (imageUrl.startsWith('/')) {
      imageUrl = imageUrl.substring(1);
    }
    
    // Construct full URL
    // Assuming backend stores images in /uploads/ folder
    return '$baseUrl/uploads/$imageUrl';
  }
  
  /// Check if image URL is valid
  static bool isValidImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return false;
    }
    
    // Check if it's a full URL or a filename
    return imageUrl.isNotEmpty;
  }
}
