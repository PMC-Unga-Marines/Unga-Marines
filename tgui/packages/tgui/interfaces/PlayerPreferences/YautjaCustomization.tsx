import { useBackend } from '../../backend';
import { Section, Flex, LabeledList, Box, ColorBox, Button } from '../../components';
import { TextFieldPreference, SelectFieldPreference } from './FieldPreferences';
import { ProfilePicture } from './ProfilePicture';

export const YautjaCustomization = (props, context) => {
  const { act, data } = useBackend<YautjaCustomizationData>(context);
  const {
    has_wl,
    legacy,
    predator_name,
    predator_gender,
    predator_age,
    predator_h_style,
    predator_skin_color,
    predator_translator_type,
    predator_mask_type,
    predator_armor_type,
    predator_boot_type,
    predator_armor_material,
    predator_mask_material,
    predator_greave_material,
    predator_caster_material,
    predator_cape_type,
    predator_cape_color,
    predator_flavor_text,
    pred_r_eyes,
    pred_g_eyes,
    pred_b_eyes,
    yautja_status,
  } = data;

  const rgbToHex = (red, green, blue) => {
    const convert = (comp) => {
      const hex = comp.toString(16);
      return hex.length === 1 ? `0${hex}` : hex;
    };
    return '#' + convert(red) + convert(green) + convert(blue);
  };

  return has_wl ? (
    <>
      <Section title="Yautja Information">
        <Flex>
          <Flex.Item>
            <LabeledList>
              <SelectFieldPreference
                label={'Yautja Name'}
                value={'predator_name'}
                action={'predator_name'}
              />
              <SelectFieldPreference
                label={'Yautja Gender'}
                value={'predator_gender'}
                action={'predator_gender'}
              />
              <SelectFieldPreference
                label={'Yautja Age'}
                value={'predator_age'}
                action={'predator_age'}
              />
              <SelectFieldPreference
                label={'Yautja Quill Style'}
                value={'predator_h_style'}
                action={'predator_h_style'}
              />
              <SelectFieldPreference
                label={'Yautja Skin Color'}
                value={'predator_skin_color'}
                action={'predator_skin_color'}
              />
              <TextFieldPreference
                label={'Eye Color'}
                value={rgbToHex(pred_r_eyes, pred_g_eyes, pred_b_eyes)}
                noAction
                extra={
                  <>
                    <ColorBox
                      color={rgbToHex(pred_r_eyes, pred_g_eyes, pred_b_eyes)}
                      mr={1}
                    />
                    <Button icon="edit" onClick={() => act('pred_eyecolor')} />
                  </>
                }
              />
              <SelectFieldPreference
                label={'Yautja Flavor Text'}
                value={'predator_flavor_text'}
                action={'predator_flavor_text'}
              />
              {yautja_status ? (
                <SelectFieldPreference
                  label={'Yautja Whitelist Status'}
                  value={'yautja_status'}
                  action={'yautja_status'}
                />
              ) : (
                <SelectFieldPreference
                  label={'Yautja Whitelist Status'}
                  value="None"
                  action={'yautja_status'}
                />
              )}
            </LabeledList>
          </Flex.Item>
          <Flex.Item>
            <ProfilePicture />
          </Flex.Item>
        </Flex>
      </Section>
      <Section title="Equipment Setup">
        <Flex>
          <Flex.Item>
            <LabeledList>
              {legacy ? (
                <SelectFieldPreference
                  label={'Legacy Gear'}
                  value={'predator_use_legacy'}
                  action={'predator_use_legacy'}
                />
              ) : (
                <SelectFieldPreference label={'Legacy Gear'} value="Disabled" />
              )}
              <SelectFieldPreference
                label={'Translator Type'}
                value={'predator_translator_type'}
                action={'predator_translator_type'}
              />
              <SelectFieldPreference
                label={'Mask Style'}
                value={'predator_mask_type'}
                action={'predator_mask_type'}
              />
              <SelectFieldPreference
                label={'Armor Style'}
                value={'predator_armor_type'}
                action={'predator_armor_type'}
              />
              <SelectFieldPreference
                label={'Greave Style'}
                value={'predator_boot_type'}
                action={'predator_boot_type'}
              />
              <SelectFieldPreference
                label={'Mask Material'}
                value={'predator_mask_material'}
                action={'predator_mask_material'}
              />
              <SelectFieldPreference
                label={'Armor Material'}
                value={'predator_armor_material'}
                action={'predator_armor_material'}
              />
              <SelectFieldPreference
                label={'Greave Material'}
                value={'predator_greave_material'}
                action={'predator_greave_material'}
              />
              <SelectFieldPreference
                label={'Caster Material'}
                value={'predator_caster_material'}
                action={'predator_caster_material'}
              />
            </LabeledList>
          </Flex.Item>
        </Flex>
      </Section>
      <Section title="Clothing Setup">
        <Flex>
          <Flex.Item>
            <LabeledList>
              <SelectFieldPreference
                label={'Cape Type'}
                value={'predator_cape_type'}
                action={'predator_cape_type'}
              />
              <TextFieldPreference
                label={'Cape Color'}
                value={predator_cape_color}
                noAction
                extra={
                  <>
                    <ColorBox color={predator_cape_color} mr={1} />
                    <Button
                      icon="edit"
                      onClick={() => act('predator_cape_color')}
                    />
                  </>
                }
              />
            </LabeledList>
          </Flex.Item>
        </Flex>
      </Section>
    </>
  ) : (
    <Box>WL required</Box>
  );
};
