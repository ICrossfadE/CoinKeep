import 'package:CoinKeep/presentation/widgets/ColorPicker.dart';
import 'package:CoinKeep/presentation/widgets/ColorView.dart';
import 'package:CoinKeep/src/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:CoinKeep/logic/blocs/getWallet_cubit/get_wallet_cubit.dart';
import 'package:CoinKeep/logic/blocs/setWallet_bloc/set_wallet_bloc.dart';
import 'package:CoinKeep/presentation/widgets/InputText.dart';
import 'package:CoinKeep/presentation/widgets/VerticalSwipeList.dart';
import 'package:CoinKeep/presentation/widgets/WidthButton.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({super.key});

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<SetWalletBloc>()
        .add(ResetState(walletColor: ColorUtils.randomColorHex()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Клавіатура не змінює розмір вмісту
      backgroundColor: kDarkBg,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: WidthButton(
                buttonColor: kConfirmColor,
                buttonText: 'Add new Wallet',
                buttonTextStyle: kWidthButtonStyle,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: kDark500,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16,
                            MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Create new Wallet',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            InputText(
                              hintName: 'Wallet Name',
                              func: (value) {
                                context
                                    .read<SetWalletBloc>()
                                    .add(UpdateName(value));
                              },
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SetWalletBloc, SetWalletState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          50, // Фіксована ширина для ColorView
                                      height:
                                          50, // Фіксована висота для ColorView
                                      child: ColorView(
                                          colorValue: state.walletColor),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: WidthButton(
                                        buttonColor: kDefaultlColor,
                                        buttonText: 'Choise Color',
                                        buttonTextStyle: kWidthButtonStyle,
                                        onPressed: () => {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              print(state.walletColor);
                                              return AlertDialog(
                                                title: const Text(
                                                  'Choose Color',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor: kDark500,
                                                content: ColorPicker(
                                                  initialColor:
                                                      state.walletColor,
                                                  onConfirm: (Color color) {
                                                    // Оновлюємо колір
                                                    context
                                                        .read<SetWalletBloc>()
                                                        .add(UpdateColor(
                                                            ColorUtils
                                                                .colorToHex(
                                                                    color)));
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            WidthButton(
                              buttonColor: kConfirmColor,
                              buttonText: 'Create Wallet',
                              buttonTextStyle: kWidthButtonStyle,
                              onPressed: () => {
                                context
                                    .read<SetWalletBloc>()
                                    .add(const Create()),
                                Navigator.pop(context)
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetWalletCubit, GetWalletState>(
                builder: (context, state) {
                  if (state.wallets.isEmpty) {
                    return const Center(
                        child: Text(
                      'No Wallets found',
                      style: TextStyle(color: Colors.amber),
                    ));
                  }
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        // minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height - 20,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            VerticalSwipeList(
                              wallets: state.wallets,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
