import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, Stack } from '../components';
import { Window } from '../layouts';

export const ClanMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    player_rank_pos,
    clan_id,
    clan_name,
    clan_description,
    clan_honor,
    player_rename_clan,
    player_setdesc_clan,
    player_sethonor_clan,
    player_setcolor_clan,
    player_delete_clan,
    player_modify_ranks,
    player_move_clans,
    player_purge,
    clan_keys,
  } = data;

  return (
    <Window resizable width={600} height={600}>
      <Window.Content
        scrollable
        style={{
          'background-color': '#23221f',
          'background-image': `url("uiBackground-Pred.png")`,
          'background-position': `50% 0`,
          'background-repeat': 'repeat-x',

          'td': {
            'padding': '10px 10px 10px 10px',
            'border-bottom': '1px solid #252933',
          },

          'th': {
            'padding': '10px 10px 10px 10px',
            'border-bottom': '1px solid #252933',
          },

          'h3': {
            'margin': '0',
            'padding': '0',
          },

          'h1': {
            'margin': '0',
            'padding': '0',
          },
        }}>
        <Stack fill vertical>
          <Stack.Item textAlign="center" bold>
            <h1 className="whiteTitle">{clan_name}</h1>
            <pre className="whiteDescription">{clan_description}</pre>
            <h3 className="whiteTitle">Honor: {clan_honor}</h3>
            <table>
              <tr>
                {player_rename_clan ? (
                  <td>
                    <div unselectable="on">
                      <Button
                        content="Rename Clan"
                        onClick={() => act('rename', { clan_id: clan_id })}
                      />
                    </div>
                  </td>
                ) : null}
                {player_setdesc_clan ? (
                  <td>
                    <div unselectable="on">
                      <Button
                        content="Set Description"
                        onClick={() => act('setdesc', { clan_id: clan_id })}
                      />
                    </div>
                  </td>
                ) : null}
                {player_sethonor_clan ? (
                  <td>
                    <div unselectable="on">
                      <Button
                        content="Set Honor"
                        onClick={() => act('sethonor', { clan_id: clan_id })}
                      />
                    </div>
                  </td>
                ) : null}
                {player_setcolor_clan ? (
                  <td>
                    <div unselectable="on">
                      <Button
                        content="Set Color"
                        onClick={() => act('setcolor', { clan_id: clan_id })}
                      />
                    </div>
                  </td>
                ) : null}
                {player_delete_clan ? (
                  <td>
                    <div unselectable="on">
                      <Button
                        content="Delete Clan"
                        onClick={() => act('delete', { clan_id: clan_id })}
                      />
                    </div>
                  </td>
                ) : null}
              </tr>
            </table>
          </Stack.Item>
          <Stack.Item>
            <table className="clan_list">
              <tr textAlign="left">
                <th className="noPadCell" />
                <th>Name</th>
                <th>Rank</th>
                <th>Honor</th>
                {player_modify_ranks ? <th /> : null}
                {player_move_clans ? <th /> : null}
                {player_purge ? <th /> : null}
              </tr>
              {clan_keys.map((x, index) => (
                <GetPredInfo
                  key={x.index}
                  name={x.name}
                  rank={x.rank}
                  rank_pos={x.rank_pos}
                  honor={x.honor}
                  player_rank_pos={player_rank_pos}
                  player_modify_ranks={player_modify_ranks}
                  player_move_clans={player_move_clans}
                  player_purge={player_purge}
                />
              ))}
            </table>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const GetPredInfo = (props, context) => {
  const { act } = useBackend(context);
  const {
    name,
    rank,
    rank_pos,
    honor,
    player_rank_pos,
    player_modify_ranks,
    player_move_clans,
    player_purge,
  } = props;

  return (
    <tr textAlign="center">
      <td className="noPadCell" />
      <td>{name}</td>
      <td>{rank}</td>
      <td>{honor}</td>
      {player_rank_pos > rank_pos ? (
        <Fragment>
          {player_modify_ranks ? (
            <td>
              <div unselectable="on">
                <Button
                  content="Set Rank"
                  onClick={() => act('modifyrank', { ckey: name })}
                />
              </div>
            </td>
          ) : null}
          {player_move_clans ? (
            <td>
              <div unselectable="on">
                <Button
                  content="Move Clans"
                  onClick={() => act('moveclan', { ckey: name })}
                />
              </div>
            </td>
          ) : null}
          {player_purge ? (
            <td>
              <div unselectable="on">
                <Button
                  content="Purge"
                  onClick={() => act('purge', { ckey: name })}
                />
              </div>
            </td>
          ) : null}
        </Fragment>
      ) : null}
    </tr>
  );
};
