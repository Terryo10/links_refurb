

import 'package:link_refurb/models/experties_model/expertise_model.dart';
import 'package:link_refurb/models/messsage_model/message.dart';

import 'experties_provider.dart';

class ExpertiseRepository {
  final ExpertiseProvider provider;

  ExpertiseRepository({required this.provider});

  Future<ExpertiseListModel> getExpertiesList() async {
    var data = await provider.getExpertiesList();
    var model = expertiseListModelFromJson(data);
    return model;
  }

  Future<MessageModel> selectExperties({required int expertiseId}) async {
    var data = await provider.selectExperties(expertiseId: expertiseId);
    var model = messageModelFromJson(data);
    return model;
  }

   Future<MessageModel> changeExperties({required int expertiseId}) async {
    var data = await provider.changeExperties(expertiseId: expertiseId);
    var model = messageModelFromJson(data);
    return model;
  }
}
