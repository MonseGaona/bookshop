import 'dart:io';

import 'package:bookshop/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../components/user_data.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } else {
      print('Permission denied');
      openAppSettings();
    }
  }

  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Elegir una opción',
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          content: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundLight,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
                child: Text(
                  'Seleccionar de la galería',
                  style: textTheme.displaySmall?.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundLight,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
                child: Text(
                  'Tomar una foto',
                  style: textTheme.displaySmall?.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hola, ${userData.name}!',
          style: textTheme.headlineLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.Newpink,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _showImagePickerDialog();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.Newpink,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text(
                      userData.name,
                      style: textTheme.headlineLarge,
                    )
                  : Image.file(_image!),
              SizedBox(height: 20),
              _buildEditButton(
                context,
                'Nombre',
                'Ingrese su nuevo nombre',
                Icons.arrow_forward_ios_outlined,
                (value) {
                  userData.setName(value);
                },
              ),
              _buildDivider(),
              _buildEditButton(
                context,
                'Género Literario',
                'Seleccione su género literario favorito:',
                Icons.arrow_forward_ios_outlined,
                (value) {
                  userData.setFavoriteGenre(value);
                },
              ),
              _buildDivider(),
              _buildEditButton(
                context,
                'Biografía',
                'Ingrese su nueva biografía',
                Icons.arrow_forward_ios_outlined,
                (value) {
                  userData.setBio(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton(
    BuildContext context,
    String title,
    String hint,
    IconData icon,
    Function(String) onEdit,
  ) {
    TextEditingController controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            if (title == 'Género Literario') {
              _showGenrePickerDialog(context, onEdit, controller);
            } else {
              _showEditDialog(context, title, hint, onEdit, controller);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.black,
                ),
              ),
              Icon(
                icon,
                color: AppColors.Newpink,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      height: 20,
    );
  }

  void _showGenrePickerDialog(
    BuildContext context,
    Function(String) onEdit,
    TextEditingController controller,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Seleccionar Género Literario',
            style: textTheme.headlineSmall,
          ),
          content: Column(
            children: [
              _buildGenreItem(context, 'Anime', onEdit, controller),
              _buildGenreItem(context, 'Autoayuda', onEdit, controller),
              _buildGenreItem(context, 'Biografia', onEdit, controller),
              _buildGenreItem(context, 'Ciencia Ficción', onEdit, controller),
              _buildGenreItem(context, 'Ciencia', onEdit, controller),
              _buildGenreItem(context, 'Comida', onEdit, controller),
              _buildGenreItem(context, 'Fantasia', onEdit, controller),
              _buildGenreItem(context, 'Ficcion', onEdit, controller),
              _buildGenreItem(context, 'Historia', onEdit, controller),
              _buildGenreItem(context, 'Horror', onEdit, controller),
              _buildGenreItem(context, 'Misterio', onEdit, controller),
              _buildGenreItem(context, 'No-Ficcion', onEdit, controller),
              _buildGenreItem(context, 'Romance', onEdit, controller),
              _buildGenreItem(context, 'Poesia', onEdit, controller),
              _buildGenreItem(context, 'Thriller', onEdit, controller),
              _buildGenreItem(context, 'Viajes', onEdit, controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenreItem(
    BuildContext context,
    String genre,
    Function(String) onEdit,
    TextEditingController controller,
  ) {
    return InkWell(
      onTap: () {
        onEdit(genre);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(genre),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String title,
    String hint,
    Function(String) onEdit,
    TextEditingController controller,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hint),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: textTheme.displayMedium?.copyWith(
                  color: AppColors.lightPink,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onEdit(controller.text);
                Navigator.of(context).pop();
              },
              child: Text(
                'Guardar',
                style: textTheme.displayMedium?.copyWith(
                  color: AppColors.lightPink,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
