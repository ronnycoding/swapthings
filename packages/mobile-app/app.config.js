export default ({ config }) => {
  return {
    ...config,
    extra: {
      ...(process.env.STORY_BOOK === 'true' ? { storybook: true } : {}),
    },
  }
}
