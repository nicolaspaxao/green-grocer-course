import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda_com_getx/src/pages/common/custom_text_field.dart';
import 'package:quitanda_com_getx/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Perfil',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: GetBuilder<AuthController>(
          builder: (controller) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              children: [
                CustomTextField(
                  label: 'E-mail',
                  icon: Icons.email,
                  initialValue: controller.user.email!,
                  isReadOnly: true,
                ),
                CustomTextField(
                  label: 'Nome',
                  icon: Icons.person,
                  initialValue: controller.user.name!,
                  isReadOnly: true,
                ),
                CustomTextField(
                  label: 'Celular',
                  icon: Icons.phone,
                  initialValue: controller.user.phone!,
                  isReadOnly: true,
                ),
                CustomTextField(
                  label: 'CPF',
                  icon: Icons.file_copy,
                  isSecret: true,
                  initialValue: controller.user.cpf!,
                  isReadOnly: true,
                ),
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      updatePassword();
                    },
                    child: const Text(
                      'Atualizar senha',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final keyForm = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomTextField(
                        controller: currentPasswordController,
                        label: 'Senha atual',
                        icon: Icons.lock,
                        isSecret: true,
                        validator: Validators.passwordValidator,
                      ),
                      CustomTextField(
                        controller: newPasswordController,
                        label: 'Nova senha',
                        icon: Icons.lock_outline,
                        isSecret: true,
                        validator: Validators.passwordValidator,
                      ),
                      CustomTextField(
                        label: 'Confirmar nova senha',
                        icon: Icons.lock_outline,
                        isSecret: true,
                        validator: (password) {
                          final result = Validators.passwordValidator(password);
                          if (result != null) {
                            return result;
                          }
                          if (password != newPasswordController.text) {
                            return 'As senhão não são equivalentes';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 50,
                        child: GetBuilder<AuthController>(
                          builder: (controller) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      if (keyForm.currentState!.validate()) {
                                        controller.changePassword(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        );
                                      }
                                    },
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Atualizar',
                                      style: TextStyle(fontSize: 18),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
