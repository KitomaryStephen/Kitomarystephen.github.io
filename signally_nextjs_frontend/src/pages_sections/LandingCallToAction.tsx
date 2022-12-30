import { Box, Container, Text } from '@mantine/core';
import { m } from 'framer-motion';

export default function LandingCallToAction() {
  return (
    <Container className='text-center xs:mt-10 sm:mt-36' size='xl'>
      <Box className='flex xs:flex-col-reverse sm:flex-row'>
        <Box className='xs:w-full sm:w-1/2'>
          <m.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 0.75 }}>
            <div className='h-[600px] flex xs:justify-center sm:justify-start'>
              <img src='/svg/call-to-action-iphone.svg' className='h-[600px]' />
            </div>
          </m.div>
        </Box>

        <Box className='xs:w-full sm:w-1/2 h-[600px] flex flex-col justify-center '>
          <Text className='mb-2 max-w-lg text-left text-5xl font-bold'>The team you can trust!</Text>
          <Text className='mb-8 max-w-lg text-left'>KBLE is a team of experienced professionals who are dedicated to maximizing profits and minimizing risks in the highly volatile foreign exchange market. We use a combination of technical and fundamental analysis to identify trading opportunities and make informed decisions. Our team is constantly monitoring market conditions and staying up-to-date on global economic news to ensure that we are well-positioned to capitalize on market movements. We are committed to transparency and ethical trading practices. Our ultimate goal as a team is to achieve a long-term financial success through strategic forex trading. </Text>

          <Text className='mb-1 max-w-lg text-left text-2xl font-bold'>Join us</Text>
          <Text className='mb-8 max-w-lg text-left'>To join us, fill out the application form and sign up for the Interview!</Text>

          <Text className='mb-1 max-w-lg text-left text-2xl font-bold'>Our tools</Text>
          <Text className='mb-8 max-w-lg text-left'>
            Web platform , Android application and IOS application to keep track of your trades, document your journey and link with other KBLE members.
          </Text>

          <Text className='mb-1 max-w-lg text-left text-2xl font-bold'>What we offer</Text>
          <Text className='mb-8 max-w-lg text-left'>
            KBLE is a family! With out cutting edge app and web platform, you'll get access to our virtual trading floor where all potential market opportunities are discussed and carefully evaluated.
          </Text>
        </Box>
      </Box>
    </Container>
  );
}
