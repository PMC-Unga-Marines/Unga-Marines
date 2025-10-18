// contract.jsx
import { Box, Button, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Contract = () => {
  const { act, data } = useBackend();

  return (
    <Window width={800} height={600} theme={'contract'}>
      <Window.Content scrollable>
        <Section title="Система Контрактов">
          <Box mb={2}>
            <Button
              icon="file-contract"
              onClick={() => act('create_contract')}
              tooltip="Создать новый контракт"
            >
              Создать контракт
            </Button>
          </Box>
        </Section>

        {/* Здесь потом добавим остальные секции */}
      </Window.Content>
    </Window>
  );
};
