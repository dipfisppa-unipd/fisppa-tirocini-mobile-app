import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';


class SearchBarInstitutes extends StatelessWidget {
  const SearchBarInstitutes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightText,
      height: 60,
      width: Get.width,
      child: GetBuilder<DirectInternshipController>(
        builder: (ctrl) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox( width: 15),
              Flexible(
                child: TextField(
                  controller: ctrl.paramRicerca,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Cerca per istituto, città o CAP',
                  ),
                  onSubmitted: (s){
                    if(!ctrl.isLoading)
                    ctrl.searchIstituti();
                  },
                ),
              ),

              IconButton(icon: Icon(Icons.search), onPressed: () {
                if(!ctrl.isLoading)
                ctrl.searchIstituti();
              }),
              const SizedBox( width: 15),
            ],
          );
        }
      ),
    );
  }
}