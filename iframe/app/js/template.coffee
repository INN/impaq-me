window.app.Template = class Template
  constructor: (templateName) ->
    @template = JST["app/templates/#{templateName}.us"]
    @alternateTemplate = JST["app/templates/#{templateName}-campaign_over.us"]

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
