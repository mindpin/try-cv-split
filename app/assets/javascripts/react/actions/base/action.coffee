Dispatcher = require "react/dispatcher/dispatcher"

Actions =
  set_all: (model, list)->
    Dispatcher.dispatch
      actionType: "#{model}/set_all"
      list: list

  create: (model, item)->
    Dispatcher.dispatch
      actionType: "#{model}/create"
      item: item

  update: (model, item)->
    Dispatcher.dispatch
      actionType: "#{model}/update"
      item: item

  destroy: (model, item)->
    Dispatcher.dispatch
      actionType: "#{model}/destroy"
      item: item

module.exports = Actions
