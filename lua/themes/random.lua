local color_schemes = [[
3024
apathy
ashes
atelier-cave-light
atelier-cave
atelier-dune-light
atelier-dune
atelier-estuary-light
atelier-estuary
atelier-forest-light
atelier-forest
atelier-heath-light
atelier-heath
atelier-lakeside-light
atelier-lakeside
atelier-plateau-light
atelier-plateau
atelier-savanna-light
atelier-savanna
atelier-seaside-light
atelier-seaside
atelier-sulphurpool-light
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
brushtrees
chalk
circus
classic-dark
codeschool
cupcake
darktooth
default-dark
darcula
dracula
eighties
embers
flat
fruit-soda
github
google-dark
grayscale-dark
greenscreen
gruvbox-dark-hard
gruvbox-dark-medium
gruvbox-dark-pale
gruvbox-dark-soft
gruvbox-light-hard
gruvbox-light-medium
gruvbox-light-soft
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
marrakesh
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
tomorrow
tube
twilight
unikitty-dark
woodland
xcode-dusk
zenburn
]]
local colors = {}
for i in string.gmatch(color_schemes, "[^\n]+") do
	if not string.match(i, "light") then
		table.insert(colors, i)
	end
end

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
	print("ColorScheme: "..selected)
	vim.cmd('colo base16-'..selected)
end

vim.api.nvim_set_keymap('n', '<leader>c', ':lua Return_Scheme()<CR>', {noremap=true})

Return_Scheme()
