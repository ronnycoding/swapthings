import Constants from 'expo-constants'
import registerRootComponent from 'expo/build/launch/registerRootComponent'
import { activateKeepAwake } from 'expo-keep-awake'

import App from './App'

if (__DEV__) {
  activateKeepAwake()
}

if (Constants.manifest.extra.storybook) {
  const StoryBook = require('./storybook').default
  registerRootComponent(StoryBook)
} else {
  registerRootComponent(App)
}
