// Model Class 
class User { 
  final int id; 
  final String name; 
  final String username; 
  final String email; 
 
  // Constructor 
  User(this.id, this.name, this.username, this.email); 
 
  // แปลง JSON เป็น Object 
  User.fromJson(Map<String, dynamic> json) 
      : id = json['id'], 
        name = json['name'], 
        username = json['username'], 
        email = json['email']; 
 
  // แปลง Object เป็น JSON Map 
  Map<String, dynamic> toJson() { 
    return { 
      'id': id, 
      'name': name, 
      'username': username, 
      'email': email, 
    }; 
  } 
} 