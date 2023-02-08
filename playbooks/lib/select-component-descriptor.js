'use strict'

const ospath = require('path')

module.exports.register = function ({ config: { defaultProfile } }) {
  this.once('contentAggregated', ({ playbook, contentAggregate }) => {
    const yaml = this.require('js-yaml')
    let profile = playbook.site.keys.profile
    if (!profile) {
      const playbookFileBasename = ospath.basename(playbook.file, '.yml')
      profile = playbookFileBasename.endsWith('-playbook') ? defaultProfile : playbookFileBasename.split('-')[0]
    }
    const antoraYmlPath = `antora-${profile}.yml`
    const componentVersionBucket = contentAggregate.find(({ name }) => name === 'docs')
    const antoraYmls = componentVersionBucket.files.filter(({ path: path_ }) => path_ === antoraYmlPath)
    for (const antoraYml of antoraYmls) {
      const origin = componentVersionBucket.origins.find((candidate) => candidate === antoraYml.src.origin)
      origin.descriptor = yaml.load(antoraYml.contents.toString())
      if (!origin.descriptor.version) origin.descriptor.version == ''
      Object.assign(componentVersionBucket, origin.descriptor)
    }
  })
}
