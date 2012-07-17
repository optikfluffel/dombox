#!/usr/bin/env coffee
kup = require 'kup'
_ = require 'underscore'

Form = require '../lib/form'

builder = new kup
_.bindAll builder

form = Form builder

builder.form ->
    form.hidden 'id', 42
    form.text 'name', 'Clark Kent', 'Your Name'
    form.number 'age', 33, 'Your Age'
    professions =
        0: 'Superhero'
        1: 'Villain'
    form.select 'profession', professions, 0
    form.textarea 'about', '', 'Something about you', {rows: 10, cols: 10}
    form.submitButton 'Update your profile'


console.log builder.htmlOut
