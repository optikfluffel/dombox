assert = require 'assert'
moment = require 'moment'
_ = require 'underscore'

time =
    yearmonthday: '%Y-%m-%d'
    hourMinute: '%H:%i'
    datetime: '%Y-%m-%d %H:%i'

initDate = (id, format) ->
    fun = -> $('#ID').AnyTime_picker format: 'FORMAT'
    fun.toString().replace('ID', id).replace('FORMAT', format)

module.exports = (builder) -> form =

    controlGroup: (key, text, elem, post = ->) ->
        builder.div class: 'control-group', ->
            builder.label class: 'control-label', for: key, text
            builder.div class: 'controls', ->
                elem()
                post()

    input: (key, value, text, type, post = ->) ->
        inp = -> builder.input class: 'xlarge', id: key, type: type, name: key, value: value
        form.controlGroup key, text, inp, post

    readonly: (key, value, text, type, post = ->) ->
        inp = -> builder.input class: 'builder-xlarge uneditable-input', id: key, type: type, name: key, value: value, readonly: ''
        form.controlGroup key, text, inp, post

    hidden: (key, value) ->
        builder.input name: key, id: key, value: value, type: 'hidden'

    textarea: (key, value, text = '', attr = {}) ->
        a = _.extend {class: 'builder-xlarge', name: key, id: key}, attr
        inp = -> builder.textarea a, value
        form.controlGroup key, text, inp

    checkbox: (key, value, checked) ->
        defaults =
            type: 'checkbox'
            name: key
            id: key
            value: value
        defaults.checked = 'checked' if checked
        builder.input defaults

    inlineCheckbox: (key, value, checked, description = '') ->
        builder.label class: 'checkbox inline', ->
            form.checkbox key, value, checked
            description() if _.isFunction description
            builder.p description unless _.isFunction description

    fieldCheckbox: (key, value, text, checked = false) ->
        form.controlGroup key, text, -> form.checkbox key, value, checked

    fieldInlineCheckbox: (key, value, text, checked = false) ->
        form.controlGroup key, '', -> form.inlineCheckbox key, value, checked, text

    # values is a key-value collection
    select: (id, values, selected = '') ->
        selected = selected.toString()
        builder.select name: id, id: id, ->
            _.each values, (value, key) ->
                config =
                    value: key
                config.selected = 'selected' if selected is key
                builder.option config, value

    standardSelect: (id, values, selected, text) ->
        elem = => form.select id, values, selected
        form.controlGroup id, text, elem

    multipleSelect: (id, values, selected = []) ->
        assert _.isObject(values), "values is no array #{values}"
        assert _.isArray(selected), "selected is no array #{selected}"
        stringKeys = _.map selected, (e) -> e.toString()
        isSelected = (key) -> _.include stringKeys, key
        _.each values, (v, key) => form.inlineCheckbox "#{id}[]", key, isSelected(key), v


    fieldSelectMultiple: (id, values, selected, text) ->
        elem = => form.multipleSelect id, values, selected
        form.controlGroup id, text, elem

    fieldSelect: (id, values, selected, text) ->
        elem = => form.select id, values, selected
        form.controlGroup id, text, elem

    text: (key, value, text, post) ->
        form.input key, value, text, 'text', post

    password: (key, value, text, post) ->
        form.input key, value, text, 'password', post

    button: (text, type, clazz = '', id) ->
        attr = type: type, class: "btn #{clazz}"
        attr.id = id if id?
        builder.button attr, text

    submitButton: (text) ->
        form.button text, 'submit'

    linkButton: (text, href, type = '') ->
        type = " btn-#{type}" unless type is ''
        builder.a href: href, class: "btn#{type}", text

    linkConfirmButton: (text, href, alert='Are you sure?', type='') ->
        type = " btn-#{type}" unless type is ''
        builder.a href: href, class: "btn#{type}", onclick: "return confirm('#{alert}')", text

    dayField: (key, value, text) ->
        value ?= new Date()
        assert value instanceof Date, 'value is no Date Object', value
        dateString = moment(value).format 'YYYY-MM-DD'
        form.text key, dateString, text
        form.script initDate key, time.yearmonthday

    dayFieldOptional: (key, value, text) =>
        dateString = if value instanceof Date then moment(value).format 'YYYY-MM-DD' else value
        post = => form.button 'clear', 'button', '', "#{key}Clear"
        form.text key, dateString, text, post

    dateTimeField: (key, value, text) ->
        value ?= new Date()
        assert value instanceof Date, 'value is no Date Object', value
        form.text key, (moment value).format('YYYY-MM-DD HH:mm'), text
        form.script initDate key, time.datetime

    timeField: (key, value, text) ->
        t = moment value, 'HH:mm'
        form.text key, t.format('HH:mm'), text
        form.script initDate key, time.hourMinute

    script: (f) ->
        builder.script -> builder.unsafe "$(#{f.toString()});"

    number: (id, value, text) ->
        form.input id, value, text, 'number'
