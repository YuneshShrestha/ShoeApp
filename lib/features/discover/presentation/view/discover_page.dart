import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    getShoes();
  }

  void getShoes() async {
    context.read<DiscoverBloc>().add(const GetShoesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is DiscoverError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
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
              : state is DiscoverLoaded
                  ? ListView.builder(
                      itemCount: state.shoes.length,
                      itemBuilder: (context, index) {
                        final shoe = state.shoes[index];
                        return ListTile(
                          title: Text(shoe.name),
                          subtitle: Text(shoe.categoryID),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
