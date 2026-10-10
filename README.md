# Data Science & Business Intelligence

Fristående huvudspår på svenska, indelat i block om sju studiedagar. Ingen koppling till kalenderveckor. En studiedag kan fördelas över flera tillfällen.

## Filer

- `huvudspar.tex`: syfte, progression, arbetssätt och mall för kommande block.
- `block-001.tex`: Dag 1–7 med teori, övningar, kontrollfrågor och facit.
- `data/forsaljning.csv`: gemensamma övningsdata, semikolonseparerade och UTF-8.
- `Init-Git.ps1`: initierar ett lokalt Git-repository med huvudgrenen `main`.
- `Connect-GitHub.ps1`: kopplar ett befintligt GitHub-repository som `origin`.

Båda LaTeX-filerna är självständiga. Ladda upp dem i Overleaf och välj den fil du vill kompilera som huvuddokument, eller kör `pdflatex huvudspar.tex` respektive `pdflatex block-001.tex` två gånger med en lokal LaTeX-installation. Källfilerna är UTF-8.

## Projektkatalog

Använd `C:\dev\DataScience-BI` som projektrot och öppna PowerShell där. Lägg inte Git-roten i hela Documents eller hela Codex-katalogen.

```powershell
Set-Location 'C:\dev\DataScience-BI'
.\Init-Git.ps1
git status
git add .gitignore README.md huvudspar.tex block-001.tex data/forsaljning.csv Init-Git.ps1 Connect-GitHub.ps1
git diff --cached
git commit -m "Lägg till huvudspår och Block 001"
```

Git behöver ditt namn och din e-postadress för commits. Om de saknas, ange dina riktiga uppgifter lokalt i detta repository med `git config user.name` och `git config user.email`.

Skapa ett tomt repository på GitHub, utan automatisk README eller licens, och använd dess verkliga adress:

```powershell
.\Connect-GitHub.ps1 -RepositoryUrl 'https://github.com/DITT-KONTO/DataScience-BI.git'
git push -u origin main
```

Adressen ovan är en platshållare. GitHub-autentisering hanteras av din Git-installation. Skripten ändrar inte PowerShells körningspolicy, skapar inte GitHub-repository och gör inte automatiskt commit eller push. Om GitHub-repositoryt redan innehåller filer behöver dess historik först samordnas med den lokala historiken; använd inte force-push.

## Nästa block

Kopiera blockets pedagogiska struktur till `block-002.tex`, byt mål och övningar och behåll sju studiedagar. Spara egna arbetsfiler separat från facit. Undvik att lägga personuppgifter eller privata arbetsdata i Git.

