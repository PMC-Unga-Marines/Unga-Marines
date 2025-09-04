import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  ProgressBar,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type MutationData = {
  biomass: number;
  max_biomass: number;
  shell_chambers: number;
  spur_chambers: number;
  veil_chambers: number;
  mutations: MutationEntry[];
  categories: string[];
};

type MutationEntry = {
  name: string;
  desc: string;
  category: string;
  cost: number;
  icon: string;
  available: boolean;
  purchased: boolean;
  chamber_required: number;
  chambers_built: number;
};

const categoryIcons: Record<string, string> = {
  Survival: 'shield-alt',
  Attack: 'fist-raised',
  Utility: 'magic',
};

const categoryColors: Record<string, string> = {
  Survival: 'good',
  Attack: 'average',
  Utility: 'blue',
};

const categoryDescriptions: Record<string, string> = {
  Survival: 'Enhance your defensive capabilities and survivability',
  Attack: 'Improve your offensive power and combat effectiveness',
  Utility: 'Gain new abilities and tactical advantages',
};

export const MutationMenu = (props: any) => {
  const { data } = useBackend<MutationData>();
  const { biomass, max_biomass, categories } = data;
  const [selectedCategory, setSelectedCategory] = useState<string | null>(
    categories.length ? categories[0] : null,
  );

  return (
    <Window theme="xeno" title="Mutations Menu" width={700} height={600}>
      <Window.Content scrollable>
        <Section title="Biomass Status">
          <Flex align="center">
            <Flex.Item grow={1}>
              <ProgressBar
                ranges={{
                  good: [0.75, Infinity],
                  average: [0.25, 0.75],
                  bad: [-Infinity, 0.25],
                }}
                value={biomass / max_biomass}
                color={biomass >= 25 ? 'good' : 'bad'}
              >
                {biomass} / {max_biomass} Biomass
              </ProgressBar>
            </Flex.Item>
            <Flex.Item ml={2}>
              <Box
                className={classes(['mutationmenu32x32', 'biomass_icon'])}
                style={{
                  transform: 'scale(1.5)',
                }}
              />
            </Flex.Item>
          </Flex>
        </Section>

        <Section title="Upgrade Chambers">
          <Flex>
            <Flex.Item grow={1}>
              <Box textAlign="center">
                <Box bold color="good">
                  Shell Chambers
                </Box>
                <Box>{data.shell_chambers} / 3</Box>
                <Box
                  className={classes(['mutationmenu32x32', 'shell_chamber'])}
                />
              </Box>
            </Flex.Item>
            <Flex.Item grow={1}>
              <Box textAlign="center">
                <Box bold color="average">
                  Spur Chambers
                </Box>
                <Box>{data.spur_chambers} / 3</Box>
                <Box
                  className={classes(['mutationmenu32x32', 'spur_chamber'])}
                />
              </Box>
            </Flex.Item>
            <Flex.Item grow={1}>
              <Box textAlign="center">
                <Box bold color="blue">
                  Veil Chambers
                </Box>
                <Box>{data.veil_chambers} / 3</Box>
                <Box
                  className={classes(['mutationmenu32x32', 'veil_chamber'])}
                />
              </Box>
            </Flex.Item>
          </Flex>
        </Section>

        {categories.length > 0 && (
          <Section lineHeight={1.75} textAlign="center">
            <Tabs>
              <Stack wrap="wrap">
                {categories.map((categoryname) => {
                  return (
                    <Stack.Item
                      m={0.5}
                      grow={categoryname.length}
                      basis="content"
                      key={categoryname}
                    >
                      <Tabs.Tab
                        icon={categoryIcons[categoryname]}
                        selected={categoryname === selectedCategory}
                        onClick={() => setSelectedCategory(categoryname)}
                        color={categoryColors[categoryname]}
                      >
                        {categoryname}
                      </Tabs.Tab>
                    </Stack.Item>
                  );
                })}
              </Stack>
            </Tabs>
            <Divider />
          </Section>
        )}

        {selectedCategory && (
          <Section title={`${selectedCategory} Mutations`} mb={2}>
            <Box italic textAlign="center" color="label">
              {categoryDescriptions[selectedCategory]}
            </Box>
          </Section>
        )}
        <Mutations selectedCategory={selectedCategory} />
      </Window.Content>
    </Window>
  );
};

