import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Button, Flex, Divider, Collapsible, AnimatedNumber, Box, Section, LabeledList, Icon, Input, Table, Stack } from '../components';
import { Window } from '../layouts';
import { map } from 'common/collections';

const category_icon = {
  'Operations': 'parachute-box',
  'Weapons': 'fighter-jet',
  'Explosives': 'bomb',
  'Armor': 'hard-hat',
  'Clothing': 'tshirt',
  'Medical': 'medkit',
  'Engineering': 'tools',
  'Supplies': 'hamburger',
  'Imports': 'boxes',
  'Vehicles': 'road',
  'Factory': 'industry',
  'Pending Order': 'shopping-cart',
};

export const Assembler = (props, context) => {
  const { act, data } = useBackend(context);

  const [selectedMenu, setSelectedMenu] = useLocalState(
    context,
    'selectedMenu',
    null
  );

  const {
    supplypacks,
  } = data;

  const selectedPackCat = supplypacks[selectedMenu]
    ? supplypacks[selectedMenu]
    : null;

  return (
    <Window width={900} height={700}>
      <Flex height="650px" align="stretch">
        <Flex.Item width="280px">
          <Menu />
        </Flex.Item>
        <Flex.Item position="relative" grow={1} height="100%">
          <Window.Content scrollable>
            {!!selectedPackCat && (
              <Category selectedPackCat={selectedPackCat} should_filter />
            )}
          </Window.Content>
        </Flex.Item>
      </Flex>
    </Window>
  );
};

const MenuButton = (props, context) => {
  const { condition, menuname, icon, width } = props;

  const [selectedMenu, setSelectedMenu] = useLocalState(
    context,
    'selectedMenu',
    null
  );

  return (
    <Button
      icon={icon}
      selected={selectedMenu === menuname}
      onClick={() => setSelectedMenu(menuname)}
      disabled={condition}
      width={width}
      content={menuname}
    />
  );
};

const Menu = (props, context) => {
  const { act, data } = useBackend(context);
  const { readOnly } = props;

  const {
    categories,
  } = data;

  return (
    <Section height="100%" p="5px">
      <Divider />
      {categories.map((category) => (
        <Fragment key={category.id}>
          <MenuButton
            key={category.id}
            icon={category_icon[category]}
            menuname={category}
            condition={0}
            width="100%"
          />
          <br />
        </Fragment>
      ))}
    </Section>
  );
};

const Pack = (props, context) => {
  const { act, data } = useBackend(context);
  const { pack } = props;
  const { supplypackscontents } = data;
  const { name, inputs, outputs } = supplypackscontents[pack];
  return !!inputs && inputs.constructor === Object && !!outputs && outputs.constructor === Object ? (
    <Collapsible
      color="gray"
      title={<PackName name={name} pl={0} />}>
      <Table>
        <InputContents input={inputs} />
      </Table>
      <Table>
        <OutputContents output={outputs} />
      </Table>
    </Collapsible>
  ) : (
    <PackName name={name} pl="22px" />
  );
};

const PackName = (props, context) => {
  const { name, pl } = props;

  return (
    <Box inline pl={pl}>
      <Box width="15px" inline />
      <Box inline>{name}</Box>
    </Box>
  );
};

const CategoryButton = (props, context) => {
  const { act, data } = useBackend(context);
  const { icon, disabled, id, mode } = props;

  return (
    <Button
      icon={icon}
      disabled={disabled}
      onClick={() =>
        act('select', {
          id: id,
          mode: mode,
        })
      }
    />
  );
};

const Category = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    supplypackscontents,
    assemblercraft,
  } = data;

  const [selectedMenu, setSelectedMenu] = useLocalState(
    context,
    'selectedMenu',
    null
  );

  const { selectedPackCat, should_filter, level } = props;

  const [filter, setFilter] = useLocalState(context, `pack-name-filter`, null);

  const filterSearch = (entry) =>
    should_filter && filter
      ? supplypackscontents[entry].name
        ?.toLowerCase()
        .includes(filter.toLowerCase())
      : true;

  return (
    <Section
      level={level || 1}
      title={
        <>
          <Icon name={category_icon[selectedMenu]} mr="5px" />
          {selectedMenu}
        </>
      }>
      <Stack vertical>
        {should_filter && (
          <Stack.Item>
            <Flex>
              <Flex.Item width="60px">Search :</Flex.Item>
              <Flex.Item grow={1}>
                <Input fluid onInput={(_e, value) => setFilter(value)} />
              </Flex.Item>
            </Flex>
          </Stack.Item>
        )}
        <Stack.Item>
          <Table>
            {selectedPackCat.filter(filterSearch).map((entry) => {
              return (
                <Table.Row key={entry.id}>
                  <Table.Cell width="30px">
                    <CategoryButton
                      icon="sync"
                      id={entry}
                      disabled={entry === assemblercraft}
                      mode="add"
                    />
                  </Table.Cell>
                  <Table.Cell>
                    <Pack pack={entry} />
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const InputContents = (props, context) => {
  const { input } = props;

  return (
    <>
      <Table.Row>
        <Table.Cell bold>Input</Table.Cell>
        <Table.Cell bold>Quantity</Table.Cell>
      </Table.Row>
      {map((contententry) => (
        <Table.Row>
          <Table.Cell width="70%">{contententry.name}</Table.Cell>
          <Table.Cell>{contententry.count}</Table.Cell>
        </Table.Row>
      ))(input)}
    </>
  );
};

const OutputContents = (props, context) => {
  const { output } = props;

  return (
    <>
      <Table.Row>
        <Table.Cell bold>Output</Table.Cell>
        <Table.Cell bold>Quantity</Table.Cell>
      </Table.Row>
      {map((contententry) => (
        <Table.Row>
          <Table.Cell width="70%">{contententry.name}</Table.Cell>
          <Table.Cell>{contententry.count}</Table.Cell>
        </Table.Row>
      ))(output)}
    </>
  );
};
