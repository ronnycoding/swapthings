import type { AppProps } from 'next/app'
import { Amplify } from 'aws-amplify'
import '../styles/globals.css'

const AmplifyConfig = process.env.aws || {}

Amplify.configure({ ...AmplifyConfig, ssr: true })

function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}
export default MyApp
