#!/usr/bin/env coffee
kup = require 'kup'

{alert} = require '../lib'

builder = new kup

alert builder, 'normal message'
alert builder, 'error', 'error'
alert builder, 'success', 'success'

alert builder, 'success with bootstrap v1', 'success', alert.strategy.v1

console.log builder.htmlOut
