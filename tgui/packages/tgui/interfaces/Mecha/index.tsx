import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { MainData } from './data';
import { OperatorMode } from './OperatorMode';

export const Mecha = () => {
  const { data } = useBackend<MainData>();
  if (data.isoperator) {
    return (
      <Window theme={'ntos'} width={860} height={700}>
        <Window.Content>
          <OperatorMode />
        </Window.Content>
      </Window>
    );
  }
};
