#!/bin/bash

echo "🔍 Cercando riferimenti corrotti a 'Icon?'..."

# Rimozione file tag locale
if [ -f .git/refs/tags/Icon? ]; then
  echo "🧹 Rimuovendo .git/refs/tags/Icon?"
  rm -f ".git/refs/tags/Icon?"
fi

# Pulizia del file packed-refs
PACKED_REFS=".git/packed-refs"
if [ -f "$PACKED_REFS" ]; then
  echo "🧼 Pulizia di $PACKED_REFS"
  cp "$PACKED_REFS" "$PACKED_REFS.bak"  # backup di sicurezza
  grep -v 'refs/tags/Icon?' "$PACKED_REFS.bak" > "$PACKED_REFS"
fi

# Pulizia log residui
if [ -f .git/logs/refs/tags/Icon? ]; then
  echo "🧹 Rimuovendo .git/logs/refs/tags/Icon?"
  rm -f ".git/logs/refs/tags/Icon?"
fi

# Verifica finale
echo "🔁 Verifica finale:"
git show-ref --tags

echo "✅ Completato. Se l’errore persiste, potrebbe trattarsi di un ref in HEAD o reflog."