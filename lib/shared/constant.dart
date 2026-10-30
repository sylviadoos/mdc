const arLang = 'ar';
const engLang = 'en';
String? lang = 'ar';
String? token;
String? apiKey = "57533140d28401b939cdd4b008a2da739b551560";
bool? isRegister;
int? userId;
String? tokenFireBase;

// ================= Backend base URL switch =================
// Change ONLY this flag: true = local server, false = online (production).
const bool useLocalServer = true;

// Online (production) server.
const String onlineBaseUrl = 'https://app.mdc-card.com/api';

// Local server — pick the value that matches how you run the app:
//   • Android emulator:      http://10.0.2.2:8000/api   (10.0.2.2 = your PC localhost)
//   • Real phone (same WiFi): http://<YOUR-PC-IP>:8000/api  e.g. http://192.168.1.5:8000/api
//   • iOS simulator:         http://127.0.0.1:8000/api
const String localBaseUrl = 'http://192.168.1.4:8000/api';

// The URL actually used by the app (do not edit — driven by useLocalServer).
String get activeBaseUrl => useLocalServer ? localBaseUrl : onlineBaseUrl;
