module.exports = (builder) -> navbar =

    brand: (text, href) -> builder.a {class: 'brand', href: href}, text

    logo: (href, src, width = '', style = '') ->
        builder.a href: href, ->
            builder.img {class: 'brand', src: src, width: width, style: style}

    navbar: (style, inner) ->
        navClass = 'navbar'
        navClass += ' ' + style if style
        inner = style unless inner
        builder.div {class: navClass}, ->
            builder.div {class: 'navbar-inner'}, ->
                builder.div {class: 'container'}, inner

    link: (text, href, active = false) ->
        attrs = {}
        attrs.class = 'active' if active
        builder.li attrs, -> builder.a {href: href}, text

    nav:
        left: (inner) -> builder.ul {class: 'nav'}, inner
        right: (inner) -> builder.ul {class: 'nav pull-right'}, inner

    collapse: (inner) ->
        navbar.collapseButton '.nav-collapse'
        builder.div {class: 'nav-collapse'}, inner

    collapseButton: (target) ->
        builder.a class: 'btn btn-navbar', 'data-toggle': 'collapse', 'data-target': target, ->
            builder.span class: 'icon-bar', ''
            builder.span class: 'icon-bar', ''
            builder.span class: 'icon-bar', ''

    dropdown: (text, inner) ->
        builder.li {class: 'dropdown'}, ->
            builder.a {href: '#', class: 'dropdown-toggle', 'data-toggle': 'dropdown'}, ->
                builder.unsafe text
                builder.b {class: 'caret'}, ''
            builder.ul {class: 'dropdown-menu'}, inner

    divider: -> builder.li {class: 'vertical-divider'}
