import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/_core/services/dio_service.dart';
import 'package:flutter_kangoolist/authentication/models/mock_user.dart';
import 'package:flutter_kangoolist/kangoolists/data/database.dart';
import 'package:flutter_kangoolist/kangoolists/screens/widgets/home_drawer.dart';
import 'package:flutter_kangoolist/kangoolists/screens/widgets/home_kangoolist_item.dart';
import '../models/kangoolist.dart';
import 'widgets/kangoolist_add_edit_modal.dart';
import 'widgets/kangoolist_options_modal.dart';

class HomeScreen extends StatefulWidget {
  final MockUser user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<KangooList> kangooLists = [];
  late AppDatabase _appDatabase;

  final DioService _dioService = DioService();

  @override
  void initState() {
    _appDatabase = AppDatabase();
    refresh();
    super.initState();
  }

  @override
  void dispose() {
    _appDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(user: widget.user),
      appBar: AppBar(title: const Text("Minhas listas"), actions: [
        PopupMenuButton(
          icon: const Icon(Icons.cloud_outlined),
          onSelected: (value) {
            if (value == "SAVE") {
              saveOnServer();
            }
            if (value == "SYNC") {
              syncWithServer();
            }
            if (value == "CLEAR") {
              clearServerData();
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "SAVE",
                child: ListTile(
                  leading: Icon(
                    Icons.cloud_upload_outlined,
                    size: 36,
                  ),
                  title: Text(
                    "Salvar na nuvem",
                  ),
                ),
              ),
              const PopupMenuItem(
                value: "SYNC",
                child: ListTile(
                  leading: Icon(Icons.cloud_download_outlined, size: 36),
                  title: Text(
                    "Sincronização da nuvem",
                  ),
                ),
              ),
              const PopupMenuItem(
                value: "CLEAR",
                child: ListTile(
                  leading: Icon(Icons.cloud_off_outlined, size: 36),
                  title: Text(
                    "Remover dados da nuvem",
                  ),
                ),
              ),
            ];
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddModal();
        },
        child: const Icon(Icons.add),
      ),
      body: (kangooLists.isEmpty)
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/bag.png"),
                  const SizedBox(height: 32),
                  const Text(
                    "Nenhuma lista ainda.\nVamos criar a primeira?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                child: ListView(
                  children: List.generate(
                    kangooLists.length,
                    (index) {
                      KangooList kangooList = kangooLists[index];
                      return HomeKangooListItem(
                        kangooList: kangooList,
                        showOptionModal: showOptionModal,
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }

  showAddModal({KangooList? kangooList}) {
    showAddEditKangooListModal(
        context: context,
        onRefresh: refresh,
        model: kangooList,
        appDatabase: _appDatabase);
  }

  showOptionModal(KangooList kangooList) {
    showKangooListOptionsModal(
      context: context,
      kangooList: kangooList,
      onRemove: remove,
    ).then((value) {
      if (value != null && value) {
        showAddModal(kangooList: kangooList);
      }
    });
  }

  refresh() async {
    List<KangooList> listakangooLists = await _appDatabase.getKangooLists();

    setState(() {
      kangooLists = listakangooLists;
    });
  }

  void remove(KangooList model) async {
    await _appDatabase.deleteKangooList(int.parse(model.id));
    refresh();
  }

  saveOnServer() async {
    _dioService.saveLocalToServer(_appDatabase).then((error) {
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  syncWithServer() async {
    await _dioService.getDataFromServer(_appDatabase);
    refresh();
  }

  clearServerData() async {
    await _dioService.clearServerData();
  }
}
