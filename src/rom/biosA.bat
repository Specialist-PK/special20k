@del rom*.bin
@copy /b c000_loader.rom + c800_monitor.rom + sdos.bin rom.bin
srec_cat.exe -generate 0x1Bf0 0x1C00 -constant-l-e 0x0 4 rom.bin -binary -o rom_a.bin -binary	
srec_cat.exe -generate 0x200 0x400 -constant-l-e 0x0 4 loader.bin -binary -o loader_a.bin -binary	
@copy /b rom_a.bin + loader_a.bin rom_b.bin
@bin2mi.exe rom_b.bin rom_b.mi
pause