import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/pages/profilePageWeb.dart';
import 'package:proyecto_integrado_3/pages/profilePage.dart';
import 'package:proyecto_integrado_3/pages/uploadFilePage.dart';
import 'package:proyecto_integrado_3/providers/googleSignInProvider.dart';
import 'package:proyecto_integrado_3/widgets/listFilesWidget.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return SafeArea(
          child: Scaffold(
            key: _key,
            appBar: isSmallScreen  ? AppBar(
              leading: IconButton(
                onPressed: () {
                  _key.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu),
              ),
            )
            : null,
            drawer: SideBarWidget(controller: _controller),
            body: Row(
              children: [
                if(!isSmallScreen) SideBarWidget(controller: _controller),
                Expanded(child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      switch (_controller.selectedIndex){
                        case 0: _key.currentState?.closeDrawer();
                           return ListFilesWidget();
                        case 1:  _key.currentState?.closeDrawer();
                          return UploadFilePage();
                        case 2:  _key.currentState?.closeDrawer();
                          return ProfileWebPage();
                        default:  _key.currentState?.closeDrawer();
                          return Center(child: Text("ALGO A FALLADO"),);
                        
                      }
                    },
                  ),
                ))
              ],
            )
          ),
        );
      }
    );
  }
}

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key, required SidebarXController controller}) : _controller = controller;
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<GoogleSignInProvider>(context);
    return SidebarX(
      controller: _controller,
      theme: const SidebarXTheme(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 20, 146, 230),
         
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 140
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100000),
              child: /* FadeInImage(
                placeholder: AssetImage('assets/giphy.gif'),
                image: NetworkImage(authProvider.currentuser!.imgProfilePath),
                imageErrorBuilder: ((context, error, stackTrace) => const Icon(Icons.person)),
                fit: BoxFit.cover,
                width: 60,
                height: 60,            
              ), */
              Image.network(
                authProvider.currentuser!.imgProfilePath, width: 50, height: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 50,),
              )
            ),
          )
        );
      },
      footerDivider: Divider(color: Colors.white, height: 1,) ,
      items: const [
        SidebarXItem(icon: Icons.home, label: "Home"),
        SidebarXItem(icon: Icons.add, label: "Añadir"),
        //SidebarXItem(icon: Icons.search, label: "Search"),
        SidebarXItem(icon: Icons.person, label: "Perfil"),
        
      ],
    );
  }
}