import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
import 'components/category_tile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'Choose a category',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const CateogoriesGrid()
        ],
      ),
    );
  }
}

class CateogoriesGrid extends StatelessWidget {
  const CateogoriesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          CategoryTile(
            imageLink: 'assets/category_images/biscuit.png',
            label: 'Cookies',
            //backgroundColor: AppColors.primary,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails,
                  arguments: 'Cookies');
            },
          ),
          CategoryTile(
            imageLink: 'assets/category_images/brownie.png',
            label: 'Brownies',
            //backgroundColor: AppColors.primary,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails,
                  arguments: 'Brownies');
            },
          ),
          CategoryTile(
            imageLink: 'assets/category_images/juice.png',
            label: 'Juices',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails,
                  arguments: 'Juices');
            },
          ),
          CategoryTile(
            imageLink: 'assets/category_images/muffin.png',
            label: 'Muffins',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails,
                  arguments: 'Muffins');
            },
          ),
          CategoryTile(
            imageLink: 'assets/category_images/bonbon.png',
            label: 'Sweets',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails,
                  arguments: 'Sweets');
            },
          ),
          CategoryTile(
            imageLink: 'assets/category_images/chips.png',
            label: 'Chips',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails,
                  arguments: 'Chips');
            },
          ),
          /*CategoryTile(
            imageLink: 'https://i.imgur.com/DNr8a6R.png',
            label: 'Beauty',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/O2ZX5nR.png',
            label: 'Gym Equipment',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/wJBopjL.png',
            label: 'Gardening Tools',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/P4yJA9t.png',
            label: 'Pet Care',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/sxGf76e.png',
            label: 'Eye Wears',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/BPvKeXl.png',
            label: 'Pack',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/m65fusg.png',
            label: 'Others',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),*/
        ],
      ),
    );
  }
}
