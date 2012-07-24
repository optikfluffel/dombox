assert = require 'assert'
moment = require 'moment'
_ = require 'underscore'

time =
    yearmonthday: '%Y-%m-%d'
    hourMinute: '%H:%i'
    datetime: 'Y-%m-%d %H:%i'

initDate = (id, format) ->
    fun = -> $('#ID').AnyTime_picker format: 'FORMAT'
    fun.toString().replace('ID', id).replace('FORMAT', format)

module.exports = (builder) -> form =

    controlGroup: (key, text, elem, post = ->) ->
        {div, label, div, input} = builder
        div class: 'control-group', ->
            label class: 'control-label', for: key, text
            div class: 'controls', ->
                elem()
                post()

    input: (key, value, text, type, post = ->) ->
        {input} = builder
        inp = -> input class: 'xlarge', id: key, type: type, name: key, value: value
        form.controlGroup key, text, inp, post

    readonly: (key, value, text, type, post = ->) ->
        {input} = builder
        inp = -> input class: 'input-xlarge uneditable-input', id: key, type: type, name: key, value: value, readonly: ''
        form.controlGroup key, text, inp, post

    hidden: (key, value) ->
        builder.input name: key, value: value, type: 'hidden'

    textarea: (key, value, text = '', attr = {}) ->
        {textarea} = builder
        a = _.extend {class: 'input-xlarge', name: key, id: key}, attr
        inp = -> textarea a, value
        form.controlGroup key, text, inp

    checkbox: (key, value, checked) ->
        {input} = builder
        defaults =
            type: 'checkbox'
            name: key
            id: key
            value: value
        defaults.checked = 'checked' if checked
        input defaults

    inlineCheckbox: (key, value, checked, description = '') ->
        {input, p, label} = builder
        label class: 'checkbox inline', =>
            form.checkbox key, value, checked
            p description


    fieldCheckbox: (key, value, text, checked = false) ->
        form.controlGroup key, text, => form.checkbox key, value, checked

    # values is a key-value collection
    select: (id, values, selected = '') ->
        selected = selected.toString()
        {select, option} = builder
        select name: id, id: id, ->
            _.each values, (value, key) ->
                config =
                    value: key
                config.selected = 'selected' if selected is key
                option config, value

    standardSelect: (id, values, selected, text) ->
        elem = => form.select id, values, selected
        form.controlGroup id, text, elem

    multipleSelect: (id, values, selected = []) ->
        assert _.isObject(values), "values is no array #{values}"
        assert _.isArray(selected), "selected is no array #{selected}"
        stringKeys = _.map selected, (e) -> e.toString()
        {p} = builder
        isSelected = (key) -> _.include stringKeys, key
        _.each values, (v, key) => form.inlineCheckbox "#{id}[]", key, isSelected(key), v


    fieldSelectMultiple: (id, values, selected, text) ->
        elem = => form.multipleSelect id, values, selected
        form.controlGroup id, text, elem

    fieldSelect: (id, values, selected, text) ->
        elem = => form.select id, values, selected
        form.controlGroup id, text, elem

    text: (key, value, text, post) -> form.input key, value, text, 'text', post

    password: (key, value, text, post) -> form.input key, value, text, 'password', post

    button: (text, type, clazz = '', id) ->
        {button} = builder
        attr = type: type, class: "btn #{clazz}"
        attr.id = id if id?
        button attr, text

    submitButton: (text) ->
        form.button text, 'submit'

    linkButton: (text, href, type = '') ->
        type = " btn-#{type}" unless type is ''
        {a} = builder
        a href: href, class: "btn#{type}", text

    linkConfirmButton: (text, href, alert='Are you sure?', type='') ->
        type = " btn-#{type}" unless type is ''
        {a} = builder
        a href: href, class: "btn#{type}", onclick: "return confirm('#{alert}')", text

    dayField: (key, value, text) ->
        value ?= new Date()
        assert value instanceof Date, 'value is no Date Object', value
        dateString = moment(value).format 'YYYY-MM-DD'
        form.text key, dateString, text
        builder.script -> builder.unsafe initDate key, time.yearmonthday

    dayFieldOptional: (key, value, text) =>
        dateString = if value instanceof Date then moment(value).format 'YYYY-MM-DD' else value
        post = => form.button 'clear', 'button', '', "#{key}Clear"
        form.text key, dateString, text, post

    dateTimeField: (key, value, text) ->
        value ?= new Date()
        assert value instanceof Date, 'value is no Date Object', value
        form.text key, (moment value).format('YYYY-MM-DD HH:mm'), text
        builder.script -> builder.unsafe initDate key, time.datetime

    script: (f) ->
        scriptTag = builder.script
        scriptTag "$(#{f.toString()})"

    number: (id, value, text) -> form.input id, value, text, 'number'
