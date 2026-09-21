import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  static const Color _primaryColor = Color(0xFF064E3B);

  // Bottom nav selection
  int _selectedIndex = 0;

  // Categories shown in the grid
  final List<_Category> _categories = const [
    _Category('Fruits &\nVegetables', Icons.eco_outlined),
    _Category('Dairy &\nBread', Icons.egg_outlined),
    _Category('Snacks &\nMunchies', Icons.cookie_outlined),
    _Category('Beverages', Icons.local_drink_outlined),
    _Category('Personal\nCare', Icons.soap_outlined),
    _Category('Household', Icons.cleaning_services_outlined),
    _Category('Baby Care', Icons.child_care_outlined),
    _Category('Pet Care', Icons.pets_outlined),
  ];

  // Promotional banners
  final List<String> _banners = const [
    'Flat 50% OFF on first order',
    'Free delivery above ₹199',
    'Fresh fruits, delivered in 10 mins',
  ];

  // Popular products
  final List<_Product> _products = const [
    _Product('Bananas', '₹49', Icons.emoji_food_beverage_outlined),
    _Product('Tomatoes', '₹29', Icons.local_pizza_outlined),
    _Product('Milk 1L', '₹65', Icons.local_drink_outlined),
    _Product('Bread', '₹40', Icons.bakery_dining_outlined),
    _Product('Eggs (6pcs)', '₹55', Icons.egg_outlined),
    _Product('Potato Chips', '₹20', Icons.fastfood_outlined),
  ];

  void _onNavTap(int index) {

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // Header with location and search bar
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),

            // Promotional banners
            SliverToBoxAdapter(
              child: _buildBanners(),
            ),

            // Categories grid
            SliverToBoxAdapter(
              child: _buildSectionTitle('Shop by Category'),
            ),

            SliverToBoxAdapter(
              child: _buildCategoriesGrid(),
            ),

            // Popular products
            SliverToBoxAdapter(
              child: _buildSectionTitle('Popular Products'),
            ),

            SliverToBoxAdapter(
              child: _buildProductsList(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,

        selectedItemColor: _primaryColor,
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  // Location bar + search bar
  Widget _buildHeader() {

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),

      decoration: const BoxDecoration(
        color: _primaryColor,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 20,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Delivery in 10 minutes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    Text(
                      'Home - Bengaluru, Karnataka',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),

            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search for products...',

                prefixIcon: Icon(
                  Icons.search,
                  color: _primaryColor,
                ),

                border: InputBorder.none,

                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Horizontally scrollable promo banners
  Widget _buildBanners() {

    return SizedBox(
      height: 120,

      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),

        scrollDirection: Axis.horizontal,

        itemCount: _banners.length,

        separatorBuilder: (context, index) =>
            const SizedBox(width: 12),

        itemBuilder: (context, index) {

          return Container(
            width: 260,

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Align(
              alignment: Alignment.centerLeft,

              child: Text(
                _banners[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
    );
  }

  // Grid of shopping categories
  Widget _buildCategoriesGrid() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: GridView.builder(
        shrinkWrap: true,

        physics: const NeverScrollableScrollPhysics(),

        itemCount: _categories.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),

        itemBuilder: (context, index) {

          final category = _categories[index];

          return Column(
            children: [

              Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Icon(
                  category.icon,
                  color: _primaryColor,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                category.name,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Horizontally scrollable product cards
  Widget _buildProductsList() {

    return SizedBox(
      height: 190,

      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        scrollDirection: Axis.horizontal,

        itemCount: _products.length,

        separatorBuilder: (context, index) =>
            const SizedBox(width: 12),

        itemBuilder: (context, index) {

          final product = _products[index];

          return Container(
            width: 130,

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),

              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Container(
                  width: double.infinity,
                  height: 80,

                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Icon(
                    product.icon,
                    color: _primaryColor,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),

                    InkWell(
                      onTap: () {},

                      child: const Icon(
                        Icons.add_circle,
                        color: _primaryColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Category {

  final String name;
  final IconData icon;

  const _Category(this.name, this.icon);
}

class _Product {

  final String name;
  final String price;
  final IconData icon;

  const _Product(this.name, this.price, this.icon);
}
