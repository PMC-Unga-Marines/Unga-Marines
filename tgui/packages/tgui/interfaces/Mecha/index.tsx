import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { MainData } from './data';
import { OperatorMode } from './OperatorMode';

export const Mecha = () => {
  const { data } = useBackend<MainData>();
  if (data.isoperator) {
    return (
      <Window theme={'ntos'}>
        <Window.Content>
          <OperatorMode />
        </Window.Content>
      </Window>
    );
  }
};
