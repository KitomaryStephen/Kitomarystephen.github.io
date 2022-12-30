import { Container, Grid, Text } from '@mantine/core';
import { m } from 'framer-motion';

export default function LandingWhyChooseUs() {
  return (
    <Container className='' size='xl'>
      <Grid className='mt-28 mb-[150px] overflow-hidden align-middle'>
        <Grid.Col md={6} className='h-[600px] flex flex-col justify-center'>
          <Text className='mb-8 xs:text-4xl sm:text-5xl font-extrabold leading-[1.25] text-left'>
            What makes KBLE <span className='text-brand-yellow'>different?</span> <br />{' '}
          </Text>

          <Text className='mb-8 max-w-lg text-left'>
          At KBLE, we take a holistic approach to trading that goes beyond just executing trades. 
            <br></br>
            <Text>Our team of experienced professionals works on a customized trading plan that takes into account their individual risk tolerance, financial goals, and market analysis</Text>
          </Text>

          <Text className='mb-1 max-w-lg text-left text-2xl font-bold'>Growth</Text>
          <Text className='mb-8 max-w-lg text-left'>We believe in taking a long-term view and focusing on sustainable, consistent growth rather than trying to make quick profits. To achieve this, we use a variety of technical and fundamental analysis techniques to make informed trading decisions, and we also place a strong emphasis on risk management to protect our Invested capital.</Text>

          <Text className='mb-1 max-w-lg text-left text-2xl font-bold'>Sharing</Text>
          <Text className='mb-8 max-w-lg text-left'>
            As an inclusive community, we believe in the power of collaboration and teamwork to help us succeed in the market. By sharing our experiences and ideas, we can all learn from each other and make more informed trading decisions.
          </Text>

         
        </Grid.Col>

        <Grid.Col md={6} className='h-[580px]'>
          <m.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 0.75 }}>
            <div className='h-36 flex xs:justify-center sm:justify-end'>
              <img src='/svg/hero-iphone.svg' className='h-[580px]' />
            </div>
          </m.div>
        </Grid.Col>
      </Grid>
    </Container>
  );
}
