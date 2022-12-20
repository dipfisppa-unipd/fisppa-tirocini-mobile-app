import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/models/indirect/group_model.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_controller.dart';

import '../../../app/app_styles.dart';



class GroupTile extends StatelessWidget {
  const GroupTile(this.group, { 
    Key? key, 
    this.isSelected=false, 
    this.withTutorOrganizer=false,
    this.onTap,

  }) : super(key: key);

  final GroupModel group;
  final bool isSelected, withTutorOrganizer;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {

    var tile = ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      onTap: onTap,
      isThreeLine: true,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text('${group.name}', style: const TextStyle(fontSize: 22, fontFamily: 'Oswald', color: AppColors.secondary),),
      ),
      subtitle: Text('Tutor coordinatore: ${group.coordinatorTutor?.fullname ?? ''}', style: const TextStyle(fontSize: 18,),),
      trailing: !isSelected ? SizedBox() : Icon(Icons.check, color: AppColors.onPrimary,),
    );

    if(withTutorOrganizer && group.organizerTutor!=null){
      return Column(
        children: [
          tile,
          Text('Tutor organizzatore: ${group.organizerTutor?.fullname ?? ''}', style: const TextStyle(fontSize: 18,),),
        ],
      );
    }

    return tile;
    
  }
}

class GroupTileExtended extends StatelessWidget {
  const GroupTileExtended(this.group, {Key? key, }) : super(key: key);

  final GroupModel group;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 20),
          child: Text('${group.name}', style: const TextStyle(fontSize: 22, fontFamily: 'Oswald', color: AppColors.secondary),),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text('Denominazione', style: AppStyles.black16.bold,)
              ),
              Expanded(child: Text(group.name??'', style: AppStyles.body16,)),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded( child: Text('Territorialità', style: AppStyles.black16.bold,),),

              if(group.territorialityId!=null && group.territorialityId!.isNotEmpty)
              GetBuilder<IndirectInternshipController>(
                builder: (ctrl) {
                  return Expanded( child: Text(ctrl.getTerritorilityName(group.territorialityId!), style: AppStyles.body16,),);
                }
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('Tutor Coordinatore', style: AppStyles.black16.bold,)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(group.coordinatorTutor?.fullname ?? '', style: AppStyles.body16,),
                    ),
                    Text(group.coordinatorTutor?.email ?? '', style: AppStyles.body16,),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('Tutor Organizzatore', style: AppStyles.black16.bold,)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.organizerTutor?.fullname ?? '', style: AppStyles.body16,),
                    Text(group.organizerTutor?.email ?? '', style: AppStyles.body16,),
                  ],
                ),
              ),
            ],
          ),
        ),

        const Divider(),

      ],
    );
    
  }
}