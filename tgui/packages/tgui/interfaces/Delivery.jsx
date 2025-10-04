// // delivery.jsx
import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Delivery = () => {
  const { act, data } = useBackend();
  const {
    supplypacks,
    supplypackscontents,
    personalpoints,
    shopping_list,
    shopping_list_cost,
    shopping_list_items,
  } = data;

  return (
    <Window width={800} height={600} theme={"pigs_wings"}>
      <Window.Content scrollable>
        <Section title="Personal Delivery System">
          <Flex>
            <Flex.Item grow={1}>
              <Box fontSize="1.2em">
                Personal Points: <AnimatedNumber value={personalpoints} />
              </Box>
            </Flex.Item>
            <Flex.Item>
              <Button
                icon="shopping-cart"
                onClick={() => act('buycart')}
                disabled={
                  !shopping_list_items || shopping_list_cost > personalpoints
                }
                tooltip={
                  shopping_list_cost > personalpoints
                    ? 'Not enough points'
                    : 'Place order'
                }
              >
                Order Now ({shopping_list_cost} points)
              </Button>
            </Flex.Item>
            <Flex.Item>
              <Button
                icon="trash"
                onClick={() => act('clearcart')}
                disabled={!shopping_list_items}
              >
                Clear Cart
              </Button>
            </Flex.Item>
          </Flex>
        </Section>

        <Section title="Available Items for Your Profession">
          <Table>
            {supplypacks.map((packId) => {
              const pack = supplypackscontents[packId];
              const canAfford = pack.cost <= personalpoints;

              return (
                <Table.Row
                  key={packId}
                  className={!canAfford ? 'Row--disabled' : ''}
                >
                  <Table.Cell width="60%">
                    <Box fontWeight="bold">{pack.name}</Box>
                    <Box>{pack.desc}</Box>
                    {pack.contains && (
                      <Box italic color="gray">
                        Contains:{' '}
                        {Object.values(pack.contains)
                          .map((item) => item.name)
                          .join(', ')}
                      </Box>
                    )}
                  </Table.Cell>
                  <Table.Cell width="20%">{pack.cost} points</Table.Cell>
                  <Table.Cell width="20%">
                    <Flex>
                      <Flex.Item>
                        <Button
                          icon="minus"
                          onClick={() =>
                            act('cart', {
                              id: packId,
                              mode: 'removeone',
                            })
                          }
                          disabled={!shopping_list[packId]}
                        />
                      </Flex.Item>
                      <Flex.Item width="30px" textAlign="center">
                        {shopping_list[packId]?.count || 0}
                      </Flex.Item>
                      <Flex.Item>
                        <Button
                          icon="plus"
                          onClick={() =>
                            act('cart', {
                              id: packId,
                              mode: 'addone',
                            })
                          }
                          disabled={!canAfford}
                        />
                      </Flex.Item>
                    </Flex>
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Section>

        {shopping_list_items > 0 && (
          <Section title="Your Delivery Cart">
            <Table>
              {Object.keys(shopping_list).map((packId) => {
                const pack = supplypackscontents[packId];
                const count = shopping_list[packId].count;
                return (
                  <Table.Row key={packId}>
                    <Table.Cell>{pack.name}</Table.Cell>
                    <Table.Cell>{count}x</Table.Cell>
                    <Table.Cell>{pack.cost * count} points</Table.Cell>
                  </Table.Row>
                );
              })}
            </Table>
            <Box
              textAlign="center"
              fontSize="1.2em"
              color={shopping_list_cost > personalpoints ? 'bad' : 'good'}
              mt={1}
            >
              Total: {shopping_list_cost} points
              {shopping_list_cost > personalpoints && ' (Not enough points)'}
            </Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
