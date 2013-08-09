window.app.Template = class Template
  constructor: (templateName) ->
    @template = JST[templateName]
    @alternateTemplate = JST["#{templateName}-campaign_over"]

  fill: (data) ->
    @find()(data)

  find: ->
    if @isCampaignActive() or not @hasAlternateTemplate()
      @template
    else
      @alternateTemplate

  isCampaignActive: ->
    window.impaqme.percent < 100

  hasAlternateTemplate: ->
    @alternateTemplate?
