This rice was made possible due to the maintainers and developers of flexipatch.
- Colorscheme : Catppuccin Mocha
- OS : arch btw
- Window Manager : DWM
- Terminal : SimpleTerminal(st) patched with alpha
- TopBar : dwmblocks-async (scripts at .local/bin)
- Compositor : picom (place .conf files at relative places)
- NeoVim config : thanks to claudeAI
- fonts : Iosevka nerd font
- DWM-Patches : vanitygaps, alpha, statuscmd, (find switched on patches in patches.h)
### !! Have Fun Trying These Dots !!



there is a possible issue where sometimes dwmblocks won't start on startup >> so open a terminal and run
dwmblocks &; disown $(pidof dwmblocks)
to fix this
