import '../styles/globals.css'
// import { AmplifyAuthenticator } from '@aws-amplify/ui-react'
import type { AppProps } from 'next/app'
import { Amplify } from 'aws-amplify'
const AmplifyConfig = process.env.aws || {}

Amplify.configure({ ...AmplifyConfig, ssr: true })

function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}
export default MyApp
