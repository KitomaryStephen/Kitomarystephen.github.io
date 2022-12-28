import { Box, Container, Input, Pagination, Text } from '@mantine/core';
import React, { ReactElement, useEffect, useState } from 'react';
import Page from '../components/others/Page';
import Layout from '../layouts';
import { Signal } from '../models/model.signal';
import { useAuthStore } from '../models_store/auth_store';
import { useFirestoreStore } from '../models_store/firestore_store';
import { fDateTimeSuffix } from '../utils/format_time';
import { numToPrecision } from '../utils/number_format';
import { useBreakpoint } from '../utils/use_breakpoint';

export default function SignalsIndexPage() {
  const [searchText, setSearchText] = useState<string | null>(null);
  const [itemsPerPage, setItemPerPage] = useState<number>(8);
  const [activePage, setActivePage] = useState(1);
  const signals = useFirestoreStore((state) => state.signals);
  const [filteredSignals, setFilteredSignals] = useState<Signal[]>([]);
  const { isAuthenticated, isInitialized } = useAuthStore((state) => state);

  useEffect(() => {
    const start = (activePage - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    setFilteredSignals(signals.slice(start, end));
  }, [activePage, itemsPerPage, signals]);

  useEffect(() => {
    if (signals && searchText) {
      let _signals = signals;

      _signals = signals.filter((signal) => {
        return signal.symbol.toLowerCase().includes(searchText.toLowerCase());
      });

      setFilteredSignals(_signals);
      setFilteredSignals(_signals.slice(0, itemsPerPage));
      setActivePage(1);
    }
  }, [searchText]);

  const bp = useBreakpoint();
  useEffect(() => {
    if (bp == 'xs') setItemPerPage(4);
    if (bp != 'xs') setItemPerPage(8);
  }, [bp]);

  const itemHeaderStyle = `dark:text-dark-900 text-[13px] xs:mb-2 sm:mb-2 xs:mr-3 sm:mr-0`;
  const itemBodyStyle = `font-bold text-sm`;

  if (!isAuthenticated) return null;

  return (
    <Page title='Signals'>
      <Container size='xl' className=''>
        <Box className='flex text-center justify-between items-center mt-10 mb-10'>
          <Text className='text-xl font-semibold leading-10'>Signals</Text>
        </Box>

        <Input
          onChange={(e: { currentTarget: { value: React.SetStateAction<string | null> } }) => {
            setSearchText(e.currentTarget.value);
          }}
          className='xs:w-full sm:w-1/3'
          placeholder='Search signals...'
        />

        {filteredSignals.map((signal) => {
          return (
            <Box key={signal.id} className='border dark:border-dark-500 py-6 px-4 my-3 xs:mx-0 sm:mx-0 rounded-md'>
              <Box className='flex justify-between flex-wrap'>
                <div className='xs:w-[50.0%]  sm:w-[16%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Date</Text>
                  <Text className={`${itemBodyStyle}`}>{fDateTimeSuffix(signal.signalDatetime)}</Text>
                </div>

                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Active</Text>
                  <Text className='font-bold'>{signal.isActive ? 'Yes' : 'No'}</Text>
                </div>
                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Free</Text>
                  <Text className='font-bold'>{signal.isFree ? 'Yes' : 'No'}</Text>
                </div>
                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Type</Text>
                  <Text className='font-bold'>
                    <GetSignal signal={signal.type}></GetSignal>
                  </Text>
                </div>

                <div className='xs:w-[50.0%]  sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Symbol</Text>
                  <Text className={`${itemBodyStyle}`}>{signal.symbol}</Text>
                </div>

                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Entry price</Text>
                  <Text className={`${itemBodyStyle}`}>{numToPrecision(signal.entry, 8)}</Text>
                </div>

                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Take profit1</Text>
                  <Text className={`${itemBodyStyle}`}>{numToPrecision(signal.takeProfit1, 8)}</Text>
                </div>
                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Take profit2</Text>
                  <Text className={`${itemBodyStyle}`}>{numToPrecision(signal.takeProfit2, 8)}</Text>
                </div>
                <div className='xs:w-[50.0%] sm:w-[8%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Stop loss</Text>
                  <Text className={`${itemBodyStyle}`}>{numToPrecision(signal.stopLoss, 8)}</Text>
                </div>
                <div className='xs:w-[50.0%] sm:w-[12%] xs:flex sm:flex sm:flex-col'>
                  <Text className={`${itemHeaderStyle}`}>Comment</Text>
                  <Text className={`${itemBodyStyle}`}>{signal.comment}</Text>
                </div>
              </Box>
            </Box>
          );
        })}

        <Pagination
          className='sm:mx-2 my-4  flex justify-end'
          styles={(theme) => ({
            item: {
              '&[data-active]': {
                backgroundColor: '#FCCF2F',
                color: '#000'
              }
            }
          })}
          page={activePage}
          onChange={setActivePage}
          total={Math.ceil(signals.length / itemsPerPage)}
        />
      </Container>
    </Page>
  );
}

SignalsIndexPage.getLayout = function getLayout(page: ReactElement) {
  return <Layout variant='landing'>{page}</Layout>;
};

/* ----------------------------- NOTE FUNCTIONS ----------------------------- */

function GetSignal({ signal }: { signal: string }) {
  if (signal === 'Bull') {
    return <Text className='italic text-md text-brand font-extrabold'>Bull</Text>;
  }

  return <Text className='italic text-md text-warning font-bold   rounded-full'>Bear</Text>;
}
