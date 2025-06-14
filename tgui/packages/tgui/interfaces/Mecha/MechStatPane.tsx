import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { OperatorData } from './data';

export const MechStatPane = () => {
  const { act, data } = useBackend<OperatorData>();
  const { name, integrity, weapons_safety } = data;
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section
          title={name}
          buttons={<Button onClick={() => act('changename')}>Rename</Button>}
        />
      </Stack.Item>
      <Stack.Item>
        <Section title="Status">
          <LabeledList>
            <LabeledList.Item label="Integrity">
              <ProgressBar
                ranges={{
                  good: [0.5, Infinity],
                  average: [0.25, 0.5],
                  bad: [-Infinity, 0.25],
                }}
                value={integrity}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Power">
              <PowerBar />
            </LabeledList.Item>
            <LabeledList.Item label="Safety">
              <Button
                color={weapons_safety ? 'red' : ''}
                onClick={() => act('toggle_safety')}
              >
                {weapons_safety ? 'Dis' : 'En'}able
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const PowerBar = () => {
  const { data } = useBackend<OperatorData>();
  const { power_level, power_max } = data;
  if (power_max === null) {
    return <Box> No Power cell installed!</Box>;
  } else {
    return (
      <ProgressBar
        ranges={{
          good: [0.75 * power_max, Infinity],
          average: [0.25 * power_max, 0.75 * power_max],
          bad: [-Infinity, 0.25 * power_max],
        }}
        maxValue={power_max}
        value={power_level}
      />
    );
  }
};
