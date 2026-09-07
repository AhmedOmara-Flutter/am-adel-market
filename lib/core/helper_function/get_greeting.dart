String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return "صباح الخير ☀️";
  } else if (hour < 17) {
    return "مساء الخير 🌤️";
  } else {
    return "مساء الخير 🌙";
  }
}