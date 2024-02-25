class User {
  final String id;
  final String userName;
  final String countryDialCode;
  final String phoneNumber;
  final bool isVerifiedUser;
  final bool isActive;
  final int? noOfNewsRead;
  final String? profilePicture;
  final String userType;
  final String? about;
  final String preferredLanguage;

  User({
    required this.id,
    required this.userName,
    required this.countryDialCode,
    required this.phoneNumber,
    required this.isVerifiedUser,
    required this.isActive,
    this.noOfNewsRead,
    this.profilePicture,
    required this.userType,
    this.about,
    required this.preferredLanguage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      countryDialCode: json['country_dial_code'],
      phoneNumber: json['phone_number'],
      isVerifiedUser: json['is_verified_user'],
      isActive: json['is_active'],
      noOfNewsRead: json['no_of_news_read'],
      profilePicture: json['profile_picture'],
      userType: json['user_type'],
      about: json['about'],
      preferredLanguage: json['preferred_language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'country_dial_code': countryDialCode,
      'phone_number': phoneNumber,
      'is_verified_user': isVerifiedUser,
      'is_active': isActive,
      'no_of_news_read': noOfNewsRead,
      'profile_picture': profilePicture,
      'user_type': userType,
      'about': about,
      'preferred_language': preferredLanguage,
    };
  }
}
