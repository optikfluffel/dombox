#!/usr/bin/env coffee
drykup = require 'drykup'

{alert} = require '../lib'

builder = drykup()

alert builder, 'normal message'
alert builder, 'error', 'error'
alert builder, 'success', 'success'

alert builder, 'success with bootstrap v1', 'success', alert.strategy.v1

console.log builder.htmlOut
