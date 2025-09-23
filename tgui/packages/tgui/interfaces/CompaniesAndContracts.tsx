import { Button } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const TestUI = () => {
  const { act, data } = useBackend();
  return (
    <Window>
      <Button onClick={() => act('click')}>{data.text}</Button>
    </Window>
  );
};
