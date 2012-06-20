#!/usr/bin/env coffee
drykup = require 'drykup'

Navbar = require '../lib/navbar'

builder = drykup()
navbar = Navbar builder

navbar.navbar ->
    navbar.brand 'Hello World', '/'
    navbar.nav.left ->
        navbar.link 'Foo (Active)', '/foo', true
        navbar.link 'Bar', '/bar'

    navbar.nav.right ->
        navbar.dropdown 'Admin', ->
            navbar.link 'X', '/admin/x'
            navbar.link 'Y', '/admin/y'
        navbar.divider()
        navbar.link 'Logout', '/logout'

console.log builder.htmlOut
