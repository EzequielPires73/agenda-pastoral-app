import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class MemberCreationResult {
  Member? member;
  String? errorMessage;

  MemberCreationResult({this.member, this.errorMessage});
}

class MemberRepoistory {
  final ApiService _apiService = ApiService();

  Future<List<Member>> findAll() async {
    try {
      var res = await _apiService.get('members', null);

      if (res['success']) {
        var list = res['results'] as List;
        List<Member> responsibles =
            list.map((e) => Member.fromJson(e)).toList();

        return responsibles;
      }

      return [];
    } catch (error) {
      return [];
    }
  }

  Future<MemberCreationResult> create(Member memberData) async {
    try {
      var res = await _apiService.post('members', memberData.toJson(), null);

      if (res['success'] && res['result'] != null) {
        Member member = Member.fromJson(res['result']);

        return MemberCreationResult(member: member);
      } else {
        return MemberCreationResult(errorMessage: res['message']);
      }
    } catch (error) {
      print(error);
      return MemberCreationResult(errorMessage: error.toString());
    }
  }

  Future<MemberCreationResult> update(String id, Member memberData) async {
    try {
      var res = await _apiService.patch('members/$id', memberData.toJson(), null);

      if (res['success'] && res['result'] != null) {
        Member member = Member.fromJson(res['result']);

        return MemberCreationResult(member: member);
      } else {
        return MemberCreationResult(errorMessage: res['message']);
      }
    } catch (error) {
      print(error);
      return MemberCreationResult(errorMessage: error.toString());
    }
  }

  Future<bool> remove(String id) async {
    try {
      var res = await _apiService.delete('members/$id', null, null);
      
      return res['success'];
    } catch(error) {
      return false;
    }
  }
}
