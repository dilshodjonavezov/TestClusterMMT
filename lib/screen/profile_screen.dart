import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cluster/widgets/language_service.dart';
import 'dart:io';
import '../services/language_service.dart';

class ProfileScreen extends StatefulWidget {
  final String languageCode;

  const ProfileScreen({
    Key? key,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _fullName = '';
  String _cluster = '';
  int _bestScore = 0;
  String? _profileImagePath;
  bool _isFirstTime = true;
  
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullName = prefs.getString('user_fullname') ?? '';
      _cluster = prefs.getString('user_cluster') ?? '';
      _bestScore = prefs.getInt('user_best_score') ?? 0;
      _profileImagePath = prefs.getString('user_profile_image');
      _isFirstTime = _fullName.isEmpty;
    });
    
    if (_isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWelcomeDialog();
      });
    }
    
    _nameController.text = _fullName;
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_fullname', _fullName);
    await prefs.setString('user_cluster', _cluster);
    await prefs.setInt('user_best_score', _bestScore);
    if (_profileImagePath != null) {
      await prefs.setString('user_profile_image', _profileImagePath!);
    }
  }

  void _showWelcomeDialog() {
    final localizations = AppLocalizations(widget.languageCode);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person_add, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.languageCode == 'tj' ? 'Хуш омадед!' : 'Добро пожаловать!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.languageCode == 'tj' 
                  ? 'Лутфан номи пурраи худро ворид кунед'
                  : 'Пожалуйста, введите ваше полное имя',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: localizations.translate('full_name'),
                hintText: widget.languageCode == 'tj' 
                    ? 'Иброҳим Раҳимов'
                    : 'Иван Иванов',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
                ),
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.trim().isNotEmpty) {
                setState(() {
                  _fullName = _nameController.text.trim();
                  _isFirstTime = false;
                });
                _saveProfile();
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.languageCode == 'tj'
                          ? 'Лутфан номро ворид кунед'
                          : 'Пожалуйста, введите имя',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(
              widget.languageCode == 'tj' ? 'Сабт кардан' : 'Сохранить',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
      });
      _saveProfile();
    }
  }

  void _editProfile() {
    final localizations = AppLocalizations(widget.languageCode);
    _nameController.text = _fullName;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(localizations.translate('edit_profile')),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: localizations.translate('full_name'),
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(widget.languageCode == 'tj' ? 'Бекор кардан' : 'Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.trim().isNotEmpty) {
                setState(() {
                  _fullName = _nameController.text.trim();
                });
                _saveProfile();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              widget.languageCode == 'tj' ? 'Сабт кардан' : 'Сохранить',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(widget.languageCode);
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF667EEA), Color(0xFFF8F9FA)],
          stops: [0.0, 0.3],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // Фото профиля
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: _profileImagePath == null
                          ? const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            )
                          : null,
                      border: Border.all(color: Colors.white, width: 5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: _profileImagePath != null
                        ? ClipOval(
                            child: Image.file(
                              File(_profileImagePath!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.person, size: 70, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF667EEA), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Color(0xFF667EEA),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Имя пользователя
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: Text(
                _fullName.isEmpty 
                    ? localizations.translate('full_name') 
                    : _fullName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Кнопка редактирования
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: TextButton.icon(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                label: Text(
                  localizations.translate('edit_profile'),
                  style: const TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Карточки со статистикой
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            icon: Icons.school,
                            title: localizations.translate('your_cluster'),
                            value: _cluster.isEmpty 
                                ? '-' 
                                : '${widget.languageCode == 'tj' ? 'Кластер' : 'Кластер'} $_cluster',
                            color: const Color(0xFF667EEA),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _StatCard(
                            icon: Icons.emoji_events,
                            title: localizations.translate('best_score'),
                            value: _bestScore == 0 ? '-' : '$_bestScore%',
                            color: const Color(0xFFFFA726),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFA726), Color(0xFFFF6F00)],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Карточка с подсказкой
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF667EEA).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.lightbulb_outline,
                              color: Color(0xFF667EEA),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              widget.languageCode == 'tj'
                                  ? 'Санҷишҳоро гузаронед то кластери худро муайян кунед!'
                                  : 'Проходите тесты, чтобы определить свой кластер!',
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Достижения
                  if (_bestScore > 0)
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 700),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00B894), Color(0xFF00D2D3)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00B894).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.military_tech,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '🎉',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    widget.languageCode == 'tj'
                                        ? 'Табрикот! Шумо дар роҳи дуруст ҳастед!'
                                        : 'Поздравляем! Вы на правильном пути!',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final Gradient gradient;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF636E72),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}