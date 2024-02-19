import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_icon.dart';
import 'package:agenda_pastora_app/widgets/cards/card-category.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CategoiresAdminPage extends StatefulWidget {
  const CategoiresAdminPage({super.key});

  @override
  State<CategoiresAdminPage> createState() => _CategoiresAdminPageState();
}

class _CategoiresAdminPageState extends State<CategoiresAdminPage> {
  final AppointmentCategoryRepository _repository =
      AppointmentCategoryRepository();
  List<AppointmentCategory> categories = [];
  bool loading = true;

  Future<void> findCategories() async {
    setState(() {
      loading = true;
    });

    var resCategories = await _repository.findAll();

    setState(() {
      categories = resCategories;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    findCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: HeaderPages(
          title: 'Categorias de agendamento',
          actions: [
            ButtonIcon(
              onPressed: () async {
                await Navigator.pushNamed(context, '/admin/create_category');
                await findCategories();
              },
              icon: FeatherIcons.plus,
            ),
          ],
        ),
        preferredSize: Size(double.infinity, 80),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    CardCategory(category: categories[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: categories.length,
              ),
            ),
    );
  }
}
