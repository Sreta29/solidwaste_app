import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:solidwaste_app/homepage.dart';
import 'package:solidwaste_app/order_form.dart';
import 'package:solidwaste_app/payment.dart';
import 'package:solidwaste_app/setting.dart';



class Layout extends StatefulWidget{
    const Layout({super.key});

  

   @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {


   List<Widget> tabs = [
   const HomePage(),
   const OrderForm(orderNumber: '',),
   const PaymentPage(),
   const SettingPage()
  ];

  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.border_color,
                text: 'Order Form',
              ),
              GButton(
                icon: Icons.payment,
                text: 'Payment',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
             selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;   
               });
              
            },
          ),
        ),
      ),
      body: Center(child: tabs.elementAt(selectedIndex),),
    );
  }
}