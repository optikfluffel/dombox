module.exports = (builder) ->

    brand: (text, href) -> builder.a {class: 'brand', href: href}, text

    logo: (href, src, width = '', style = '') ->
        builder.a href: href, ->
            builder.img {class: 'brand', src: src, width: width, style: style}

    navbar: (inner) ->

        builder.div {class: 'navbar navbar-fixed'}, ->
            builder.div {class: 'navbar-inner'}, ->
                builder.div {class: 'container'}, inner

    link: (text, href, active = false) ->
        attrs = {}
        attrs.class = 'active' if active
        builder.li attrs, -> builder.a {href: href}, text

    nav:

        left: (inner) -> builder.ul {class: 'nav'}, inner
        right: (inner) -> builder.ul {class: 'nav pull-right'}, inner

    dropdown: (text, inner) ->
        builder.li {class: 'dropdown'}, ->
            builder.a {href: '#', class: 'dropdown-toggle', 'data-toggle': 'dropdown'}, ->
                builder.addText text
                builder.b {class: 'caret'}, ''
            builder.ul {class: 'dropdown-menu'}, inner

    divider: -> builder.li {class: 'vertical-divider'}
