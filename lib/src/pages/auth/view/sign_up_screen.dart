import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quitanda_com_getx/src/pages/common/custom_text_field.dart';
import 'package:quitanda_com_getx/src/config/colors.dart';
import 'package:quitanda_com_getx/src/services/validators.dart';

import '../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  final _formState = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            label: 'E-mail',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.emailValidator,
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                          ),
                          CustomTextField(
                            label: 'Senha',
                            icon: Icons.lock,
                            isSecret: true,
                            validator: Validators.passwordValidator,
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                          ),
                          CustomTextField(
                            label: 'Nome',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: Validators.nameValidator,
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                          ),
                          CustomTextField(
                            label: 'Celular',
                            icon: Icons.phone,
                            inputFormatters: [phoneFormatter],
                            keyboardType: TextInputType.phone,
                            validator: Validators.phoneValidator,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                          ),
                          CustomTextField(
                            label: 'CPF',
                            icon: Icons.file_copy,
                            keyboardType: TextInputType.number,
                            validator: Validators.cpfValidator,
                            inputFormatters: [
                              cpfFormatter,
                            ],
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formState.currentState!
                                            .validate()) {
                                          _formState.currentState!.save();
                                          authController.signUp();
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Cadastrar usuário',
                                        style: TextStyle(fontSize: 18),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
