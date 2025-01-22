-- nvim-web-devicons
return {
    'nvim-tree/nvim-web-devicons',
    config = function()
        require('nvim-web-devicons').setup({
            default = true,
            override = {
                fish = {
                    icon = "🐟",
                    color = "#428850",
                    name = "Fish"
                }
            },
            strict = true,
            color_icons = true,
        })
    end
}

