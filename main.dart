import 'package:flutter/material.dart';

void main() => runApp(const DaundDeliveryApp());

const brand = Color(0xFF174B3A);
const accent = Color(0xFFF2B84B);

class DaundDeliveryApp extends StatelessWidget {
  const DaundDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daund Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brand),
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: brand, foregroundColor: Colors.white,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class Service {
  final String title, subtitle, emoji;
  const Service(this.title, this.subtitle, this.emoji);
}

const services = <Service>[
  Service('किराणा', 'धान्य, दूध, रोजचा किराणा', '🛒'),
  Service('भाजीपाला व फळे', 'ताजी भाजी आणि फळे', '🥬'),
  Service('हॉटेल / जेवण', 'नाश्ता, जेवण, पार्सल', '🍱'),
  Service('मेडिकल / औषधे', 'औषधे व आरोग्य साहित्य', '💊'),
  Service('मोबाईल व इतर दुकाने', 'मोबाईल, इलेक्ट्रॉनिक्स', '📱'),
  Service('पार्सल / कागदपत्रे', 'स्थानिक पिकअप व ड्रॉप', '📦'),
];

class Product {
  final String name, category;
  final int price;
  const Product(this.name, this.category, this.price);
}

const products = <Product>[
  Product('दैनंदिन किराणा पॅक', 'किराणा', 199),
  Product('ताजी भाजी बास्केट', 'भाजीपाला व फळे', 99),
  Product('नाश्ता कॉम्बो', 'हॉटेल / जेवण', 80),
  Product('घरगुती आवश्यक वस्तू', 'मोबाईल व इतर दुकाने', 149),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;
  int cartCount = 0;
  String role = 'ग्राहक';
  String area = 'दौंड शहर';
  String selectedCategory = '';

  void addToCart() => setState(() => cartCount++);

  @override
  Widget build(BuildContext context) {
    final pages = [
      CustomerHome(
        area: area,
        onArea: (v) => setState(() => area = v),
        onAdd: addToCart,
        onCategory: (v) => setState(() => selectedCategory = v),
      ),
      OrdersPage(cartCount: cartCount),
      RolePage(role: role, onRole: (v) => setState(() => role = v)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daund Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text('🛍️ $cartCount', style: const TextStyle(fontSize: 17))),
          ),
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'होम'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'ऑर्डर'),
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'माझे खाते'),
        ],
      ),
    );
  }
}

class CustomerHome extends StatelessWidget {
  final String area;
  final ValueChanged<String> onArea;
  final VoidCallback onAdd;
  final ValueChanged<String> onCategory;
  const CustomerHome({
    super.key, required this.area, required this.onArea,
    required this.onAdd, required this.onCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: brand, borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('आपल्या दौंडची, आपल्या लोकांची सेवा',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('दौंड तालुक्यातील स्थानिक दुकाने एका ठिकाणी',
                style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('डिलिव्हरी कुठे हवी आहे?', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: area,
          decoration: const InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
          items: const ['दौंड शहर','पाटस','केडगाव','यवत','वरवंड','इतर गाव']
              .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) { if (v != null) onArea(v); },
        ),
        const SizedBox(height: 20),
        const Text('सेवा निवडा', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.55, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, i) {
            final s = services[i];
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                onCategory(s.title);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${s.title} निवडले')));
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8E2))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(s.emoji, style: const TextStyle(fontSize: 25)),
                    const SizedBox(height: 5),
                    Text(s.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(s.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: Colors.black54)),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const Text('लोकप्रिय डेमो उत्पादने', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...products.map((p) => Card(
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Color(0xFFEAF2EB), child: Icon(Icons.shopping_bag_outlined, color: brand)),
            title: Text(p.name),
            subtitle: Text('₹${p.price} • ${p.category}'),
            trailing: FilledButton(onPressed: onAdd, child: const Text('जोडा +')),
          ),
        )),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text('टीप: ही नमुना उत्पादने व दर आहेत. प्रत्यक्ष दुकाने आणि किंमती नंतर जोडल्या जातील.',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.black54)),
        ),
      ],
    );
  }
}

class OrdersPage extends StatelessWidget {
  final int cartCount;
  const OrdersPage({super.key, required this.cartCount});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.local_shipping_outlined, size: 64, color: brand),
        const SizedBox(height: 12),
        const Text('तुमच्या ऑर्डर्स', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('कार्टमध्ये $cartCount डेमो वस्तू आहेत.'),
        const SizedBox(height: 8),
        const Text('प्रत्यक्ष ऑर्डर आणि लाईव्ह ट्रॅकिंग पुढील आवृत्तीत जोडले जाईल.',
          textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
      ]),
    ),
  );
}

class RolePage extends StatelessWidget {
  final String role;
  final ValueChanged<String> onRole;
  const RolePage({super.key, required this.role, required this.onRole});
  @override
  Widget build(BuildContext context) {
    const roles = ['ग्राहक', 'दुकानदार', 'डिलिव्हरी पार्टनर', 'Admin'];
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('वापरकर्ता विभाग', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('हा डेमो भूमिका निवड दाखवतो. प्रत्यक्ष सुरक्षित लॉगिन व परवानग्या सर्व्हरवर लागू कराव्या लागतील.'),
      const SizedBox(height: 16),
      ...roles.map((r) => Card(
        child: RadioListTile<String>(
          value: r, groupValue: role, onChanged: (v) { if (v != null) onRole(v); },
          title: Text(r), secondary: Icon(
            r == 'Admin' ? Icons.admin_panel_settings : r == 'दुकानदार' ? Icons.store :
            r == 'डिलिव्हरी पार्टनर' ? Icons.delivery_dining : Icons.person,
            color: brand),
        ),
      )),
      const SizedBox(height: 12),
      const Text('प्रॉडक्शन आवृत्तीत प्रत्येक भूमिकेसाठी स्वतंत्र लॉगिन, डॅशबोर्ड आणि डेटा परवानग्या असतील.',
        style: TextStyle(color: Colors.black54)),
    ]);
  }
}
