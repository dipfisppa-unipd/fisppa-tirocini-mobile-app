import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/previous/previous_direct_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/search/search_bar_institutes.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/widgets/tile_istituto.dart';
import 'package:unipd_mobile/widgets/white_box.dart';


class SearchInstituteScreen extends StatelessWidget {
  const SearchInstituteScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cerca istituto'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: (){
          //     showSearch(context: context, delegate: _InstituteSearchDelegate());
          //   },
          // ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            SliverPersistentHeader(
              floating: true,
              pinned: false,
              delegate: _SearchDelegate(),
            ),

            SliverToBoxAdapter(
              child: GetBuilder<DirectInternshipController>(
                builder: (ctrl) {
                  return SwitchListTile(
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    onChanged: (b){
                      ctrl.setOnlyInfancy(b);
                    },
                    value: ctrl.showInfanziaOnly,
                    activeColor: AppColors.onPrimary,
                    title: Text('Mostra solo scuole dell\'infanzia'),
                  );
                }
              ),
            ),

            SliverToBoxAdapter(
              child: GetBuilder<DirectInternshipController>(
                builder: (ctrl) {
            
                  if(ctrl.isLoading)
                  return Center(
                    child: SizedBox(
                      height: 100,
                      child: Loader(size: 60,)
                    ),
                  );
            
                  if(ctrl.paramRicerca.text.isNotEmpty && ctrl.foundInstitutes.isEmpty)
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(child: Text('Nessun risultato', style: TextStyle(fontSize: 20,),)),
                  );
            
                  return WhiteBox(
                    children: [
                      
                      if(!ctrl.showInfanziaOnly)
                      for(InstituteModel i in ctrl.foundInstitutes)
                        if(i.isComprensivo) 
                        TileIstituto(
                          istituto: i, 
                          onTap: (){
                            ctrl.setAsPreviousChoice(i);
                          },
                        ),
            
                      
                      if(!ctrl.showInfanziaOnly)
                      for(InstituteModel i in ctrl.foundInstitutes)
                        if(i.isParitaria) 
                          TileIstituto(
                            istituto: i, 
                            onTap: (){
                            ctrl.setAsPreviousChoice(i);
                          }),

                      if(ctrl.showInfanziaOnly)
                        for(InstituteModel i in ctrl.foundInstitutes)
                          if(i.isInfanziaParitaria)
                            TileIstituto(
                              istituto: i, 
                              checked: ctrl.isChecked(i),
                              onTap: (){
                            ctrl.setAsPreviousChoice(i);
                          },)
                    ], 
                    withPadding: true,
                  );
                }
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<DirectInternshipController>(
        builder: (ctrl) {
          if(ctrl.choices.isEmpty) return SizedBox();

          return BottomAppBar(
            color: AppColors.secondary,
            child: InkWell(
              child: const SizedBox(
                height: 50, 
                child: Center(child: Text('SALVA', textAlign: TextAlign.center, style: TextStyle(color: AppColors.onSecondary, fontSize: 18,),))),
              onTap: () {
                PreviousDirectController.to.storeChoices(ctrl.choices);
                Get.back();
              },
            ), 
          );
        }
      ),
    );
  }
}

class _SearchDelegate extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const SearchBarInstitutes();
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

// * DO NO DELETE, CAN BE USED LATER
// class _InstituteSearchDelegate extends SearchDelegate{

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(onPressed: (){
//       close(context, null);
//     }, icon: Icon(Icons.arrow_back));
//   }

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: (){
//           if(query.isEmpty){
//             close(context, null);
//           }else{
//             query = '';
//           }
          
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return SizedBox();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return SizedBox();
//   }

// }