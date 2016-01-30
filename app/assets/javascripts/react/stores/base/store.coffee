Dispatcher = require "react/dispatcher/dispatcher"
EventEmitter = require('events').EventEmitter
assign = require "object-assign"

store = {}

set_all = (model, list)->
  store[model] = list

all = (model)->
  store[model]

find = (model, id)->
  list       = store[model]
  exist_item = list.filter (x)-> x.id == item.id
  exist_item[0]

create = (model, item)->
  list       = store[model]
  exist_item = list.filter (x)-> x.id == item.id
  if exist_item.length == 0
    store[model].push item

update = (model, item)->
  list       = store[model]
  for _item, index in list
    if _item.id == item.id
      list[id] = assign {}, list[id], item

destroy = (model, item)->
  list = store[model]
  list = list.filter (x)-> x.id != item.id
  store[model] = list


Store = assign {}, EventEmitter.prototype,
  all: (model)->
    all model

  find: (model, id)->
    find model, id

  emit_change: ->
    @emit "change"

  add_change_listener: (callback)->
    @on "change", callback

  remove_change_listener: (callback)->
    @removeListener "change", callback

Dispatcher.register (action)->
  arr = action.actionType.match(/(.*)\/([^\/]*)/)
  model       = arr[1]
  action_type = arr[2]
  switch action_type
    when "set_all"
      set_all(model, action.list)
      Store.emit_change()
    when "create"
      create(model, action.item)
      Store.emit_change()
    when "update"
      update(model, action.item)
      Store.emit_change()
    when "destroy"
      destroy(model, action.item)
      Store.emit_change()

module.exports = Store
