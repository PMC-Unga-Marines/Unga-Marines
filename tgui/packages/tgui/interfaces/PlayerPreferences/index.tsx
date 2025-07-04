import { Button, Flex, Section, Tabs } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { BackgroundInformation } from './BackgroundInformation';
import { CharacterCustomization } from './CharacterCustomization';
import { DrawOrder } from './DrawOrder';
import { GameSettings } from './GameSettings';
import { GearCustomization } from './GearCustomisation';
import { JobPreferences } from './JobPreferences';
import { KeybindSettings } from './KeybindSettings';
import { YautjaCustomization } from './YautjaCustomization';

export const PlayerPreferences = (props) => {
  const { act, data } = useBackend<PlayerPreferencesData>();

  const { save_slot_names, slot, tabIndex } = data;

  let affectsSave = false;
  let CurrentTab = CharacterCustomization;
  switch (tabIndex) {
    case 1:
      CurrentTab = CharacterCustomization;
      affectsSave = true;
      break;
    case 2:
      CurrentTab = YautjaCustomization;
      affectsSave = true;
      break;
    case 3:
      CurrentTab = BackgroundInformation;
      affectsSave = true;
      break;
    case 4:
      CurrentTab = GearCustomization;
      affectsSave = true;
      break;
    case 5:
      CurrentTab = JobPreferences;
      affectsSave = true;
      break;
    case 6:
      CurrentTab = GameSettings;
      break;
    case 7:
      CurrentTab = KeybindSettings;
      break;
    case 8:
      CurrentTab = DrawOrder;
      break;
    default:
  }

  // I dont like this shit, but it doesn't matter in the end
  // i'd rather massage the data in js than byond.
  const slotNames = Object.values(save_slot_names).map(
    (name) => name.split(' ')[0],
  );

  const saveSlots = new Array(10).fill(1).map((_, idx) => (
    <Button
      key={idx + 1}
      selected={idx + 1 === slot}
      onClick={() => act('changeslot', { changeslot: idx + 1 })}
    >
      {slotNames[idx] || `Character ${idx + 1}`}
    </Button>
  ));

  return (
    <Window width={1140} height={650}>
      <Window.Content scrollable>
        <Flex>
          <Flex.Item>
            <NavigationSelector tabIndex={tabIndex} />
          </Flex.Item>
          <Flex.Item grow={1} basis={0}>
            {affectsSave ? (
              <Section title="Save slot" buttons={saveSlots}>
                <CurrentTab />
              </Section>
            ) : (
              <CurrentTab />
            )}
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const NavigationSelector = (props) => {
  const { tabIndex } = props;
  const { act } = useBackend();
  return (
    <Tabs vertical>
      <Tabs.Tab
        selected={tabIndex === 1}
        onClick={() => act('tab_change', { tabIndex: 1 })}
      >
        Character Customization
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 2}
        onClick={() => act('tab_change', { tabIndex: 2 })}
      >
        Predator Customization
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 3}
        onClick={() => act('tab_change', { tabIndex: 3 })}
      >
        Background Information
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 4}
        onClick={() => act('tab_change', { tabIndex: 4 })}
      >
        Gear Customization
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 5}
        onClick={() => act('tab_change', { tabIndex: 5 })}
      >
        Job Preferences
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 6}
        onClick={() => act('tab_change', { tabIndex: 6 })}
      >
        Game Settings
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 7}
        onClick={() => act('tab_change', { tabIndex: 7 })}
      >
        Keybindings
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 8}
        onClick={() => act('tab_change', { tabIndex: 8 })}
      >
        Draw Order
      </Tabs.Tab>
    </Tabs>
  );
};
