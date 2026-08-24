import 'package:craftybay/app/asset_paths.dart';
import 'package:craftybay/features/category/presentation/providers/category_list_provider.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/home/presentation/provider/home_slider_providers.dart';
import 'package:craftybay/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../common/presentation/providers/main_nav_provider.dart';
import '../../../common/presentation/widgets/category_card.dart';
import '../../../common/presentation/widgets/product_card.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/product_search_field.dart';
import '../widgets/section_haeder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            spacing: 8,
            children: [
              ProductSearchField(),
              Consumer<HomeSliderProvider>(
                builder: (context, homeSliderProvider, _) {
                  if(homeSliderProvider.getHomeSliderInProgress){
                    return SizedBox(
                        height: 200,
                        child: CenterCircularProgress());
                  }
                  return HomeCarouselSlider(sliders: homeSliderProvider.homeSliders,);
                }
              ),
              SectionHeader(
                title: 'Categories',
                onTapSeeAll: () {
                  context.read<MainNavProvider>().changeCategories();
                },
              ),
              _buildCategoryList(),
              SectionHeader(title: 'Popular', onTapSeeAll: () {}),
              _buildPopularProductList(),
              SectionHeader(title: 'Special', onTapSeeAll: () {}),
              _buildPopularProductList(),
              SectionHeader(title: 'New', onTapSeeAll: () {}),
              _buildPopularProductList(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductList() {
    return SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // return ProductCard();
                  }),
            );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 85,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if(categoryListProvider.initialLoading) {
            return CenterCircularProgress();
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categoryListProvider.categoryList.length > 10 
                ? 10 
                : categoryListProvider.categoryList.length,
            itemBuilder: (context, index) {
              return CategoryCard(categoryModel: categoryListProvider.categoryList[index],);
            },
            separatorBuilder: (context, index) => SizedBox(width: 8),
          );
        }
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetPaths.navLogoSvg),
      actions: [
        CircleIconButton(onTap: () {}, icon: Icons.person),
        SizedBox(width: 4),
        CircleIconButton(onTap: () {}, icon: Icons.phone_outlined),
        SizedBox(width: 4),
        CircleIconButton(onTap: () {}, icon: Icons.notifications_on_outlined),
        SizedBox(width: 4),
      ],
    );
  }
}


