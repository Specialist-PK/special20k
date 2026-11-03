# special20k

Экспериментальная реализация ПК «Специалист» на FPGA-плате Tang Nano 20k.

Проект предназначен для Gowin IDE и FPGA `GW2AR-LV18QN88C8/I7`. Верхний уровень находится в `src/top_level.v`, проект сборки — в `special20k.gprj`.

В исходниках представлены CPU `k580wm80a`, RAM/ROM/VRAM, HDMI, PS/2, ВВ55, ВИ53, SD, UART, SPI Flash и General Sound. Наличие блоков не означает подтверждённую полную совместимость с реальным «Специалистом»; состояние проверок и ограничения фиксируются в документации.

## Документация

- [Архитектура](docs/architecture.md) — тактирование, карта адресов, память, видео, звук и периферия.
- [Дорожная карта](docs/roadmap.md) — воспроизводимая сборка, симуляция, проверка на плате и релизы.

## Связанные проекты

- [specialist-emulator](https://github.com/Specialist-PK/specialist-emulator) — кроссплатформенный программный эмулятор.
- [Specialist-PK](https://github.com/Specialist-PK) — профиль и общие документы организации.

При использовании ИИ соблюдайте [политику организации](https://github.com/Specialist-PK/.github/blob/main/AI_POLICY.md).
