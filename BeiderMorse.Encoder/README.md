# BeiderMorsePhoneticMatching
Implementation of the Beider Morse phonetic matching algorithm in C#

---

# Anwendung

Das Matching im Beider-Morse-System funktioniert in zwei Schritten:

---

## Schritt 1: Encoding erzeugt Alternativen

Der Encoder produziert **keine einzelne phonetische Repräsentation**, sondern einen String mit **mehreren Alternativen**, getrennt durch `|`:

```
"Smith" → "smit|xmit|zmit|spit|..."
"Schmitt" → "xmit|smit|zmit|..."
```

Intern sammelt `PhonemeBuilder` alle möglichen Lautfolgen in einem `ISet<Phoneme>` und gibt sie am Ende per `string.Join("|", ...)` aus ([PhonemeBuilder.cs:68](BeiderMorse.Encoder/PhonemeBuilder.cs)).

---

## Schritt 2: Matching = Schnittmenge der Alternativen

Ein **Match liegt vor, wenn mindestens eine Alternative aus beiden Mengen übereinstimmt**:

```csharp
var set1 = new HashSet<string>(encoder.Encode("Smith").Split('|'));
var set2 = new HashSet<string>(encoder.Encode("Schmitt").Split('|'));

bool isMatch = set1.Any(s => set2.Contains(s));
```

Das ist eine **Schnittmengenprüfung** — eine gemeinsame phonetische Alternative genügt.

---

## Besonderheiten bei mehrteiligen Namen

Bei `concat=false` (Vor- und Nachname getrennt) sind die Alternativen beider Namensteile mit `-` verbunden:

```
"Jean Marc" → "Zan-mark|Zan-marc|Yan-mark|..."
```

Das Matching funktioniert dann analog, aber die Segmente müssen paarweise verglichen werden.

---

## Regeltyp beeinflusst die Matching-Breite

| `RuleType` | Verhalten | Matching |
|---|---|---|
| `EXACT` | wenige, präzise Alternativen | enger, spezifischer |
| `APPROX` | viele, breitere Alternativen | großzügiger, toleranter |

---

**Fazit:** Der Encoder selbst enthält keine Matching-Logik — er liefert nur die Alternativmenge. Das eigentliche Matching passiert auf Anwendungsebene durch einen einfachen Schnittmengentest auf den pipe-getrennten Strings.
