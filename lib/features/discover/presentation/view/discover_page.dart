import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_shop_app/features/discover/domain/entities/shoe.dart';
import 'package:shoe_shop_app/features/discover/presentation/bloc/discover_bloc.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // late FirebaseDatabase _database;
  @override
  void initState() {
    super.initState();

    // _database = FirebaseDatabase.instance;
    getCategories();

    // getShoes();
  }

  void getShoes() async {
    context.read<DiscoverBloc>().add(const GetShoesEvent());
  }

  void getCategories() async {
    context.read<DiscoverBloc>().add(const GetCategoriesEvent());
  }

  List<Shoe> shoes = [];

  @override
  Widget build(BuildContext context) {
    return 

    BlocConsumer<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is DiscoverError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is ShoesLoaded) {
          shoes = state.shoes;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Discover'),
          ),
          body: state is DiscoverLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is CategoriesLoaded
                  ? Column(
                      children: [
                        // Text("Categories: ${state.categories[0]}"),
                       Text(state.categories[0].name),
                      ],
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  
  
  }
}