const Mutations = (props: { selectedCategory: string | null }) => {
  const { data } = useBackend<MutationData>();
  const { mutations } = data;
  const { selectedCategory } = props;

  const filteredMutations = mutations.filter(
    (mutation) => mutation.category === selectedCategory,
  );

  return (
    <Section title={`${selectedCategory} Mutations`}>
      {filteredMutations.length === 0 ? (
        <Box color="bad" textAlign="center">
          No mutations available in this category!
        </Box>
      ) : (
        <Stack vertical>
          {filteredMutations.map((mutation) => (
            <Stack.Item key={mutation.name}>
              <MutationEntryComponent mutation={mutation} />
            </Stack.Item>
          ))}
        </Stack>
      )}
    </Section>
  );
};

const MutationEntryComponent = (props: { mutation: MutationEntry }) => {
  const { act } = useBackend<MutationData>();
  const { mutation } = props;
  const {
    name,
    desc,
    cost,
    icon,
    available,
    purchased,
    chamber_required,
    chambers_built,
  } = mutation;

  const canAfford = cost <= 25; // XENO_UPGRADE_COST
  const hasChambers = chambers_built >= chamber_required;
  const canPurchase = available && canAfford && hasChambers && !purchased;

  return (
    <Collapsible
      title={
        <Flex align="center">
          <Flex.Item>
            <Box
              className={classes(['mutationmenu32x32', icon])}
              mr={2}
              style={{
                transform: 'scale(1.2)',
              }}
            />
          </Flex.Item>
          <Flex.Item grow={1}>
            <Box bold>{name}</Box>
          </Flex.Item>
          <Flex.Item>
            <Box color={purchased ? 'good' : 'bad'} bold>
              {purchased ? 'PURCHASED' : `${cost} Biomass`}
            </Box>
          </Flex.Item>
        </Flex>
      }
      buttons={
        <Button
          mr={1}
          disabled={!canPurchase}
          color={canPurchase ? 'good' : 'bad'}
          onClick={() => act('purchase_mutation', { mutation_name: name })}
          tooltip={
            !available
              ? 'Not available'
              : !canAfford
                ? 'Not enough biomass'
                : !hasChambers
                  ? `Requires ${chamber_required} ${mutation.category.toLowerCase()} chambers`
                  : purchased
                    ? 'Already purchased'
                    : 'Purchase this mutation'
          }
        >
          {purchased ? 'Owned' : 'Purchase'}
        </Button>
      }
    >
      <Box p={2}>
        <Box mb={2} italic>
          {desc}
        </Box>
        <Divider />
        <Flex align="center" mt={2}>
          <Flex.Item grow={1}>
            <Box>
              <Box bold color="label">
                Requirements:
              </Box>
              <Box>
                • {chamber_required} {mutation.category} Chambers
              </Box>
              <Box>• {cost} Biomass</Box>
              {purchased && (
                <Box color="good" bold>
                  • Already Owned
                </Box>
              )}
            </Box>
          </Flex.Item>
          <Flex.Item>
            <Box textAlign="center">
              <Box bold color={hasChambers ? 'good' : 'bad'}>
                Chambers: {chambers_built}/{chamber_required}
              </Box>
              <Box
                className={classes([
                  'mutationmenu32x32',
                  `${mutation.category.toLowerCase()}_chamber`,
                ])}
                style={{
                  transform: 'scale(1.5)',
                }}
              />
            </Box>
          </Flex.Item>
        </Flex>
        {purchased && (
          <Box
            mt={2}
            p={1}
            backgroundColor="rgba(0, 255, 0, 0.1)"
            textAlign="center"
          >
            <Box bold color="good">
              ✓ This mutation is already active!
            </Box>
          </Box>
        )}
      </Box>
    </Collapsible>
  );
};
