import 'package:cached_network_image/cached_network_image.dart';
import 'package:database_pharmacy/bloc/home_bloc.dart';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  initState() {
    homeBloc.getDrugsFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: homeBloc.fetchCardDrugs,
        builder: (context, AsyncSnapshot<List<DrugsResult>> snapshot) {
          if (snapshot.hasData) {
            List<DrugsResult> drugsRersult = snapshot.data!;
            return drugsRersult.isEmpty
                ? Container()
                : Container(

                    width: 120,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: drugsRersult[index].image,
                          ),
                        ],
                      );
                    }),
                  );
          }
          return Container();
        },
      ),
    );
  }
}
