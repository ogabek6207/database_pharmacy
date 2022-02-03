import 'package:database_pharmacy/bloc/home_bloc.dart';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:database_pharmacy/ui/home/horizontal_item_widget.dart';
import 'package:database_pharmacy/ui/save_product/save_product_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    homeBloc.getDrugs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: homeBloc.fetchDrugs,
            builder: (context, AsyncSnapshot<DrugsModel> snapshot) {
              if (snapshot.hasData) {
                List<DrugsResult> drugsRersult = snapshot.data!.results;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                  itemCount: drugsRersult.length,
                  itemBuilder: (context, index) {
                    return ItemHorizontalWidget(
                      key: Key(
                        drugsRersult[index].cardCount.toString(),
                      ),
                      data: drugsRersult[index],
                    );
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
