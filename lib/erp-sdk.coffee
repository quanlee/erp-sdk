ErpSdkView = require './erp-sdk-view'
{CompositeDisposable} = require 'atom'

module.exports = ErpSdk =
  erpSdkView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @erpSdkView = new ErpSdkView(state.erpSdkViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @erpSdkView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'erp-sdk:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @erpSdkView.destroy()

  serialize: ->
    erpSdkViewState: @erpSdkView.serialize()

  toggle: ->
    console.log 'ErpSdk was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
