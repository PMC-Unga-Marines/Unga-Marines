import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Divider,
  LabeledList,
  Modal,
  ProgressBar,
  Section,
  Stack,
  Tabs,
} from '../components';
import { Window } from '../layouts';

type VendingData = {
  vendor_name: string;
  displayed_records: VendingRecord[];
  tabs: string[];
  stock: number;
  currently_vending: VendingRecord | null;
  ui_theme: string;
};

type VendingRecord = {
  product_name: string;
  product_color: string;
  prod_desc: string;
  ref: string;
  tab: string;
  products: any[];
};

export const Vending = () => {
  const { act, data } = useBackend<VendingData>();

  const { vendor_name, currently_vending, tabs, ui_theme } = data;

  const [showDesc, setShowDesc] = useLocalState('showDesc', null);

  const [showEmpty, setShowEmpty] = useLocalState('showEmpty', false);

  const [selectedTab, setSelectedTab] = useLocalState(
    'selectedTab',
    tabs.length ? tabs[0] : null,
  );

  return (
    <Window
      title={vendor_name || 'Vending Machine'}
      width={500}
      height={600}
      theme={ui_theme}
    >
      {showDesc ? (
        <Modal width="400px">
          <Box>{showDesc}</Box>
          <Button content="Dismiss" onClick={() => setShowDesc(null)} />
        </Modal>
      ) : null}
      <Window.Content scrollable>
        <Section
          title="Select an item"
          buttons={
            <>
              <Button
                icon="power-off"
                selected={showEmpty}
                onClick={() => setShowEmpty(!showEmpty)}
              >
                Show sold-out items
              </Button>
              <Button
                icon="truck-loading"
                color="good"
                tooltip="Stock all loose items in the outlet back into the vending machine"
                onClick={() => act('vacuum')}
              />
            </>
          }
        >
          {tabs.length > 0 && (
            <Section lineHeight={1.75} textAlign="center">
              <Tabs>
                <Stack wrap="wrap">
                  {tabs.map((tabname) => {
                    return (
                      <Stack.Item
                        m={0.5}
                        grow={tabname.length}
                        basis={'content'}
                        key={tabname}
                      >
                        <Tabs.Tab
                          selected={tabname === selectedTab}
                          onClick={() => setSelectedTab(tabname)}
                        >
                          {tabname}
                        </Tabs.Tab>
                      </Stack.Item>
                    );
                  })}
                </Stack>
              </Tabs>
              <Divider />
            </Section>
          )}
          <Products />
        </Section>
      </Window.Content>
    </Window>
  );
};

type VendingProductEntryProps = {
  stock: number;
  key: string;
  product_color: string;
  product_name: string;
  prod_desc: string;
  prod_ref: string;
  products: any[];
};

const ProductEntry = (props: VendingProductEntryProps) => {
  const { act, data } = useBackend<VendingData>();

  const { currently_vending } = data;

  const {
    stock,
    key,
    product_color,
    product_name,
    prod_desc,
    prod_ref,
    products,
  } = props;

  const [showDesc, setShowDesc] = useLocalState<String | null>(
    'showDesc',
    null,
  );

  return (
    <LabeledList.Item
      labelColor="white"
      buttons={
        <>
          {stock >= 0 && (
            <Box inline>
              <ProgressBar
                value={stock}
                maxValue={stock}
                ranges={{
                  good: [10, Infinity],
                  average: [5, 10],
                  bad: [0, 5],
                }}
              >
                {stock} left
              </ProgressBar>
            </Box>
          )}
          <Box inline width="4px" />
          {products.map((product) => (
            <Button
              key={product.id}
              selected={
                currently_vending &&
                currently_vending.product_name === product_name
              }
              onClick={() => act('vend', { vend: [prod_ref, product[0]] })}
              disabled={!stock}
            >
              <Box color={product[2]} bold={1}>
                {
                  product[1] // Button name
                }
              </Box>
            </Button>
          ))}
        </>
      }
      label={product_name}
    >
      {!!prod_desc && <Button onClick={() => setShowDesc(prod_desc)}>?</Button>}
    </LabeledList.Item>
  );
};

const Products = () => {
  const { data } = useBackend<VendingData>();

  const { displayed_records, stock, tabs } = data;

  const [selectedTab] = useLocalState(
    'selectedTab',
    tabs.length ? tabs[0] : null,
  );

  const [showEmpty] = useLocalState('showEmpty', false);

  return (
    <Section>
      <LabeledList>
        {displayed_records.length === 0 ? (
          <Box color="red">No product loaded!</Box>
        ) : (
          displayed_records
            .filter((record) => !record.tab || record.tab === selectedTab)
            .map((display_record) => {
              return (
                (showEmpty || !!stock[display_record.product_name]) && (
                  <ProductEntry
                    stock={stock[display_record.product_name]}
                    key={display_record.product_name}
                    product_color={display_record.product_color}
                    product_name={display_record.product_name}
                    prod_desc={display_record.prod_desc}
                    prod_ref={display_record.ref}
                    products={display_record.products}
                  />
                )
              );
            })
        )}
      </LabeledList>
    </Section>
  );
};
