<!-- AUTO-GENERADO por sdd estimation log (sdd-kit) — no editar a mano. Regenerar: sdd estimation log --root <proyecto> -->
# Estimation log (estimado vs real)

| Fecha | Id | Tipo | Est (h) | Real (h) | Ratio | Hilo (tokens) | Subagentes (tokens) | Sujetos ($) | Sesión ($) | Carpeta |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-11-25 | 0001 | patch | 0.1 | 0.17 | 1.7 | — | — | no aplica | — | 20261125-161949-patch-0001-smtp4dev-localhost-ports |
| 2026-11-25 | 0002 | patch | 0.3 | 0.23 | 0.77 | — | — | no aplica | — | 20261125-163129-patch-0002-cleanup-windows-only |
| 2026-11-25 | 0003 | patch | 0.3 | 0.12 | 0.4 | — | — | no aplica | — | 20261125-170712-patch-0003-localhost-domains |

**Factor de calibración** (ratio mediano real/estimado, 3 artefactos): **0.77** · media 0.96

- n insuficiente (hacen falta 5)
- Tendencia: n insuficiente (hacen falta 20)

| Tipo | n | Mediana | p25–p75 |
| --- | --- | --- | --- |
| patch | 3 | 0.77 | — |

| Release | Artefactos | Horas reales | Mediana | Sujetos ($) | Sesión ($) |
| --- | --- | --- | --- | --- | --- |
| 1.0.0 | 3 | 0.52 | 0.77 | — | — |

> Con menos de 10 tareas con ratio la calibración es orientativa. Ver `estimation.md`.

## Tiempos por fase

| Fase | n | Agente (h) | Ejecución (h) | Espera (h) | Gate (h) | % del trabajo | Ceremonia | Est (h) | Real (h) | Ratio |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| apertura | 3 | 0.43 | 0.15 | 6.2 | 0 | 39 % | sí | — | 0.57 | — |
| implementación | 3 | 0.05 | 0.02 | 0 | 0 | 5 % | no | — | 0.07 | — |
| cierre | 3 | 0.43 | 0.4 | 0.51 | 0 | 56 % | sí | — | 0.83 | — |

Ceremonia: — (0 tareas, 3 fuera por una fase sin eventos).
