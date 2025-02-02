class Air_Quality{
  final int aqi; // ดัชนีคุณภาพอากาศ (AQI)
  final String city; // ชื่อเมือง
  final double temperature; // อุณหภูมิ

  Air_Quality({required this.aqi, required this.city, required this.temperature});
  
   factory Air_Quality.fromJson(Map<String, dynamic> json) {
    return Air_Quality(
      aqi: json['aqi'] ?? 0,
      city: json['city']['name'] ?? 'Unknown',
      temperature: json['iaqi']['t']?['v']?.toDouble() ?? 0.0, // ตรวจสอบค่าอุณหภูมิ
    );
  } 
 
  // แปลง Object เป็น JSON Map 
  Map<String, dynamic> toJson() {
    return {
      'aqi': aqi,
      'city': city,
      'temperature': temperature,
    };
  } 
} 