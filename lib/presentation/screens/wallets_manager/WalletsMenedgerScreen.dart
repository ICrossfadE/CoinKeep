import 'package:CoinKeep/presentation/widgets/ColorPicker.dart';
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
import 'package:iconly/iconly.dart';

class WalletsManagerScreen extends StatefulWidget {
  const WalletsManagerScreen({super.key});

  @override
  _WalletsManagerScreenState createState() => _WalletsManagerScreenState();
}

class _WalletsManagerScreenState extends State<WalletsManagerScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: WidthButton(
                buttonColor: kConfirmColor.withAlpha(200),
                buttonText: 'Add new Wallet',
                buttonTextStyle: kSmallText,
                borderRadius: 10,
                buttonBorder:
                    BorderSide(width: 2, color: Colors.white.withOpacity(0.2)),
                buttonIcon: IconlyLight.plus,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: kDark500,
                    builder: (BuildContext context) {
                      return _WalletCreationModal();
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetWalletCubit, GetWalletState>(
                builder: (context, walletState) {
                  if (walletState.wallets.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Wallets found',
                        style: kSmallText,
                      ),
                    );
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
                              wallets: walletState.wallets,
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

class _WalletCreationModal extends StatefulWidget {
  @override
  __WalletCreationModalState createState() => __WalletCreationModalState();
}

class __WalletCreationModalState extends State<_WalletCreationModal> {
  bool walletHaveName = false;

  @override
  void initState() {
    super.initState();
    context
        .read<SetWalletBloc>()
        .add(ResetState(walletColor: ColorUtils.randomColorHex()));
  }

  void validationWaletName(bool value) {
    setState(() {
      walletHaveName = value;
    });
  }

  void _validationCreating() {
    if (walletHaveName) {
      context.read<SetWalletBloc>().add(const Create());
      Navigator.pop(context);

      validationWaletName(false);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create new Wallet',
            style: kSmallText,
          ),
          const SizedBox(height: 20),
          InputText(
            hintName: 'Wallet Name',
            func: (value) {
              if (value.isNotEmpty) {
                context.read<SetWalletBloc>().add(UpdateName(value));
                validationWaletName(true); // Оновлення стану
              } else {
                validationWaletName(false); // Оновлення стану
              }
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<SetWalletBloc, SetWalletState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: WidthButton(
                      // Колір вибраного мвйбутнього гаманця
                      buttonColor: ColorUtils.hexToColor(state.walletColor)
                          .withAlpha(200),
                      buttonText: 'Choise Color',
                      buttonTextStyle: kSmallText,
                      borderRadius: 10,
                      buttonBorder: BorderSide(
                          width: 2, color: Colors.white.withOpacity(0.2)),
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Choose Color',
                                textAlign: TextAlign.center,
                                style: kMediumText,
                              ),
                              backgroundColor: kDark500,
                              content: ColorPicker(
                                initialColor: state.walletColor,
                                onConfirm: (Color color) {
                                  // Оновлюємо колір
                                  context.read<SetWalletBloc>().add(UpdateColor(
                                      ColorUtils.colorToHex(color)));
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
            buttonColor: walletHaveName
                ? kConfirmColor.withAlpha(200)
                : kDisabledConfirmColor.withAlpha(80),
            buttonText: 'Create Wallet',
            buttonTextStyle: walletHaveName ? kSmallText : kSmallTextP,
            borderRadius: 10,
            buttonBorder:
                BorderSide(width: 2, color: Colors.white.withOpacity(0.2)),
            onPressed: _validationCreating,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
