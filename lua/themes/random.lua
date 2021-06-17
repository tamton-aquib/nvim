local color_schemes = [[
3024
apathy
ashes
atelier-cave
atelier-dune
atelier-estuary
atelier-forest
atelier-heath
atelier-lakeside
atelier-plateau
atelier-savanna
atelier-seaside
atelier-sulphurpool
atlas
bespin
black-metal-bathory
black-metal-burzum
black-metal-dark-funeral
black-metal-gorgoroth
black-metal-immortal
black-metal-khold
black-metal-marduk
black-metal-mayhem
black-metal-nile
black-metal-venom
black-metal
brewer
bright
brogrammer
brogrammer2.0
brushtrees-dark
chalk
circus
classic-dark
codeschool
darktooth
default-dark
darcula
dracula
eighties
embers
flat
fruit-soda
google-dark
grayscale-dark
gruvbox-dark-hard
gruvbox-dark-medium
gruvbox-dark-pale
gruvbox-dark-soft
harmonic-dark
heetch
helios
hopscotch
horizon-dark
ia-dark
icy
irblack
isotope
macintosh
materia
material-darker
material-palenight
material-vivid
material
mellow-purple
mocha
monokai
nord
ocean
oceanicnext
onedark
outrun-dark
papercolor-dark
paraiso
phd
pico
pop
porple
railscasts
rebecca
schemer-dark
schemer-medium
seti
shapeshifter
snazzy
solarflare
solarized-dark
spacemacs
summerfruit-dark
synth-midnight-dark
tomorrow-night-eighties
tomorrow-night
tube
twilight
unikitty-dark
woodland
xcode-dusk
zenburn
]]
local colors = vim.split(color_schemes, "\n")

local schemes = {
	'onedark',
	'gruvbox-flat',
	'tokyonight',
	'sonokai'
}

function Return_Scheme()
	math.randomseed(os.clock())
	local nice = math.random() * #colors
	local selected = colors[math.floor(nice)+1]
	if selected == nil then selected = "onedark" end
	print("ColorScheme: "..selected)
	vim.cmd('colo base16-'..selected)
end

vim.api.nvim_set_keymap('n', '<leader>c', ':lua Return_Scheme()<CR>', {noremap=true})

