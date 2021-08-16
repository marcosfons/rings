import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/auth/sign_in/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
	const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

	final _passwordVisibilityNotifier = ValueNotifier<bool>(true);

	@override
  void dispose() {
		_passwordVisibilityNotifier.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
		final controller = Get.find<SignInController>();

		return Scaffold(
			body: Column(
				children: [
					const Spacer(),
					Center(
						child: ConstrainedBox(
							constraints: BoxConstraints(
								maxWidth: 230
							),
							child: Image.asset('assets/images/logo.png')
						),
					),
					const Spacer(),
					Center(
					  child: Padding(
					    padding: const EdgeInsets.symmetric(
					  		horizontal: 14
					  	),
					    child: ConstrainedBox(
					  		constraints: BoxConstraints(
					  			maxWidth: 400
					  		),
					  		child: Column(
					  			mainAxisSize: MainAxisSize.min,
					  			children: [
					  			Text(
					  				'Login',
					  				style: TextStyle(
					  					fontSize: 26,
					  					fontWeight: FontWeight.w700
					  				),
					  			),
					  			const SizedBox(height: 30,),
					  				TextField(
					  					decoration: InputDecoration(
					  						labelText: 'E-mail'
					  					),
											onChanged: (email) => controller.email = email,
					  				),
					  				const SizedBox(height: 18,),
					  				ValueListenableBuilder<bool>(
					  				valueListenable: _passwordVisibilityNotifier,
					  				builder: (context, value, child) {
					  					return TextField(
					  						obscureText: value,
					  						decoration: InputDecoration(
					  							labelText: 'Senha',
					  							suffixIcon: IconButton(
					  								icon: Icon(value ? Icons.visibility : Icons.visibility_off),
					  								onPressed: () {
					  									_passwordVisibilityNotifier.value = !value;
					  								},
					  							)
					  						),
												onChanged: (password) => controller.password = password,
					  					);
					  				}
					  			),
					  			const SizedBox(height: 12,),
					  				Align(
					  					alignment: Alignment.bottomRight,
					  					child: TextButton(
					  						onPressed: () {},
					  						child: Padding(
					  							padding: const EdgeInsets.symmetric(
					  								horizontal: 10
					  							),
					  							child: Text(
					  								'Esqueceu sua senha?'
					  							),
					  						),
					  					),
					  				)
					  			],
					  		),
					  	),
					  ),
					),
					const Spacer(),
					Padding(
					  padding: const EdgeInsets.symmetric(horizontal: 12),
					  child: Center(
					  	child: ConstrainedBox(
					  	  constraints: BoxConstraints(maxWidth: 400),
					  	  child: Column(
									mainAxisSize: MainAxisSize.min,
									crossAxisAlignment: CrossAxisAlignment.end,
					  	    children: [
										Obx(() {
											if (controller.hasError) {
												return Padding(
												  padding: const EdgeInsets.only(right: 6.0),
												  child: Text(
												  	controller.error.toString(),
														textAlign: TextAlign.right,
												  	style: TextStyle(
												  		color: Colors.red
												  	),
												  ),
												);
											}
											return const SizedBox();
										}),
										const SizedBox(height: 8,),
					  	      SizedBox(
					  	        width: double.infinity,
					  	        child: Obx(() => ElevatedButton(
												onPressed: controller.isLoading
													? null
													: controller.signIn,
												child: Padding(
													padding: const EdgeInsets.symmetric(
														vertical: 14
													),
													child: AnimatedCrossFade(
														firstChild: Text(
															'Entrar',
															style: TextStyle(
																fontSize: 16
															),
														),
														secondChild: const Center(child: CircularProgressIndicator(strokeWidth: 1,),),
														crossFadeState: controller.isLoading
															? CrossFadeState.showSecond
															: CrossFadeState.showFirst,
														duration: Duration(milliseconds: 5),
													),
												)),
											),
					  	      ),
					  	    ],
					  	  ),
					  	),
					  ),
					),
					const Spacer(),
				],
			),
		);
	}
}