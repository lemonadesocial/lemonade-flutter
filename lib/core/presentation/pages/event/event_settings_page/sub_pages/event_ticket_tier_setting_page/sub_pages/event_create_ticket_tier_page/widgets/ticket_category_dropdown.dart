import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/data/event/dtos/event_ticket_category_dto/event_ticket_category_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_category_bottom_sheet_form.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_ticket_categories.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TicketCategoryDropdown extends StatelessWidget {
  final Event event;
  const TicketCategoryDropdown({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
      builder: (context, state) {
        return Query$GetEventTicketCategories$Widget(
          options: Options$Query$GetEventTicketCategories(
            variables: Variables$Query$GetEventTicketCategories(
              event: event.id ?? '',
            ),
            fetchPolicy: FetchPolicy.networkOnly,
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.isLoading) {
              return Loading.defaultLoading(context);
            }
            if (result.hasException || result.parsedData == null) {
              return const EmptyList();
            }

            final ticketCategories = result.parsedData?.getEventTicketCategories
                    .map(
                      (item) => EventTicketCategory.fromDto(
                        EventTicketCategoryDto.fromJson(item.toJson()),
                      ),
                    )
                    .toList() ??
                [];

            return DropdownButtonHideUnderline(
              child: DropdownButton2(
                value: state.category,
                onChanged: (value) {
                  if (value == 'create') {
                    showCupertinoModalBottomSheet(
                      bounce: true,
                      backgroundColor: LemonColor.atomicBlack,
                      context: context,
                      builder: (newContext) {
                        return CreateTicketCategoryBottomsheetForm(
                          onSubmit: (title, description) async {
                            Navigator.of(newContext).pop();
                            final response = await showFutureLoadingDialog(
                              context: context,
                              future: () => getIt<EventTicketRepository>()
                                  .createEventTicketCategory(
                                input: Input$CreateEventTicketCategoryInput(
                                  event: event.id ?? '',
                                  title: title,
                                  description: description,
                                ),
                              ),
                            );
                            response.result?.fold((l) => null,
                                (newCategory) async {
                              await refetch?.call();
                              context.read<ModifyTicketTypeBloc>().add(
                                    ModifyTicketTypeEvent.onCategoryChanged(
                                      category: newCategory.id,
                                    ),
                                  );
                            });
                          },
                        );
                      },
                    );
                    return;
                  }

                  context.read<ModifyTicketTypeBloc>().add(
                        ModifyTicketTypeEvent.onCategoryChanged(
                          category: value,
                        ),
                      );
                },
                customButton: Container(
                  padding: EdgeInsets.all(Spacing.smMedium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                    color: colorScheme.secondaryContainer,
                  ),
                  child: _TicketCategoryItem(
                    key: Key(state.category ?? ''),
                    ticketCategory: ticketCategories
                        .firstWhereOrNull((item) => item.id == state.category),
                    trailing: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowDown.svg(
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        colorFilter: filter,
                      ),
                    ),
                  ),
                ),
                items: [
                  ...ticketCategories.map(
                    (ticketCategory) => DropdownMenuItem(
                      value: ticketCategory.id,
                      child: _TicketCategoryItem(
                        ticketCategory: ticketCategory,
                      ),
                    ),
                  ),
                  const DropdownMenuItem(
                    value: 'create',
                    child: _CreateButtonItem(),
                  ),
                ],
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                    color: colorScheme.secondaryContainer,
                  ),
                  offset: Offset(0, -Spacing.superExtraSmall),
                  maxHeight: 200.w,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  overlayColor:
                      MaterialStatePropertyAll(LemonColor.darkBackground),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CreateButtonItem extends StatelessWidget {
  const _CreateButtonItem();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ThemeSvgIcon(
          color: LemonColor.paleViolet,
          builder: (colorFilter) => Assets.icons.icAdd.svg(
            colorFilter: colorFilter,
          ),
        ),
        SizedBox(
          width: Spacing.xSmall,
        ),
        Expanded(
          flex: 1,
          child: Text(
            t.event.ticketTierSetting.categorySetting.newCategory,
            style: Typo.mediumPlus.copyWith(
              color: LemonColor.paleViolet,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _TicketCategoryItem extends StatelessWidget {
  final Widget? trailing;
  final EventTicketCategory? ticketCategory;
  const _TicketCategoryItem({
    super.key,
    this.trailing,
    this.ticketCategory,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaceholder = ticketCategory == null;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            isPlaceholder
                ? t.event.ticketTierSetting.categorySetting.selectCategory
                : ticketCategory?.title ?? '',
            style: Typo.mediumPlus.copyWith(
              color: isPlaceholder
                  ? colorScheme.onSecondary
                  : colorScheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
