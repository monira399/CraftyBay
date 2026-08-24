import 'package:craftybay/features/category/presentation/providers/category_list_provider.dart';
import 'package:craftybay/features/common/presentation/providers/main_nav_provider.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/presentation/widgets/category_card.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryListProvider>().refreshCategoryList();
      _scrollController.addListener(_loadMoreData);
    });
  }
  void _loadMoreData() {
    if(context.read<CategoryListProvider>().moreLoading){
      return;
    }

    if(_scrollController.position.extentAfter < 300) {
      context.read<CategoryListProvider>().fetchCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {


    return PopScope(
      onPopInvokedWithResult: (_, __){
        context.read<MainNavProvider>().backToHome();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            context.read<MainNavProvider>().backToHome();
          },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text('Categories'),
        ),
        body: Consumer<CategoryListProvider>(
          builder: (context, categoryProvider, _) {
            if(categoryProvider.initialLoading){
              return CenterCircularProgress();
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: categoryProvider.categoryList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          return CategoryCard(categoryModel: categoryProvider.categoryList[index],);
                        }),
                  ),
                ),
                if(categoryProvider.moreLoading)
                CenterCircularProgress()
              ],
            );
          }
        ),
      ),
    ) ;
  }
}
