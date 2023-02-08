'use strict'

const fs = require('fs')
const { promises: fsp } = fs
const readline = require('readline')

module.exports.register = function () {
  this.once('playbookBuilt', async ({ playbook }) => {
    const yaml = this.require('js-yaml')
    const expandPath = this.require('@antora/expand-path-helper')
    let profile = playbook.site.keys.profile
    if (!profile) profile = ospath.basename(playbook.file.split('-').pop(), '.yml')
    const includeLine = await readFirstLine(playbook.file)
    if (!(includeLine.startsWith('#include: '))) return
    const includePath = expandPath(includeLine.substr(10), { dot: playbook.dir })
    const schema = yaml.CORE_SCHEMA.extend({ implicit: [yaml.types.merge] })
    const includePlaybook = await fsp.readFile(includePath, 'utf8')
      .then((contents) => yaml.load(contents, { schema }))
    // FIXME adding extensions here is too late
    //if (includePlaybook.antora?.extensions) playbook.antora.extensions = includePlaybook.antora.extensions
    playbook.site.title ??= includePlaybook.site?.title
    playbook.site.url ??= includePlaybook.site?.url
    const includePlaybookContent = camelCaseKeys(includePlaybook.content || {})
    if ('editUrl' in includePlaybookContent) playbook.content.editUrl = includePlaybookContent.editUrl
    if (!playbook.content.sources.length) playbook.content.sources = includePlaybookContent.sources || []
    const adocAttributes = includePlaybook.asciidoc?.attributes
    if (adocAttributes) playbook.asciidoc.attributes = Object.assign(adocAttributes, playbook.asciidoc.attributes)
    playbook.asciidoc.extensions.splice(0, 0, ...(includePlaybook.asciidoc?.extensions || []))
    Object.assign(playbook.ui, camelCaseKeys(includePlaybook.ui || {}))
    playbook.output.dir ??= includePlaybook.output?.dir
    this.updateVariables({ playbook })
  })
}

function camelCaseKeys (o, p = '') {
  if (Array.isArray(o)) return o.map((it) => camelCaseKeys(it, p))
  if (o == null || o.constructor !== Object) return o
  const pathPrefix = p && p + '.'
  const accum = {}
  for (const [k, v] of Object.entries(o)) {
    const camelKey = k.toLowerCase().replace(/[_-]([a-z0-9])/g, (_, l, idx) => (idx ? l.toUpperCase() : l))
    accum[camelKey] = camelCaseKeys(v, pathPrefix + camelKey)
  }
  return accum
}

async function readFirstLine (path) {
  let is
  try {
    for await (const l of readline.createInterface((is = fs.createReadStream(path)))) return l
    return ''
  }
  finally {
    if (is) is.destroy()
  }
}
